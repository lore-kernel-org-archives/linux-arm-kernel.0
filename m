Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE53C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:42:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CD402075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N9x4YtL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD402075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0uJwwsrBL1aErvldY6LcHML6tvfEkapj2qg7KETT98w=; b=N9x4YtL/CGZpGn
	x4HeKLQWcUGw0dR16cMFMV1vcSLyO6viXJq4W8B6KV2G2t2O3JOLYsg3RTHKjNRv3Qya9ElVZtvOs
	m/4RalZnhHPFlz+jnR26ZEsSmpEuEkngtnYxYDFCs/gZtKq/yrKvGw9wF6DVe232x0949tfDwNQ5I
	GXjhLos56C9hXkW9g4m4gN/4yj4zZb+TxXfun19eEU+JsbkjSQRKI282vMRwgXGbotd3K2awtsrsj
	QuzqU7OwkqjKog5+kXT13fOd9N04WhOC3vYf3RFA9BueZcL0VcKyFt++BI1VV3CJkuYkra0mJwP2f
	qVKxPVzQNBgFyMA9heXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXMa1-0006jg-PA; Thu, 13 Dec 2018 08:42:49 +0000
Received: from mail-sz2.amlogic.com ([211.162.65.114])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXMYa-0005UI-Cs; Thu, 13 Dec 2018 08:41:22 +0000
Received: from localhost.localdomain (10.28.8.16) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server id 15.0.1320.4; Thu, 13 Dec 2018
 16:40:09 +0800
From: Sunny Luo <sunny.luo@amlogic.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 3/3] spi: meson-axg: add a linear clock divider support
Date: Thu, 13 Dec 2018 16:39:14 +0800
Message-ID: <1544690354-16409-4-git-send-email-sunny.luo@amlogic.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
References: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
MIME-Version: 1.0
X-Originating-IP: [10.28.8.16]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_004120_625609_F46649D6 
X-CRM114-Status: GOOD (  17.67  )
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
Cc: Jianxin Pan <jianxin.pan@amlogic.com>,
 Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Yixun Lan <yixun.lan@amlogic.com>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 Sunny Luo <sunny.luo@amlogic.com>, Xingyu Chen <xingyu.chen@amlogic.com>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The SPICC controller in Meson-AXG SoC is capable of using
a linear clock divider to reach a much fine tuned range of clocks,
while the old controller only use a power of two clock divider,
result at a more coarse clock range.

Also convert the clock registration into Common Clock Framework.

Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/spi/Kconfig           |   2 +-
 drivers/spi/spi-meson-spicc.c | 209 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 170 insertions(+), 41 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9f89cb1..75f7362 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -384,7 +384,7 @@ config SPI_FSL_ESPI
 
 config SPI_MESON_SPICC
 	tristate "Amlogic Meson SPICC controller"
-	depends on ARCH_MESON || COMPILE_TEST
+	depends on OF && COMMON_CLK && (ARCH_MESON || COMPILE_TEST)
 	help
 	  This enables master mode support for the SPICC (SPI communication
 	  controller) available in Amlogic Meson SoCs.
diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 0384c28..59af18e 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -116,6 +116,9 @@
 #define SPICC_DWADDR	0x24	/* Write Address of DMA */
 
 #define SPICC_ENH_CTL0	0x38	/* Enhanced Feature */
+#define SPICC_ENH_CLK_CS_DELAY_MASK	GENMASK(15, 0)
+#define SPICC_ENH_DATARATE_MASK		GENMASK(23, 16)
+#define SPICC_ENH_DATARATE_EN		BIT(24)
 #define SPICC_ENH_MOSI_OEN		BIT(25)
 #define SPICC_ENH_CLK_OEN		BIT(26)
 #define SPICC_ENH_CS_OEN		BIT(27)
@@ -131,6 +134,7 @@
 struct meson_spicc_data {
 	unsigned int			max_speed_hz;
 	bool				has_oen;
+	bool				has_enhance_clk_div;
 };
 
 struct meson_spicc_device {
@@ -138,6 +142,7 @@ struct meson_spicc_device {
 	struct platform_device		*pdev;
 	void __iomem			*base;
 	struct clk			*core;
+	struct clk			*clk;
 	struct spi_message		*message;
 	struct spi_transfer		*xfer;
 	const struct meson_spicc_data	*data;
@@ -325,40 +330,6 @@ static irqreturn_t meson_spicc_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static u32 meson_spicc_setup_speed(struct meson_spicc_device *spicc, u32 conf,
-				   u32 speed)
-{
-	unsigned long parent, value;
-	unsigned int i, div;
-
-	parent = clk_get_rate(spicc->core);
-
-	/* Find closest inferior/equal possible speed */
-	for (i = 0 ; i < 7 ; ++i) {
-		/* 2^(data_rate+2) */
-		value = parent >> (i + 2);
-
-		if (value <= speed)
-			break;
-	}
-
-	/* If provided speed it lower than max divider, use max divider */
-	if (i > 7) {
-		div = 7;
-		dev_warn_once(&spicc->pdev->dev, "unable to get close to speed %u\n",
-			      speed);
-	} else
-		div = i;
-
-	dev_dbg(&spicc->pdev->dev, "parent %lu, speed %u -> %lu (%u)\n",
-		parent, speed, value, div);
-
-	conf &= ~SPICC_DATARATE_MASK;
-	conf |= FIELD_PREP(SPICC_DATARATE_MASK, div);
-
-	return conf;
-}
-
 static void meson_spicc_setup_xfer(struct meson_spicc_device *spicc,
 				   struct spi_transfer *xfer)
 {
@@ -367,9 +338,6 @@ static void meson_spicc_setup_xfer(struct meson_spicc_device *spicc,
 	/* Read original configuration */
 	conf = conf_orig = readl_relaxed(spicc->base + SPICC_CONREG);
 
-	/* Select closest divider */
-	conf = meson_spicc_setup_speed(spicc, conf, xfer->speed_hz);
-
 	/* Setup word width */
 	conf &= ~SPICC_BITLENGTH_MASK;
 	conf |= FIELD_PREP(SPICC_BITLENGTH_MASK,
@@ -378,6 +346,8 @@ static void meson_spicc_setup_xfer(struct meson_spicc_device *spicc,
 	/* Ignore if unchanged */
 	if (conf != conf_orig)
 		writel_relaxed(conf, spicc->base + SPICC_CONREG);
+
+	clk_set_rate(spicc->clk, xfer->speed_hz);
 }
 
 static int meson_spicc_transfer_one(struct spi_master *master,
@@ -486,9 +456,6 @@ static int meson_spicc_unprepare_transfer(struct spi_master *master)
 	/* Disable all IRQs */
 	writel(0, spicc->base + SPICC_INTREG);
 
-	/* Disable controller */
-	writel_bits_relaxed(SPICC_ENABLE, 0, spicc->base + SPICC_CONREG);
-
 	device_reset_optional(&spicc->pdev->dev);
 
 	return 0;
@@ -528,6 +495,157 @@ static void meson_spicc_cleanup(struct spi_device *spi)
 	spi->controller_state = NULL;
 }
 
+/*
+ * The Clock Mux
+ *            x-----------------x   x------------x    x------\
+ *        |---| 0) fixed factor |---| 1) old div |----|      |
+ *        |   x-----------------x   x------------x    |      |
+ * src ---|                                           |5) mux|-- out
+ *        |   x-----------------x   x------------x    |      |
+ *        |---| 2) fixed factor |---| 3) new div |0---|      |
+ *            x-----------------x   x------------x    x------/
+ *
+ * Clk path for GX series:
+ *    src -> 0 -> 1 -> out
+ *
+ * Clk path for AXG series:
+ *    src -> 0 -> 1 -> 5 -> out
+ *    src -> 2 -> 3 -> 5 -> out
+ */
+
+/* algorithm for div0 + div1: rate = freq / 4 / (2 ^ N) */
+static struct clk_fixed_factor meson_spicc_div0 = {
+	.mult	= 1,
+	.div	= 4,
+};
+
+static struct clk_divider meson_spicc_div1 = {
+	.reg	= (void *)SPICC_CONREG,
+	.shift	= 16,
+	.width	= 3,
+	.flags	= CLK_DIVIDER_POWER_OF_TWO,
+};
+
+/* algorithm for div2 + div3: rate = freq / 2 / (N + 1) */
+static struct clk_fixed_factor meson_spicc_div2 = {
+	.mult	= 1,
+	.div	= 2,
+};
+
+static struct clk_divider meson_spicc_div3 = {
+	.reg	= (void *)SPICC_ENH_CTL0,
+	.shift	= 16,
+	.width	= 8,
+};
+
+static struct clk_mux meson_spicc_sel = {
+	.reg	= (void *)SPICC_ENH_CTL0,
+	.mask	= 0x1,
+	.shift	= 24,
+};
+
+static int meson_spicc_clk_init(struct meson_spicc_device *spicc)
+{
+	struct device *dev = &spicc->pdev->dev;
+	struct clk_fixed_factor *div0;
+	struct clk_divider *div1;
+	struct clk_mux *mux;
+	struct clk_init_data init;
+	struct clk *clk;
+	const char *parent_names[1];
+	const char *mux_parent_names[2];
+	char name[32];
+
+	div0 = &meson_spicc_div0;
+	snprintf(name, sizeof(name), "%s#_div0", dev_name(dev));
+	init.name = name;
+	init.ops = &clk_fixed_factor_ops;
+	init.flags = 0;
+	parent_names[0] = __clk_get_name(spicc->core);
+	init.parent_names = parent_names;
+	init.num_parents = 1;
+
+	div0->hw.init = &init;
+
+	clk = devm_clk_register(dev, &div0->hw);
+	if (WARN_ON(IS_ERR(clk)))
+		return PTR_ERR(clk);
+
+	div1 = &meson_spicc_div1;
+	snprintf(name, sizeof(name), "%s#_div1", dev_name(dev));
+	init.name = name;
+	init.ops = &clk_divider_ops;
+	init.flags = CLK_SET_RATE_PARENT;
+	parent_names[0] = __clk_get_name(clk);
+	init.parent_names = parent_names;
+	init.num_parents = 1;
+
+	div1->reg = spicc->base + (u64)div1->reg;
+	div1->hw.init = &init;
+
+	clk = devm_clk_register(dev, &div1->hw);
+	if (WARN_ON(IS_ERR(clk)))
+		return PTR_ERR(clk);
+
+	if (!spicc->data->has_enhance_clk_div) {
+		spicc->clk = clk;
+		return 0;
+	}
+
+	mux_parent_names[0] = __clk_get_name(clk);
+
+	div0 = &meson_spicc_div2;
+	snprintf(name, sizeof(name), "%s#_div2", dev_name(dev));
+	init.name = name;
+	init.ops = &clk_fixed_factor_ops;
+	init.flags = 0;
+	parent_names[0] = __clk_get_name(spicc->core);
+	init.parent_names = parent_names;
+	init.num_parents = 1;
+
+	div0->hw.init = &init;
+
+	clk = devm_clk_register(dev, &div0->hw);
+	if (WARN_ON(IS_ERR(clk)))
+		return PTR_ERR(clk);
+
+	div1 = &meson_spicc_div3;
+	snprintf(name, sizeof(name), "%s#_div3", dev_name(dev));
+	init.name = name;
+	init.ops = &clk_divider_ops;
+	init.flags = CLK_SET_RATE_PARENT;
+	parent_names[0] = __clk_get_name(clk);
+	init.parent_names = parent_names;
+	init.num_parents = 1;
+
+	div1->reg = spicc->base + (u64)div1->reg;
+	div1->hw.init = &init;
+
+	clk = devm_clk_register(dev, &div1->hw);
+	if (WARN_ON(IS_ERR(clk)))
+		return PTR_ERR(clk);
+
+	mux_parent_names[1] = __clk_get_name(clk);
+
+	mux = &meson_spicc_sel;
+	snprintf(name, sizeof(name), "%s#_sel", dev_name(dev));
+	init.name = name;
+	init.ops = &clk_mux_ops;
+	init.parent_names = mux_parent_names;
+	init.num_parents = 2;
+	init.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT;
+
+	mux->reg = spicc->base + (u64)mux->reg;
+	mux->hw.init = &init;
+
+	spicc->clk = devm_clk_register(dev, &mux->hw);
+	if (WARN_ON(IS_ERR(spicc->clk)))
+		return PTR_ERR(spicc->clk);
+
+	clk_set_parent(spicc->clk, clk);
+	return 0;
+}
+
 static int meson_spicc_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
@@ -557,6 +675,10 @@ static int meson_spicc_probe(struct platform_device *pdev)
 		goto out_master;
 	}
 
+	/* Set master mode and enable controller */
+	writel_relaxed(SPICC_ENABLE | SPICC_MODE_MASTER,
+		       spicc->base + SPICC_CONREG);
+
 	/* Disable all IRQs */
 	writel_relaxed(0, spicc->base + SPICC_INTREG);
 
@@ -603,6 +725,12 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	master->max_speed_hz = min_t(unsigned int, rate >> 1,
 				     spicc->data->max_speed_hz);
 
+	ret = meson_spicc_clk_init(spicc);
+	if (ret) {
+		dev_err(&pdev->dev, "clock registration failed\n");
+		goto out_master;
+	}
+
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret) {
 		dev_err(&pdev->dev, "spi master registration failed\n");
@@ -639,6 +767,7 @@ static const struct meson_spicc_data meson_spicc_gx_data = {
 static const struct meson_spicc_data meson_spicc_axg_data = {
 	.max_speed_hz		= 80000000,
 	.has_oen		= true,
+	.has_enhance_clk_div	= true,
 };
 
 static const struct of_device_id meson_spicc_of_match[] = {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
