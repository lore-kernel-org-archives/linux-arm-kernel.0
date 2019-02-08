Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B59DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:11:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DBCE2177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ic8HqdwE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="QZ+KcbJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DBCE2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:
	In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=cP3IMiVTLhSbhgddDc4BTvz04iHFDHDVKgIxsJtE9jc=; b=Ic8
	HqdwE+0fXIsB6pnccawsXtDoo5jrt5+EWpvXyY/q2nerZ7iYp9x2Mb2QfhROuugjAGBwg30xOxvoL
	Xq5HuOtCfqVQKvr9Yw1Ii4v2vAoKZu70g227/bjIFbtqCOE+RkEv4ixpVtZOJpJhKc2zEyqmU1lRO
	N0TwsovD5l4Ph3PgsCL5lvaQGnFiL/eb39FUYXlqRISo+b2lOGIqAV8iNOIabzYaykMM92LkWtMWE
	llEr7QbALkmUUrMQuy6WAnLMD/P+8XQjIRUsl4KsPyYhYRidGn159P9zBMDRQ/tW0JsVXcrhq3qEp
	DuyiLSfG4362ngKNJ0KK17ghwWKThBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5w8-0007B7-Fg; Fri, 08 Feb 2019 13:11:20 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5w3-00079f-VK
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 13:11:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=EiIrpbKtRrtKbnRnQEu849eNL9UnFqfXEdpzWHPHkeE=; b=QZ+KcbJVLWs0
 GPDo4HxQSsuugnbjNmb0Wy4wZihTNDNlrVTSQePDHK/P8soNadsQSUIxCV7bZQOV6TjL8N9qo7UxA
 VmtLVq8CTg61d+XySZv2zBvHeHrEEH9hJN1qe27jqwOs9ssrfPP8mlRG6Qik9L6oOETJYekv4QBxT
 yfkSc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gs5vv-0001JQ-Us; Fri, 08 Feb 2019 13:11:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 813F71127F30; Fri,  8 Feb 2019 13:11:07 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Olivier Moysan <olivier.moysan@st.com>
Subject: Applied "SoC: stm32: i2s: manage clock power" to the asoc tree
In-Reply-To: <1549622994-13810-3-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190208131107.813F71127F30@debutante.sirena.org.uk>
Date: Fri,  8 Feb 2019 13:11:07 +0000 (GMT)
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_051116_149648_8B2BD802 
X-CRM114-Status: GOOD (  16.20  )
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

   SoC: stm32: i2s: manage clock power

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

From 6a68eeee0f03ab371bec7a719795f69b05be183f Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Fri, 8 Feb 2019 11:49:54 +0100
Subject: [PATCH] SoC: stm32: i2s: manage clock power

Kernel clock management:
Enable/disable I2S kernel clock on audio stream startup/shutdown.

Peripheral clock management:
Manage I2S peripheral clock power through regmap services.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_i2s.c | 44 +++++++++++++--------------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index dbe23a709d24..a25919d32187 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -545,9 +545,16 @@ static int stm32_i2s_startup(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *cpu_dai)
 {
 	struct stm32_i2s_data *i2s = snd_soc_dai_get_drvdata(cpu_dai);
+	int ret;
 
 	i2s->substream = substream;
 
+	ret = clk_prepare_enable(i2s->i2sclk);
+	if (ret < 0) {
+		dev_err(cpu_dai->dev, "Failed to enable clock: %d\n", ret);
+		return ret;
+	}
+
 	spin_lock(&i2s->lock_fd);
 	i2s->refcount++;
 	spin_unlock(&i2s->lock_fd);
@@ -674,6 +681,8 @@ static void stm32_i2s_shutdown(struct snd_pcm_substream *substream,
 
 	regmap_update_bits(i2s->regmap, STM32_I2S_CGFR_REG,
 			   I2S_CGFR_MCKOE, (unsigned int)~I2S_CGFR_MCKOE);
+
+	clk_disable_unprepare(i2s->i2sclk);
 }
 
 static int stm32_i2s_dai_probe(struct snd_soc_dai *cpu_dai)
@@ -874,49 +883,26 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	i2s->regmap = devm_regmap_init_mmio(&pdev->dev, i2s->base,
-					    i2s->regmap_conf);
+	i2s->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "pclk",
+						i2s->base, i2s->regmap_conf);
 	if (IS_ERR(i2s->regmap)) {
 		dev_err(&pdev->dev, "regmap init failed\n");
 		return PTR_ERR(i2s->regmap);
 	}
 
-	ret = clk_prepare_enable(i2s->pclk);
-	if (ret) {
-		dev_err(&pdev->dev, "Enable pclk failed: %d\n", ret);
-		return ret;
-	}
-
-	ret = clk_prepare_enable(i2s->i2sclk);
-	if (ret) {
-		dev_err(&pdev->dev, "Enable i2sclk failed: %d\n", ret);
-		goto err_pclk_disable;
-	}
-
 	ret = devm_snd_soc_register_component(&pdev->dev, &stm32_i2s_component,
 					      i2s->dai_drv, 1);
 	if (ret)
-		goto err_clocks_disable;
+		return ret;
 
 	ret = devm_snd_dmaengine_pcm_register(&pdev->dev,
 					      &stm32_i2s_pcm_config, 0);
 	if (ret)
-		goto err_clocks_disable;
+		return ret;
 
 	/* Set SPI/I2S in i2s mode */
-	ret = regmap_update_bits(i2s->regmap, STM32_I2S_CGFR_REG,
-				 I2S_CGFR_I2SMOD, I2S_CGFR_I2SMOD);
-	if (ret)
-		goto err_clocks_disable;
-
-	return ret;
-
-err_clocks_disable:
-	clk_disable_unprepare(i2s->i2sclk);
-err_pclk_disable:
-	clk_disable_unprepare(i2s->pclk);
-
-	return ret;
+	return regmap_update_bits(i2s->regmap, STM32_I2S_CGFR_REG,
+				  I2S_CGFR_I2SMOD, I2S_CGFR_I2SMOD);
 }
 
 static int stm32_i2s_remove(struct platform_device *pdev)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
