Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A68C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:22:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B582173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bHtAR7iV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="E24oNwVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B582173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:
	In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=4rfvmWWfMk9DTh46BjU3Ae6s4iCx6MY5GpAjV6vSk+Q=; b=bHt
	AR7iVEXmH+lX01WYRByXWGISfURQcv22O8ZvmmjkqjUA4Wgv9RT5mAjwazQ4phVoGaDEbddyc1/F8
	yweGQstwAkFCt4xVcUffrdLrBwDrSafnBesWEjv/57auKkGtPWhksbmHb2MlI2y0uRdGodNXGXJsG
	1Z3eZ+9pW3+POUfgKtQfp2WCsP4WAf32tUC0nj5AvEV5PXDdjIHsQTxYGzG16fEHS0FNcOB+KmsXn
	2QuqP4SbyN4PCOPnj/bNM9WfX6FMzTI+KmgBzil+j8hsyEQ24zMCAJ+5A2dTLcy+JxzvtV3JeGTJg
	F+TWMTz/NPpy5h2S3CnndDNYxRKtJJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyfV8-0000XU-Vd; Tue, 26 Feb 2019 16:22:38 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyfV5-0000Vx-Pv
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 16:22:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=mnWqHPJclcMEs49esAMEspmjEvj1m86Q3pQOg+Shl2s=; b=E24oNwVzh8US
 4S24B6LCZAg6LYs5+6fEfms3YSdOhJ1tbRXI8BO0LQTJmfGIzxPKpFoSecFhPFxuyaetFVfeC5Nf6
 tDRzJc2M+X0zb3uR4SAaKDFaOOxjLcYjHPQGFjsDF1EVRrqIiGwmCyieKeO+p27cTgjEKx/LHdxRH
 /kGDI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gyfUt-00008v-In; Tue, 26 Feb 2019 16:22:23 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 0EDC21121A0A; Tue, 26 Feb 2019 16:22:23 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Olivier Moysan <olivier.moysan@st.com>
Subject: Applied "ASoC: stm32: i2s: skip useless write in slave mode" to the
 asoc tree
In-Reply-To: <1551189070-15469-8-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190226162223.0EDC21121A0A@debutante.sirena.org.uk>
Date: Tue, 26 Feb 2019 16:22:23 +0000 (GMT)
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_082235_982410_C094B33C 
X-CRM114-Status: GOOD (  13.61  )
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
Cc: alsa-devel@alsa-project.org, olivier.moysan@st.com, alexandre.torgue@st.com,
 linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com, tiwai@suse.com,
 lgirdwood@gmail.com, broonie@kernel.org, mcoquelin.stm32@gmail.com,
 perex@perex.cz, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The patch

   ASoC: stm32: i2s: skip useless write in slave mode

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 7b6b0049e2b70d103adf1b7d0320802f70ddceca Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Tue, 26 Feb 2019 14:51:10 +0100
Subject: [PATCH] ASoC: stm32: i2s: skip useless write in slave mode

Dummy write in capture master mode is used to gate
bus clocks. This write is useless in slave mode
as the clocks are not managed by slave.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 42ce87a35104..47c334de6b09 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -623,8 +623,8 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 		} else {
 			ier = I2S_IER_OVRIE;
 
-			if (i2s->refcount == 1)
-				/* dummy write to trigger capture */
+			if (STM32_I2S_IS_MASTER(i2s) && i2s->refcount == 1)
+				/* dummy write to gate bus clocks */
 				regmap_write(i2s->regmap,
 					     STM32_I2S_TXDR_REG, 0);
 		}
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
