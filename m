Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101B2C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:38:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D081220857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tnHALFk1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D081220857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=scratchpost.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=goqNlYuUPUQ2Cg/NtApBle4mZvhbDtgvpVavI+NRaao=; b=tnHALFk1XyCP2a
	v5KrcRAauqBOLhWfEEbAtRc7F2Lgm1GjtvF3SwRHYlPoEB6ru9g2Uq3bg6NxOt2dCl/9HRwUc4K6t
	NblMd41ndi1lEfdDDlZESF2FWORtDeG9iouPyk+dyxKJiBYaZC0jMnQnL7DBDtEuAklc7Ky/JDp36
	22XSElQsIl9uiT4UxQ7TFk9CtqwI+Wcj2nYUZJWDxOfx4RNwW0i1gK6/SYofsXIpvTwofOo6rORa4
	A/x68DSV0QFoaH918x5TRpIX+PVf4/nUeeCIfYbqza2O0lBEMYIeKFlIEUBoO4ctetP8qEQFE/2Na
	J0JjXuW4uKJdSZgEvuTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gor0D-00037N-4S; Wed, 30 Jan 2019 14:38:09 +0000
Received: from dd26836.kasserver.com ([85.13.145.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goqy7-00019F-3g
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 14:36:09 +0000
Received: from dayas.3.home (77.116.173.211.wireless.dyn.drei.com
 [77.116.173.211])
 by dd26836.kasserver.com (Postfix) with ESMTPSA id 8240433609B4;
 Wed, 30 Jan 2019 15:25:57 +0100 (CET)
From: Danny Milosavljevic <dannym@scratchpost.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Danny Milosavljevic <dannym@scratchpost.org>, alsa-devel@alsa-project.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v15 0/8] ASoC: sun4i-codec: Add Line-In, FM-In, Mic 2
Date: Wed, 30 Jan 2019 11:39:36 +0100
Message-Id: <20190130103945.26692-1-dannym@scratchpost.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Tags: patch
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_063559_610698_252D93F0 
X-CRM114-Status: GOOD (  12.14  )
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

This patchset adds some mixer controls to sun4i-codec for the Allwinner A10
and the Allwinner A20.

It also adds the PGA for the MIC2 preamp.

Where possible, it uses SOC_DAPM_DOUBLE in order to cut down on the number
of distinct controls in alsamixer.

v15 changes compared to v14 are:
 - Instead of adding controls dynamically, add an extra sun7i_codec_controls
   structure and duplicate the sun4i_codec_controls there, with small changes.
 - Split Mic Playback Volume into extra patch.
 - LEFT OFF adding Capture Selects since it's unclear how we want to structure
   it.
 - LEFT OFF adding Differential Line Source since it might also change if the
   Capture Select implementation is different.

v14 changes compared to v13 are:
 - Merged some of the patches together if it made sense to test them together.
 - Use snd_soc_component_driver.
 - Moved SUN4I_CODEC_DAC_ACTL_LFMS, SUN4I_CODEC_DAC_ACTL_RFMS to the correct
   patch in the series.
 - Kept "Left Mixer Left DAC Playback Switch", "Right Mixer Left DAC
   Playback Switch" and "Right Mixer Right DAC Playback Switch" unchanged
   compared to the released version - for backward compatibility.

v13 changes compared to v12 are:
 - Added my "Signed-off-by".
 - Clarified some commit message text.

v12 changes compared to v11 are:
 - Split up patchset in another way.
 - Renamed "Mic1 Capture Volume" to "Mic1 Boost Volume".
 - Renamed "Mic2 Capture Volume" to "Mic2 Boost Volume".
 - Renamed "Line Capture Volume" to "Line Boost Volume".
 - Renamed "Differential Line Capture Switch" to "Differential Line Source".

v11 changes compared to v10 are:
 - Split up patchset.
 - Fixed typo in Differential Line Capture Switch.
 - Renamed "Non-Differential" value to "Stereo".
 - Removed duplicate PA Volume mixer control.

v10 changes compared to v9 are:
 - Use SOC_DAPM_DOUBLE where possible and it makes sense in order to cut
   down on the number of controls.

v9 changes compared to v8 are:
 - added Line Differential Capture Switch.
 - split Capture Source into Left Capture Select, Right Capture Select.
 - added Line Capture Volume.
 - rename "sun4i_codec_widgets" to "sun4i_codec_controls" for
   consistency with the struct field it's used in.
 - rename "Line-In" to "Line".
 - rename "Power Amplifier Playback Volume" to "Headphone Playback Volume".

v8 changes compared to v7 are:
 - fixed the routes for line and mic capturing.

v7 changes compared to v6 are:
 - preparation for different A20, A10 controls is now in an extra patch.
 - all register definitions are now at the top.
 - sun7i-specific things (A20-specific things) are now less
   grouped-together.
 - rename "Power Amplifier Volume" to "Power Amplifier Playback Volume".

v6 changes compared to v5 are:
 - Mic preamplifier special cases for A20 and A10 now are now not
   icky: There are two different _widget arrays and the probe() function
   now selects the right one to pass to snd_soc_register_codec() unmodified.
 - sun7i-specific things (A20-specific things) are now grouped together.

v5 changes compared to v4 are:
 - Mic preamplifier controls have more common names now.
 - Mic preamplifier scale has a 0 dB entry as well now, as documented in the
   A20 user manual.
 - Mic preamplifier has special cases for A20 and A10 now.
 - Gain controls have "Gain" in the name now.

v4 changes compared to v3 are:
 - names of the input are not uppercase anymore.
 - bit index constants are now named as in the A20 user manual v1.4.
 - added Mic1-In, Mac2-In.
 - added Mic1 and Mic2 Pre-Amplifiers.

v3 changes compared to v2 are:
 - added DAPM routes.

v2 changes compared to v1 are:
 - moved Line-In and FM-In playback switches to their respective
   sun4i_codec_*_mixer_controls.

v1 changes:
 - added linein, fmin output volumes and switches.

Danny Milosavljevic (8):
  ASoC: sun4i-codec: Add MIC2 Pre-Amplifier, Mic2
  ASoC: sun4i-codec: Add Mic Playback Volume
  ASoC: sun4i-codec: Add sun7i_codec_controls, sun7i_codec_codec.
  ASoC: sun4i-codec: Add Mic1 Boost Volume, Mic2 Boost Volume
  ASoC: sun4i-codec: Merge sun4i_codec_left_mixer_controls and
    sun4i_codec_right_mixer_controls into sun4i_codec_mixer_controls
  ASoC: sun4i-codec: Add Mic1 Playback Switch, Mic2 Playback Switch
  ASoC: sun4i-codec: Add FM Playback Volume, FM Left, FM Right, FM
    Playback Switch
  ASoC: sun4i-codec: Add Line Playback Volume, Line Boost Volume, Line
    Right, Line Left, Line Playback Switch

 sound/soc/sunxi/sun4i-codec.c | 149 ++++++++++++++++++++++++++++++----
 1 file changed, 134 insertions(+), 15 deletions(-)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
