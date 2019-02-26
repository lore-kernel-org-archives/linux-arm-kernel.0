Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518A2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:23:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21BB22184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bq1qdvVY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="PjhNqiCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BB22184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:
	In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=OMTnoVg8GazzT6UE2kQm1i6luIHn8FU0T1+ng4rLcH8=; b=Bq1
	qdvVYZXvzxzV2b9U5QbNgBm1m9lV/YyRTbNWoatPObEKl6YR6UB+MIALVog32VlNX+vo4huLRPC74
	PN+7CBSSPrjnsDmqHm64qqM8FIBDc90iKgPHkY09Kh4nmxQfueFwH4rpG8DAdwD3LQGKiDDNDXXPI
	WSgOG2Mvowud4N1gj+AwqhOngUp4CGT9fM+Z2dLX+SRkZdUWGX3bdg4K2XDkcWN9zvEdx1kn5P0nX
	GziABb9mVE6EBtwUHzKB0YYzAB1w8UQq1xv27ON6OGicpbO0rCzNK5byJ4XPaOgloaI0OsfrWzwvp
	Ldo4PN/J7rzOEtF558jZRusc9XMvofA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyfVV-0000xm-5i; Tue, 26 Feb 2019 16:23:01 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyfV6-0000Vz-5X
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 16:22:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=iBKPSsrkqD/I+NqUT441hOMdauH7N07h2jjHLfK+AnI=; b=PjhNqiCtrUbf
 2pr++4miFO197tNqqM5+bhkF93HKL4Uf8HAhYZcJxdviZLTjMEr62EffZV2yyLI0lbhMewf7SOIqQ
 7NkUa9Tq7NjqlTTmzUBVawUxXN9O3psRYo4MAKwS4DJgwvzB72rwAlh1sngbp7HhtcWiOJx17M/fa
 iaA3o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gyfUv-000091-Mt; Tue, 26 Feb 2019 16:22:25 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 3DC5E1121A0A; Tue, 26 Feb 2019 16:22:25 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Olivier Moysan <olivier.moysan@st.com>
Subject: Applied "ASoC: stm32: i2s: fix race condition in irq handler" to the
 asoc tree
In-Reply-To: <1551189070-15469-7-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190226162225.3DC5E1121A0A@debutante.sirena.org.uk>
Date: Tue, 26 Feb 2019 16:22:25 +0000 (GMT)
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_082236_350294_E23E98FF 
X-CRM114-Status: GOOD (  14.67  )
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

   ASoC: stm32: i2s: fix race condition in irq handler

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

From 3005decf4fe43e65d882dce838716bd6715757c1 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Tue, 26 Feb 2019 14:51:09 +0100
Subject: [PATCH] ASoC: stm32: i2s: fix race condition in irq handler

When snd_pcm_stop_xrun() is called in interrupt routine,
substream context may have already been released.
Add protection on substream context.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_i2s.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 9edb753ffa1b..42ce87a35104 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -201,6 +201,7 @@ enum i2s_datlen {
  * @base:  mmio register base virtual address
  * @phys_addr: I2S registers physical base address
  * @lock_fd: lock to manage race conditions in full duplex mode
+ * @irq_lock: prevent race condition with IRQ
  * @dais_name: DAI name
  * @mclk_rate: master clock frequency (Hz)
  * @fmt: DAI protocol
@@ -222,6 +223,7 @@ struct stm32_i2s_data {
 	void __iomem *base;
 	dma_addr_t phys_addr;
 	spinlock_t lock_fd; /* Manage race conditions for full duplex */
+	spinlock_t irq_lock; /* used to prevent race condition with IRQ */
 	char dais_name[STM32_I2S_DAI_NAME_SIZE];
 	unsigned int mclk_rate;
 	unsigned int fmt;
@@ -263,8 +265,10 @@ static irqreturn_t stm32_i2s_isr(int irq, void *devid)
 	if (flags & I2S_SR_TIFRE)
 		dev_dbg(&pdev->dev, "Frame error\n");
 
-	if (err)
+	spin_lock(&i2s->irq_lock);
+	if (err && i2s->substream)
 		snd_pcm_stop_xrun(i2s->substream);
+	spin_unlock(&i2s->irq_lock);
 
 	return IRQ_HANDLED;
 }
@@ -540,9 +544,12 @@ static int stm32_i2s_startup(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *cpu_dai)
 {
 	struct stm32_i2s_data *i2s = snd_soc_dai_get_drvdata(cpu_dai);
+	unsigned long flags;
 	int ret;
 
+	spin_lock_irqsave(&i2s->irq_lock, flags);
 	i2s->substream = substream;
+	spin_unlock_irqrestore(&i2s->irq_lock, flags);
 
 	ret = clk_prepare_enable(i2s->i2sclk);
 	if (ret < 0) {
@@ -673,13 +680,16 @@ static void stm32_i2s_shutdown(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *cpu_dai)
 {
 	struct stm32_i2s_data *i2s = snd_soc_dai_get_drvdata(cpu_dai);
-
-	i2s->substream = NULL;
+	unsigned long flags;
 
 	regmap_update_bits(i2s->regmap, STM32_I2S_CGFR_REG,
 			   I2S_CGFR_MCKOE, (unsigned int)~I2S_CGFR_MCKOE);
 
 	clk_disable_unprepare(i2s->i2sclk);
+
+	spin_lock_irqsave(&i2s->irq_lock, flags);
+	i2s->substream = NULL;
+	spin_unlock_irqrestore(&i2s->irq_lock, flags);
 }
 
 static int stm32_i2s_dai_probe(struct snd_soc_dai *cpu_dai)
@@ -874,6 +884,7 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 	i2s->pdev = pdev;
 	i2s->ms_flg = I2S_MS_NOT_SET;
 	spin_lock_init(&i2s->lock_fd);
+	spin_lock_init(&i2s->irq_lock);
 	platform_set_drvdata(pdev, i2s);
 
 	ret = stm32_i2s_dais_init(pdev, i2s);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
