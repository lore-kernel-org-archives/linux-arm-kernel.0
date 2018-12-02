Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AA1C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:24:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC1D20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pskxUJRd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeuDo4/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC1D20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=rS0oz+eEglqMLwSVP7kX++yBd248WKKfTtnPUvcgNkQ=; b=pskxUJRdzPc/FndEHuLCsAETMo
	RPzlvTzhtb6hpoplikSKG0ox9wzc6csgxmMZIYcEiG7BcHO2v2E1F3zS5hBY0n6y0Un9q11JBBXcx
	mXshhpcFJToNfLKs9Cb5oJbsSy19lKN48qdcFnlOQwjZ3WsmqDPzkrKkBIzrX+NY951eEVZFFqI5y
	rlqiAn504mqas7FjrQQT26tCqKuIpshoLbUAwuxZR2QWyTcJEXkeBXEcpRmneBKrT237qECT66yhP
	D1p64rbin40h0oUIbjZLHWH3Le0P8+m0jOk1bMB101R6eK5m/UE+4SEf1aje/mOyDHdMuUOnZqozY
	hSJCmuVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZED-0002rz-M2; Sun, 02 Dec 2018 21:24:37 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZDN-0001tU-In
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 21:23:59 +0000
Received: by mail-wr1-x444.google.com with SMTP id l9so10129299wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 13:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=LxSavWoE8Yxdkqsv4iql+rrJjUWG8e+jEwsaaQv7ecE=;
 b=YeuDo4/O4PDtk1zfrh/LnSu7GfNR//WyPXJg3RpKFGr9zDQclI6lbvoSaBKKRcnQuk
 GCkrq/3qPB+upVLfdM8W67mKo0XYB1K0lRXfqgkauBIF3QntDpqzhtnJ/sCVmOGqGzT7
 GR0r2ixfNhVPDzLSZauJxBKap/VwdeM5HRewESIqAUDzHRPPfFxYXBPm+7TbNzibo2pS
 9HQXxCl4r3n2Y+uA0+/Fby+OYO9thZ/5WQv8L4NZoCqnp4uc5tbq3ZKDJ+y/+6tooU+y
 EZfGwJPSHrDKUBiSFV9aHQrK00y9V6FFmXD8b8pLqiM7jEAqGrpNi+msvdONfBW9nGzW
 a8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=LxSavWoE8Yxdkqsv4iql+rrJjUWG8e+jEwsaaQv7ecE=;
 b=VJzfcGfivTKwsxbL7jTOCHYxisaa3YRVZG0gbvF2Iygp0rEf20Hr9qnqXwedF3PCfy
 iiBeXHLoyhztPhJr9abvuoQF1yLrZGvdLSJi9JbzfHYXD1qZTUJBvrnfUU4TuBin7pVk
 XEMAqekcFC/CzOfSrIQg/ManmNBgglPpkIRszPnH24NGhSBXK7xuk/721Kc0uNwMMd8u
 v0T+HkHe17o1OqobQx8KqUHob0yNklFtnLNB7I99/tDrrL3v0OFHtaDJgn2UCjZz5MZx
 dfAZ6xCSScmp9kYgO2YY7DoA0dzLZj9n8oR/f35XV16NrPALRnszm+ovHdy0ZN0NtSqH
 Dl0w==
X-Gm-Message-State: AA+aEWYWELTAFNyyrTx2sQIu/+dM7Vz7OZLI+mYKbYC5WMz6ugiLN8t9
 DRKHBRDf1kpqNcUDdu4Os2c=
X-Google-Smtp-Source: AFSGD/WIyfnqdaTRCuqsiBGBI9SRL7+zHImZHnXs90EIWGZ8f28UAQoHaBhHt+Tlx3PzneR3fDIj8Q==
X-Received: by 2002:a5d:4046:: with SMTP id w6mr12463863wrp.92.1543785812199; 
 Sun, 02 Dec 2018 13:23:32 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id d2sm9551043wrs.97.2018.12.02.13.23.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 13:23:31 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com
Subject: [RFC PATCH 01/10] dma-engine: sun4i: Add a quirk to support different
 chips
Date: Mon,  3 Dec 2018 00:23:08 +0300
Message-Id: <864e28404a31ba24094f74fd060d11c16562e965.1543782328.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543782328.git.mesihkilinc@gmail.com>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_132345_900384_298D6B1F 
X-CRM114-Status: GOOD (  21.18  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Mesih Kilinc <mesihkilinc@gmail.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Allwinner suniv F1C100s has similar DMA engine to sun4i. Several
registers has different addresses. Total dma channels, endpoint counts
and max burst counts are also different.

In order to support F1C100s add a quirk structure to hold IC specific
data.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 drivers/dma/sun4i-dma.c | 138 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 106 insertions(+), 32 deletions(-)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index f4ed3f1..e86b424 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of_dma.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -34,6 +35,8 @@
 #define SUN4I_DMA_CFG_SRC_ADDR_MODE(mode)	((mode) << 5)
 #define SUN4I_DMA_CFG_SRC_DRQ_TYPE(type)	(type)
 
+#define SUN4I_MAX_BURST	8
+
 /** Normal DMA register values **/
 
 /* Normal DMA source/destination data request type values */
@@ -126,6 +129,32 @@
 	 SUN4I_DDMA_PARA_DST_WAIT_CYCLES(2) |				\
 	 SUN4I_DDMA_PARA_SRC_WAIT_CYCLES(2))
 
+/*
+ * Hardware channels / ports representation
+ *
+ * The hardware is used in several SoCs, with differing numbers
+ * of channels and endpoints. This structure ties those numbers
+ * to a certain compatible string.
+ */
+struct sun4i_dma_config {
+	u32 ndma_nr_max_channels;
+	u32 ndma_nr_max_vchans;
+
+	u32 ddma_nr_max_channels;
+	u32 ddma_nr_max_vchans;
+
+	u32 dma_nr_max_channels;
+
+        void (*set_dst_data_width)(u32 *p_cfg, s8 data_width);
+        void (*set_src_data_width)(u32 *p_cfg, s8 data_width);
+	int (*convert_burst)(u32 maxburst);
+
+	u8 ndma_drq_sdram;
+	u8 ddma_drq_sdram;
+
+	u8 max_burst;
+};
+
 struct sun4i_dma_pchan {
 	/* Register base of channel */
 	void __iomem			*base;
@@ -163,7 +192,7 @@ struct sun4i_dma_contract {
 };
 
 struct sun4i_dma_dev {
-	DECLARE_BITMAP(pchans_used, SUN4I_DMA_NR_MAX_CHANNELS);
+	unsigned long *pchans_used;
 	struct dma_device		slave;
 	struct sun4i_dma_pchan		*pchans;
 	struct sun4i_dma_vchan		*vchans;
@@ -171,6 +200,7 @@ struct sun4i_dma_dev {
 	struct clk			*clk;
 	int				irq;
 	spinlock_t			lock;
+	const struct sun4i_dma_config *cfg;
 };
 
 static struct sun4i_dma_dev *to_sun4i_dma_dev(struct dma_device *dev)
@@ -193,7 +223,17 @@ static struct device *chan2dev(struct dma_chan *chan)
 	return &chan->dev->device;
 }
 
-static int convert_burst(u32 maxburst)
+static void set_dst_data_width_a10(u32 *p_cfg, s8 data_width)
+{
+	*p_cfg |= SUN4I_DMA_CFG_DST_DATA_WIDTH(data_width);
+}
+
+static void set_src_data_width_a10(u32 *p_cfg, s8 data_width)
+{
+	*p_cfg |= SUN4I_DMA_CFG_SRC_DATA_WIDTH(data_width);
+}
+
+static int convert_burst_a10(u32 maxburst)
 {
 	if (maxburst > 8)
 		return -EINVAL;
@@ -226,15 +266,15 @@ static struct sun4i_dma_pchan *find_and_use_pchan(struct sun4i_dma_dev *priv,
 	int i, max;
 
 	/*
-	 * pchans 0-SUN4I_NDMA_NR_MAX_CHANNELS are normal, and
-	 * SUN4I_NDMA_NR_MAX_CHANNELS+ are dedicated ones
+	 * pchans 0-priv->cfg->ndma_nr_max_channels are normal, and
+	 * priv->cfg->ndma_nr_max_channels+ are dedicated ones
 	 */
 	if (vchan->is_dedicated) {
-		i = SUN4I_NDMA_NR_MAX_CHANNELS;
-		max = SUN4I_DMA_NR_MAX_CHANNELS;
+		i = priv->cfg->ndma_nr_max_channels;
+		max = priv->cfg->dma_nr_max_channels;
 	} else {
 		i = 0;
-		max = SUN4I_NDMA_NR_MAX_CHANNELS;
+		max = priv->cfg->ndma_nr_max_channels;
 	}
 
 	spin_lock_irqsave(&priv->lock, flags);
@@ -437,6 +477,7 @@ generate_ndma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
 		      size_t len, struct dma_slave_config *sconfig,
 		      enum dma_transfer_direction direction)
 {
+	struct sun4i_dma_dev *priv = to_sun4i_dma_dev(chan->device);
 	struct sun4i_dma_promise *promise;
 	int ret;
 
@@ -460,13 +501,13 @@ generate_ndma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
 		sconfig->src_addr_width, sconfig->dst_addr_width);
 
 	/* Source burst */
-	ret = convert_burst(sconfig->src_maxburst);
+	ret = priv->cfg->convert_burst(sconfig->src_maxburst);
 	if (ret < 0)
 		goto fail;
 	promise->cfg |= SUN4I_DMA_CFG_SRC_BURST_LENGTH(ret);
 
 	/* Destination burst */
-	ret = convert_burst(sconfig->dst_maxburst);
+	ret = priv->cfg->convert_burst(sconfig->dst_maxburst);
 	if (ret < 0)
 		goto fail;
 	promise->cfg |= SUN4I_DMA_CFG_DST_BURST_LENGTH(ret);
@@ -475,13 +516,13 @@ generate_ndma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
 	ret = convert_buswidth(sconfig->src_addr_width);
 	if (ret < 0)
 		goto fail;
-	promise->cfg |= SUN4I_DMA_CFG_SRC_DATA_WIDTH(ret);
+	priv->cfg->set_src_data_width(&promise->cfg, ret);
 
 	/* Destination bus width */
 	ret = convert_buswidth(sconfig->dst_addr_width);
 	if (ret < 0)
 		goto fail;
-	promise->cfg |= SUN4I_DMA_CFG_DST_DATA_WIDTH(ret);
+	priv->cfg->set_dst_data_width(&promise->cfg, ret);
 
 	return promise;
 
@@ -503,6 +544,7 @@ static struct sun4i_dma_promise *
 generate_ddma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
 		      size_t len, struct dma_slave_config *sconfig)
 {
+	struct sun4i_dma_dev *priv = to_sun4i_dma_dev(chan->device);
 	struct sun4i_dma_promise *promise;
 	int ret;
 
@@ -517,13 +559,13 @@ generate_ddma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
 		SUN4I_DDMA_CFG_BYTE_COUNT_MODE_REMAIN;
 
 	/* Source burst */
-	ret = convert_burst(sconfig->src_maxburst);
+	ret = priv->cfg->convert_burst(sconfig->src_maxburst);
 	if (ret < 0)
 		goto fail;
 	promise->cfg |= SUN4I_DMA_CFG_SRC_BURST_LENGTH(ret);
 
 	/* Destination burst */
-	ret = convert_burst(sconfig->dst_maxburst);
+	ret = priv->cfg->convert_burst(sconfig->dst_maxburst);
 	if (ret < 0)
 		goto fail;
 	promise->cfg |= SUN4I_DMA_CFG_DST_BURST_LENGTH(ret);
@@ -532,13 +574,13 @@ generate_ddma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
 	ret = convert_buswidth(sconfig->src_addr_width);
 	if (ret < 0)
 		goto fail;
-	promise->cfg |= SUN4I_DMA_CFG_SRC_DATA_WIDTH(ret);
+	priv->cfg->set_src_data_width(&promise->cfg, ret);
 
 	/* Destination bus width */
 	ret = convert_buswidth(sconfig->dst_addr_width);
 	if (ret < 0)
 		goto fail;
-	promise->cfg |= SUN4I_DMA_CFG_DST_DATA_WIDTH(ret);
+	priv->cfg->set_dst_data_width(&promise->cfg, ret);
 
 	return promise;
 
@@ -615,6 +657,7 @@ static struct dma_async_tx_descriptor *
 sun4i_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest,
 			  dma_addr_t src, size_t len, unsigned long flags)
 {
+	struct sun4i_dma_dev *priv = to_sun4i_dma_dev(chan->device);
 	struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(chan);
 	struct dma_slave_config *sconfig = &vchan->cfg;
 	struct sun4i_dma_promise *promise;
@@ -631,8 +674,8 @@ sun4i_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest,
 	 */
 	sconfig->src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	sconfig->dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	sconfig->src_maxburst = 8;
-	sconfig->dst_maxburst = 8;
+	sconfig->src_maxburst = priv->cfg->max_burst;
+	sconfig->dst_maxburst = priv->cfg->max_burst;
 
 	if (vchan->is_dedicated)
 		promise = generate_ddma_promise(chan, src, dest, len, sconfig);
@@ -647,11 +690,13 @@ sun4i_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest,
 
 	/* Configure memcpy mode */
 	if (vchan->is_dedicated) {
-		promise->cfg |= SUN4I_DMA_CFG_SRC_DRQ_TYPE(SUN4I_DDMA_DRQ_TYPE_SDRAM) |
-				SUN4I_DMA_CFG_DST_DRQ_TYPE(SUN4I_DDMA_DRQ_TYPE_SDRAM);
+		promise->cfg |=
+			SUN4I_DMA_CFG_SRC_DRQ_TYPE(priv->cfg->ddma_drq_sdram) |
+			SUN4I_DMA_CFG_DST_DRQ_TYPE(priv->cfg->ddma_drq_sdram);
 	} else {
-		promise->cfg |= SUN4I_DMA_CFG_SRC_DRQ_TYPE(SUN4I_NDMA_DRQ_TYPE_SDRAM) |
-				SUN4I_DMA_CFG_DST_DRQ_TYPE(SUN4I_NDMA_DRQ_TYPE_SDRAM);
+		promise->cfg |=
+			SUN4I_DMA_CFG_SRC_DRQ_TYPE(priv->cfg->ndma_drq_sdram) |
+			SUN4I_DMA_CFG_DST_DRQ_TYPE(priv->cfg->ndma_drq_sdram);
 	}
 
 	/* Fill the contract with our only promise */
@@ -666,6 +711,7 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf, size_t len,
 			  size_t period_len, enum dma_transfer_direction dir,
 			  unsigned long flags)
 {
+	struct sun4i_dma_dev *priv = to_sun4i_dma_dev(chan->device);
 	struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(chan);
 	struct dma_slave_config *sconfig = &vchan->cfg;
 	struct sun4i_dma_promise *promise;
@@ -701,7 +747,7 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf, size_t len,
 	if (dir == DMA_MEM_TO_DEV) {
 		src = buf;
 		dest = sconfig->dst_addr;
-		endpoints = SUN4I_DMA_CFG_SRC_DRQ_TYPE(SUN4I_NDMA_DRQ_TYPE_SDRAM) |
+		endpoints = SUN4I_DMA_CFG_SRC_DRQ_TYPE(priv->cfg->ndma_drq_sdram) |
 			    SUN4I_DMA_CFG_DST_DRQ_TYPE(vchan->endpoint) |
 			    SUN4I_DMA_CFG_DST_ADDR_MODE(SUN4I_NDMA_ADDR_MODE_IO);
 	} else {
@@ -709,7 +755,7 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf, size_t len,
 		dest = buf;
 		endpoints = SUN4I_DMA_CFG_SRC_DRQ_TYPE(vchan->endpoint) |
 			    SUN4I_DMA_CFG_SRC_ADDR_MODE(SUN4I_NDMA_ADDR_MODE_IO) |
-			    SUN4I_DMA_CFG_DST_DRQ_TYPE(SUN4I_NDMA_DRQ_TYPE_SDRAM);
+			    SUN4I_DMA_CFG_DST_DRQ_TYPE(priv->cfg->ndma_drq_sdram);
 	}
 
 	/*
@@ -772,6 +818,7 @@ sun4i_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			unsigned int sg_len, enum dma_transfer_direction dir,
 			unsigned long flags, void *context)
 {
+	struct sun4i_dma_dev *priv = to_sun4i_dma_dev(chan->device);
 	struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(chan);
 	struct dma_slave_config *sconfig = &vchan->cfg;
 	struct sun4i_dma_promise *promise;
@@ -797,11 +844,11 @@ sun4i_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	if (vchan->is_dedicated) {
 		io_mode = SUN4I_DDMA_ADDR_MODE_IO;
 		linear_mode = SUN4I_DDMA_ADDR_MODE_LINEAR;
-		ram_type = SUN4I_DDMA_DRQ_TYPE_SDRAM;
+		ram_type = priv->cfg->ddma_drq_sdram;
 	} else {
 		io_mode = SUN4I_NDMA_ADDR_MODE_IO;
 		linear_mode = SUN4I_NDMA_ADDR_MODE_LINEAR;
-		ram_type = SUN4I_NDMA_DRQ_TYPE_SDRAM;
+		ram_type = priv->cfg->ndma_drq_sdram;
 	}
 
 	if (dir == DMA_MEM_TO_DEV)
@@ -1130,6 +1177,10 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->cfg = of_device_get_match_data(&pdev->dev);
+	if (!priv->cfg)
+		return -ENODEV;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(priv->base))
@@ -1178,23 +1229,26 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 
 	priv->slave.dev = &pdev->dev;
 
-	priv->pchans = devm_kcalloc(&pdev->dev, SUN4I_DMA_NR_MAX_CHANNELS,
+	priv->pchans = devm_kcalloc(&pdev->dev, priv->cfg->dma_nr_max_channels,
 				    sizeof(struct sun4i_dma_pchan), GFP_KERNEL);
 	priv->vchans = devm_kcalloc(&pdev->dev, SUN4I_DMA_NR_MAX_VCHANS,
 				    sizeof(struct sun4i_dma_vchan), GFP_KERNEL);
-	if (!priv->vchans || !priv->pchans)
+	priv->pchans_used = devm_kcalloc(&pdev->dev,
+			BITS_TO_LONGS(priv->cfg->dma_nr_max_channels),
+			sizeof(unsigned long), GFP_KERNEL);
+	if (!priv->vchans || !priv->pchans || !priv->pchans_used)
 		return -ENOMEM;
 
 	/*
-	 * [0..SUN4I_NDMA_NR_MAX_CHANNELS) are normal pchans, and
-	 * [SUN4I_NDMA_NR_MAX_CHANNELS..SUN4I_DMA_NR_MAX_CHANNELS) are
+	 * [0..priv->cfg->ndma_nr_max_channels) are normal pchans, and
+	 * [priv->cfg->ndma_nr_max_channels..priv->cfg->dma_nr_max_channels) are
 	 * dedicated ones
 	 */
-	for (i = 0; i < SUN4I_NDMA_NR_MAX_CHANNELS; i++)
+	for (i = 0; i < priv->cfg->ndma_nr_max_channels; i++)
 		priv->pchans[i].base = priv->base +
 			SUN4I_NDMA_CHANNEL_REG_BASE(i);
 
-	for (j = 0; i < SUN4I_DMA_NR_MAX_CHANNELS; i++, j++) {
+	for (j = 0; i < priv->cfg->dma_nr_max_channels; i++, j++) {
 		priv->pchans[i].base = priv->base +
 			SUN4I_DDMA_CHANNEL_REG_BASE(j);
 		priv->pchans[i].is_dedicated = 1;
@@ -1267,8 +1321,28 @@ static int sun4i_dma_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static struct sun4i_dma_config sun4i_a10_dma_cfg = {
+	.ndma_nr_max_channels	= SUN4I_NDMA_NR_MAX_CHANNELS,
+	.ndma_nr_max_vchans	= SUN4I_NDMA_NR_MAX_VCHANS,
+
+	.ddma_nr_max_channels	= SUN4I_DDMA_NR_MAX_CHANNELS,
+	.ddma_nr_max_vchans	= SUN4I_DDMA_NR_MAX_VCHANS,
+
+	.dma_nr_max_channels	= SUN4I_NDMA_NR_MAX_CHANNELS + 
+		SUN4I_DDMA_NR_MAX_CHANNELS,
+
+	.set_dst_data_width	= set_dst_data_width_a10,
+	.set_src_data_width	= set_src_data_width_a10,
+	.convert_burst		= convert_burst_a10,
+
+	.ndma_drq_sdram		= SUN4I_NDMA_DRQ_TYPE_SDRAM,
+	.ddma_drq_sdram		= SUN4I_DDMA_DRQ_TYPE_SDRAM,
+
+	.max_burst		= SUN4I_MAX_BURST,
+};
+
 static const struct of_device_id sun4i_dma_match[] = {
-	{ .compatible = "allwinner,sun4i-a10-dma" },
+	{ .compatible = "allwinner,sun4i-a10-dma", .data = &sun4i_a10_dma_cfg },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, sun4i_dma_match);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
