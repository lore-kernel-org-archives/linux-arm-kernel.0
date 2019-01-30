Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC5FC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:36:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF4620857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TeFZK/QU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF4620857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=scratchpost.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2TdnPvUDpDiTICoxYjRkZHytH76fRIYNMCa73rirdhM=; b=TeFZK/QUd3FN2V
	NF9nA5v+0H+cdwYV5vg4VmxMBXnYJyMezhIbLmn5eiD6Z/i6DLPcdTnCVYUyzm/S70RDU9oa4kGoE
	acMlGaLk2IGWQovxq+wgpifNORB4NQ9GkDCfZO4Uk7c7UP3nQac649XK3o+O1gl5IStJyDuCAdox1
	efNBZsxVmRHlcNR6BSElcfXwx+MdH7vFR75rW2hw3Zv8AgEtrElo7dX3sd8u+RJQy+oJSnw22D/js
	I7933FxyVNBToz2SCrvCFGZQQ0/FpCOWL77UUeej/Vmm4JU8V8D07MIaYw47GvLHFhsyfCNlbE7pD
	IbDxR9+FbaiVvVSNLrbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goqyx-0001u9-Bh; Wed, 30 Jan 2019 14:36:51 +0000
Received: from dd26836.kasserver.com ([85.13.145.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goqy4-00018X-FS
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 14:35:59 +0000
Received: from dayas.3.home (77.116.173.211.wireless.dyn.drei.com
 [77.116.173.211])
 by dd26836.kasserver.com (Postfix) with ESMTPSA id 50619336394D;
 Wed, 30 Jan 2019 15:26:10 +0100 (CET)
From: Danny Milosavljevic <dannym@scratchpost.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Danny Milosavljevic <dannym@scratchpost.org>, alsa-devel@alsa-project.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v15 5/8] ASoC: sun4i-codec: Merge
 sun4i_codec_left_mixer_controls and sun4i_codec_right_mixer_controls into
 sun4i_codec_mixer_controls
Date: Wed, 30 Jan 2019 11:39:41 +0100
Message-Id: <20190130103945.26692-6-dannym@scratchpost.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130103945.26692-1-dannym@scratchpost.org>
References: <20190130103945.26692-1-dannym@scratchpost.org>
MIME-Version: 1.0
Tags: patch
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_063556_866193_59A794D8 
X-CRM114-Status: UNSURE (   9.56  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Since it's now possible to have a DAPM mixer control with multiple
channels, use it to cut down the total number of controls.

Keep "Left Mixer Left DAC Playback Switch" and "Right Mixer Right DAC
Playback Switch" name & layout the same as before for compatibility.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 9d509ede2..279a7880d 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -718,15 +718,15 @@ static const struct snd_kcontrol_new sun7i_codec_controls[] = {
 		       sun7i_codec_micin_preamp_gain_scale),
 };
 
-static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
-			SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),
-};
-
-static const struct snd_kcontrol_new sun4i_codec_right_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Right DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
-			SUN4I_CODEC_DAC_ACTL_RDACRMIXS, 1, 0),
-	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
+static const struct snd_kcontrol_new sun4i_codec_mixer_controls[] = {
+	SOC_DAPM_SINGLE("Left Mixer Left DAC Playback Switch",
+			SUN4I_CODEC_DAC_ACTL, SUN4I_CODEC_DAC_ACTL_LDACLMIXS,
+			1, 0),
+	SOC_DAPM_SINGLE("Right Mixer Right DAC Playback Switch",
+			SUN4I_CODEC_DAC_ACTL, SUN4I_CODEC_DAC_ACTL_RDACRMIXS,
+			1, 0),
+	SOC_DAPM_SINGLE("Right Mixer Left DAC Playback Switch",
+			SUN4I_CODEC_DAC_ACTL,
 			SUN4I_CODEC_DAC_ACTL_LDACRMIXS, 1, 0),
 };
 
@@ -762,11 +762,11 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 
 	/* Mixers */
 	SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
-			   sun4i_codec_left_mixer_controls,
-			   ARRAY_SIZE(sun4i_codec_left_mixer_controls)),
+			   sun4i_codec_mixer_controls,
+			   ARRAY_SIZE(sun4i_codec_mixer_controls)),
 	SND_SOC_DAPM_MIXER("Right Mixer", SND_SOC_NOPM, 0, 0,
-			   sun4i_codec_right_mixer_controls,
-			   ARRAY_SIZE(sun4i_codec_right_mixer_controls)),
+			   sun4i_codec_mixer_controls,
+			   ARRAY_SIZE(sun4i_codec_mixer_controls)),
 
 	/* Global Mixer Enable */
 	SND_SOC_DAPM_SUPPLY("Mixer Enable", SUN4I_CODEC_DAC_ACTL,
@@ -808,12 +808,12 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 
 	/* Right Mixer Routes */
 	{ "Right Mixer", NULL, "Mixer Enable" },
-	{ "Right Mixer", "Left DAC Playback Switch", "Left DAC" },
-	{ "Right Mixer", "Right DAC Playback Switch", "Right DAC" },
+	{ "Right Mixer", "Right Mixer Left DAC Playback Switch", "Left DAC" },
+	{ "Right Mixer", "Right Mixer Right DAC Playback Switch", "Right DAC" },
 
 	/* Left Mixer Routes */
 	{ "Left Mixer", NULL, "Mixer Enable" },
-	{ "Left Mixer", "Left DAC Playback Switch", "Left DAC" },
+	{ "Left Mixer", "Left Mixer Left DAC Playback Switch", "Left DAC" },
 
 	/* Power Amplifier Routes */
 	{ "Power Amplifier", "Mixer Playback Switch", "Left Mixer" },

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
