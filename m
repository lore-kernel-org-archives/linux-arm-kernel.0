Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18A8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:14:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8341021848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LHli/EJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8341021848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BP5fpCnIJTpZbOq18MIG1lykXFuHhyoFjzrjAg3mP6c=; b=LHli/EJi9zT7Ml
	UnXq121l+glZbel0rY7wXRgxoNmJklE/Noc7oDYTSeJVZtnYnetkDuq0XYMz7SJf8l85JDypyNa3Y
	C2d1h8EhPd3Uy+3dQgT3AVze9pbXBiWJKzSHxC8TAoD9kxXiFFacvdtq1S8qhafCQs0DJDBn8WvXi
	z5ft4og9fA5iQIOJERKj4LX/yL9Z7d25UzJ3bVcs4OyYlA0k3gb1LwjLt97LMAK35OFArEnXdFGdi
	4jN+xrSvf9es3xId7re+GILmBOWwllfnZaGvxII9YtqkLedupI2P8vHLJUYnjVxC1ge6sHdgBkrEy
	86xwnXdOjxPH434PPf1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw1UK-0005p1-0H; Tue, 19 Feb 2019 09:14:52 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw1UF-0005o8-Fk; Tue, 19 Feb 2019 09:14:49 +0000
X-UUID: 479f66bf24d345a093a9015d8517466d-20190219
X-UUID: 479f66bf24d345a093a9015d8517466d-20190219
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <jitao.shi@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 2027209509; Tue, 19 Feb 2019 01:14:19 -0800
Received: from MTKMBS33DR.mediatek.inc (172.27.6.106) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Feb 2019 01:14:17 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 19 Feb 2019 17:14:14 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 19 Feb 2019 17:14:13 +0800
From: Jitao Shi <jitao.shi@mediatek.com>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, "Mark
 Rutland" <mark.rutland@arm.com>, Ian Campbell
 <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
 <linux-pwm@vger.kernel.org>, David Airlie <airlied@linux.ie>, Matthias
 Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v1 2/2] drm/mediatek: add mipi_tx driver for mt8183
Date: Tue, 19 Feb 2019 17:14:04 +0800
Message-ID: <20190219091404.89370-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219091404.89370-1-jitao.shi@mediatek.com>
References: <20190219091404.89370-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_011447_525749_42E0DD40 
X-CRM114-Status: GOOD (  17.27  )
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
Cc: stonea168@163.com, dri-devel@lists.freedesktop.org,
 Andy Yan <andy.yan@rock-chips.com>, Ajay Kumar <ajaykumar.rs@samsung.com>,
 Vincent Palatin <vpalatin@chromium.org>, cawa.cheng@mediatek.com,
 bibby.hsieh@mediatek.com, ck.hu@mediatek.com,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Thierry Reding <treding@nvidia.com>, devicetree@vger.kernel.org,
 Jitao Shi <jitao.shi@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Inki Dae <inki.dae@samsung.com>, linux-mediatek@lists.infradead.org,
 yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org, Rahul Sharma <rahul.sharma@samsung.com>,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 Sascha Hauer <kernel@pengutronix.de>, Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch add mt8183 mipi_tx driver.
And also support other chips that use the same binding and driver.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_mipi_tx.c        |   2 +
 drivers/gpu/drm/mediatek/mtk_mipi_tx.h        |   1 +
 drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c | 168 ++++++++++++++++++
 3 files changed, 171 insertions(+)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c

diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
index fa361c8be8d7..83fb7717d383 100644
--- a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
+++ b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
@@ -198,6 +198,8 @@ static const struct of_device_id mtk_mipi_tx_match[] = {
 	  .data = &mt2701_mipitx_data },
 	{ .compatible = "mediatek,mt8173-mipi-tx",
 	  .data = &mt8173_mipitx_data },
+	{ .compatible = "mediatek,mt8183-mipi-tx",
+	  .data = &mt8183_mipitx_data },
 	{ },
 };
 
diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.h b/drivers/gpu/drm/mediatek/mtk_mipi_tx.h
index 2d7f05b0d6a7..af83023e81cf 100644
--- a/drivers/gpu/drm/mediatek/mtk_mipi_tx.h
+++ b/drivers/gpu/drm/mediatek/mtk_mipi_tx.h
@@ -47,5 +47,6 @@ unsigned long mtk_mipi_tx_pll_recalc_rate(struct clk_hw *hw,
 
 extern const struct mtk_mipitx_data mt2701_mipitx_data;
 extern const struct mtk_mipitx_data mt8173_mipitx_data;
+extern const struct mtk_mipitx_data mt8183_mipitx_data;
 
 #endif
diff --git a/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c b/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
new file mode 100644
index 000000000000..07f70a3cad13
--- /dev/null
+++ b/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
@@ -0,0 +1,168 @@
+/*
+ * Copyright (c) 2015 MediaTek Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include "mtk_mipi_tx.h"
+
+#define MIPITX_LANE_CON		0x000c
+#define RG_DSI_CPHY_T1DRV_EN	BIT(0)
+#define RG_DSI_ANA_CK_SEL	BIT(1)
+#define RG_DSI_PHY_CK_SEL	BIT(2)
+#define RG_DSI_CPHY_EN	BIT(3)
+#define RG_DSI_PHYCK_INV_EN	BIT(4)
+#define RG_DSI_PWR04_EN	BIT(5)
+#define RG_DSI_BG_LPF_EN	BIT(6)
+#define RG_DSI_BG_CORE_EN	BIT(7)
+#define RG_DSI_PAD_TIEL_SEL	BIT(8)
+
+#define MIPITX_PLL_PWR		0x0028
+#define MIPITX_PLL_CON0		0x002c
+#define MIPITX_PLL_CON1		0x0030
+#define MIPITX_PLL_CON2		0x0034
+#define MIPITX_PLL_CON3		0x0038
+#define MIPITX_PLL_CON4		0x003c
+#define RG_DSI_PLL_IBIAS	(3 << 10)
+
+#define MIPITX_D2_SW_CTL_EN	0x0144
+#define MIPITX_D0_SW_CTL_EN	0x0244
+#define MIPITX_CK_CKMODE_EN	0x0328
+#define DSI_CK_CKMODE_EN	BIT(0)
+#define MIPITX_CK_SW_CTL_EN	0x0344
+#define MIPITX_D1_SW_CTL_EN	0x0444
+#define MIPITX_D3_SW_CTL_EN	0x0544
+#define DSI_SW_CTL_EN		BIT(0)
+#define AD_DSI_PLL_SDM_PWR_ON	BIT(0)
+#define AD_DSI_PLL_SDM_ISO_EN	BIT(1)
+
+#define RG_DSI_PLL_EN		BIT(4)
+#define RG_DSI_PLL_POSDIV	(0x7 << 8)
+
+static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
+{
+	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
+	unsigned int txdiv, txdiv0, txdiv1;
+	u64 pcw;
+	int ret;
+
+	dev_dbg(mipi_tx->dev, "prepare: %u bps\n", mipi_tx->data_rate);
+
+	if (mipi_tx->data_rate >= 2000000000) {
+		txdiv = 1;
+		txdiv0 = 0;
+		txdiv1 = 0;
+	} else if (mipi_tx->data_rate >= 1000000000) {
+		txdiv = 2;
+		txdiv0 = 1;
+		txdiv1 = 0;
+	} else if (mipi_tx->data_rate >= 500000000) {
+		txdiv = 4;
+		txdiv0 = 2;
+		txdiv1 = 0;
+	} else if (mipi_tx->data_rate > 250000000) {
+		txdiv = 8;
+		txdiv0 = 3;
+		txdiv1 = 0;
+	} else if (mipi_tx->data_rate >= 125000000) {
+		txdiv = 16;
+		txdiv0 = 4;
+		txdiv1 = 0;
+	} else {
+		return -EINVAL;
+	}
+
+	ret = clk_prepare_enable(mipi_tx->ref_clk);
+	if (ret < 0) {
+		dev_err(mipi_tx->dev, "can't mipi_tx ref_clk %d\n", ret);
+		return ret;
+	}
+
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_CON4, RG_DSI_PLL_IBIAS);
+
+	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
+	usleep_range(30, 100);
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_PWR, AD_DSI_PLL_SDM_ISO_EN);
+	pcw = div_u64(((u64)mipi_tx->data_rate * txdiv) << 24, 26000000);
+	writel(pcw, mipi_tx->regs + MIPITX_PLL_CON0);
+	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_PLL_CON1, RG_DSI_PLL_POSDIV,
+				txdiv0 << 8);
+	usleep_range(1000, 2000);
+	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_PLL_CON1, RG_DSI_PLL_EN);
+
+	return 0;
+}
+
+static void mtk_mipi_tx_pll_unprepare(struct clk_hw *hw)
+{
+	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
+
+	dev_dbg(mipi_tx->dev, "unprepare\n");
+
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_CON1, RG_DSI_PLL_EN);
+	/* step 1: SDM_RWR_ON / SDM_ISO_EN */
+
+	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_PLL_PWR, AD_DSI_PLL_SDM_ISO_EN);
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
+	clk_disable_unprepare(mipi_tx->ref_clk);
+}
+
+static const struct clk_ops mtk_mipi_tx_pll_ops = {
+	.prepare = mtk_mipi_tx_pll_prepare,
+	.unprepare = mtk_mipi_tx_pll_unprepare,
+	.round_rate = mtk_mipi_tx_pll_round_rate,
+	.set_rate = mtk_mipi_tx_pll_set_rate,
+	.recalc_rate = mtk_mipi_tx_pll_recalc_rate,
+};
+
+static void mtk_mipi_tx_power_on_signal(struct phy *phy)
+{
+	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
+
+	/* BG_LPF_EN / BG_CORE_EN */
+	writel(RG_DSI_PAD_TIEL_SEL | RG_DSI_BG_CORE_EN,
+	       mipi_tx->regs + MIPITX_LANE_CON);
+	usleep_range(30, 100);
+	writel(RG_DSI_BG_CORE_EN | RG_DSI_BG_LPF_EN,
+	       mipi_tx->regs + MIPITX_LANE_CON);
+
+	/* Switch OFF each Lane */
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_D0_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_D1_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_D2_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_D3_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_CK_SW_CTL_EN, DSI_SW_CTL_EN);
+
+	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_CK_CKMODE_EN, DSI_CK_CKMODE_EN);
+}
+
+static void mtk_mipi_tx_power_off_signal(struct phy *phy)
+{
+	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
+
+	/* Switch ON each Lane */
+	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_D0_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_D1_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_D2_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_D3_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_CK_SW_CTL_EN, DSI_SW_CTL_EN);
+
+	/* step 2 */
+	writel(RG_DSI_PAD_TIEL_SEL | RG_DSI_BG_CORE_EN,
+	       mipi_tx->regs + MIPITX_LANE_CON);
+	writel(RG_DSI_PAD_TIEL_SEL, mipi_tx->regs + MIPITX_LANE_CON);
+}
+
+const struct mtk_mipitx_data mt8183_mipitx_data = {
+	.mipi_tx_clk_ops = &mtk_mipi_tx_pll_ops,
+	.mipi_tx_enable_signal = mtk_mipi_tx_power_on_signal,
+	.mipi_tx_disable_signal = mtk_mipi_tx_power_off_signal,
+};
+
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
