Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E492DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:15:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A204121848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GFzOJXKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A204121848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bGLAzc4cVwphWiwmNGorgDlAd7mCTcdxZgu0JVwJXeA=; b=GFzOJXKOnBwK8u
	g+lZoNUjcnGDob0aC/6I3ZslQVaLOfphZaRrZISA+zXP8R92m+IXuh36j/5L1H6fkXe/wLHOlVw/A
	Ldg75oNyf9CPA0ugdONxkvx3K3o4FgYR1UOO8VktGQct+jbUYo+umupmru1rN5Uxehfck82HmEk3D
	WuYLKbdz6ucy7g+eE71W0kT7ExqF/i2GxLPOe+YUCIQEF5TDRuQGDl0uEv/IAhTPWFR3TyrmD6o8G
	WhZoyipa8z336dvLRQPgo2+fArD4PmYmqkKcGNWlSAQKuHdoLTUxpqKIExOowZLF0Wpyl2gje7ZPd
	+pbHSJQs8kA1ZJ85kiFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw1Ui-0007Iz-5k; Tue, 19 Feb 2019 09:15:16 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw1UJ-0005oW-O1; Tue, 19 Feb 2019 09:14:57 +0000
X-UUID: 1d6d1377d560410283b6f23cf761571d-20190219
X-UUID: 1d6d1377d560410283b6f23cf761571d-20190219
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <jitao.shi@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 584737385; Tue, 19 Feb 2019 01:14:48 -0800
Received: from MTKMBS33N1.mediatek.inc (172.27.4.75) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Feb 2019 01:14:14 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 19 Feb 2019 17:14:11 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 19 Feb 2019 17:14:10 +0800
From: Jitao Shi <jitao.shi@mediatek.com>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, "Mark
 Rutland" <mark.rutland@arm.com>, Ian Campbell
 <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
 <linux-pwm@vger.kernel.org>, David Airlie <airlied@linux.ie>, Matthias
 Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v1 1/2] drm/mediatek: separate mipi_tx to different file
Date: Tue, 19 Feb 2019 17:14:03 +0800
Message-ID: <20190219091404.89370-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219091404.89370-1-jitao.shi@mediatek.com>
References: <20190219091404.89370-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_011451_909941_0C0CE7AB 
X-CRM114-Status: GOOD (  14.72  )
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

Different IC has different mipi_tx setting of dsi.
This patch separates the mipi_tx hardware relate part for mt8173.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 drivers/gpu/drm/mediatek/Makefile             |   1 +
 drivers/gpu/drm/mediatek/mtk_mipi_tx.c        | 350 ++----------------
 drivers/gpu/drm/mediatek/mtk_mipi_tx.h        |  51 +++
 drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c | 290 +++++++++++++++
 4 files changed, 377 insertions(+), 315 deletions(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mipi_tx.h
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c

diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
index 82ae49c64221..2c8de1f5a5ee 100644
--- a/drivers/gpu/drm/mediatek/Makefile
+++ b/drivers/gpu/drm/mediatek/Makefile
@@ -12,6 +12,7 @@ mediatek-drm-y := mtk_disp_color.o \
 		  mtk_drm_plane.o \
 		  mtk_dsi.o \
 		  mtk_mipi_tx.o \
+		  mtk_mt8173_mipi_tx.o \
 		  mtk_dpi.o
 
 obj-$(CONFIG_DRM_MEDIATEK) += mediatek-drm.o
diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
index 90e913108950..fa361c8be8d7 100644
--- a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
+++ b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
@@ -11,292 +11,45 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/clk.h>
-#include <linux/clk-provider.h>
-#include <linux/delay.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/platform_device.h>
-#include <linux/phy/phy.h>
-
-#define MIPITX_DSI_CON		0x00
-#define RG_DSI_LDOCORE_EN		BIT(0)
-#define RG_DSI_CKG_LDOOUT_EN		BIT(1)
-#define RG_DSI_BCLK_SEL			(3 << 2)
-#define RG_DSI_LD_IDX_SEL		(7 << 4)
-#define RG_DSI_PHYCLK_SEL		(2 << 8)
-#define RG_DSI_DSICLK_FREQ_SEL		BIT(10)
-#define RG_DSI_LPTX_CLMP_EN		BIT(11)
-
-#define MIPITX_DSI_CLOCK_LANE	0x04
-#define MIPITX_DSI_DATA_LANE0	0x08
-#define MIPITX_DSI_DATA_LANE1	0x0c
-#define MIPITX_DSI_DATA_LANE2	0x10
-#define MIPITX_DSI_DATA_LANE3	0x14
-#define RG_DSI_LNTx_LDOOUT_EN		BIT(0)
-#define RG_DSI_LNTx_CKLANE_EN		BIT(1)
-#define RG_DSI_LNTx_LPTX_IPLUS1		BIT(2)
-#define RG_DSI_LNTx_LPTX_IPLUS2		BIT(3)
-#define RG_DSI_LNTx_LPTX_IMINUS		BIT(4)
-#define RG_DSI_LNTx_LPCD_IPLUS		BIT(5)
-#define RG_DSI_LNTx_LPCD_IMINUS		BIT(6)
-#define RG_DSI_LNTx_RT_CODE		(0xf << 8)
-
-#define MIPITX_DSI_TOP_CON	0x40
-#define RG_DSI_LNT_INTR_EN		BIT(0)
-#define RG_DSI_LNT_HS_BIAS_EN		BIT(1)
-#define RG_DSI_LNT_IMP_CAL_EN		BIT(2)
-#define RG_DSI_LNT_TESTMODE_EN		BIT(3)
-#define RG_DSI_LNT_IMP_CAL_CODE		(0xf << 4)
-#define RG_DSI_LNT_AIO_SEL		(7 << 8)
-#define RG_DSI_PAD_TIE_LOW_EN		BIT(11)
-#define RG_DSI_DEBUG_INPUT_EN		BIT(12)
-#define RG_DSI_PRESERVE			(7 << 13)
-
-#define MIPITX_DSI_BG_CON	0x44
-#define RG_DSI_BG_CORE_EN		BIT(0)
-#define RG_DSI_BG_CKEN			BIT(1)
-#define RG_DSI_BG_DIV			(0x3 << 2)
-#define RG_DSI_BG_FAST_CHARGE		BIT(4)
-#define RG_DSI_VOUT_MSK			(0x3ffff << 5)
-#define RG_DSI_V12_SEL			(7 << 5)
-#define RG_DSI_V10_SEL			(7 << 8)
-#define RG_DSI_V072_SEL			(7 << 11)
-#define RG_DSI_V04_SEL			(7 << 14)
-#define RG_DSI_V032_SEL			(7 << 17)
-#define RG_DSI_V02_SEL			(7 << 20)
-#define RG_DSI_BG_R1_TRIM		(0xf << 24)
-#define RG_DSI_BG_R2_TRIM		(0xf << 28)
-
-#define MIPITX_DSI_PLL_CON0	0x50
-#define RG_DSI_MPPLL_PLL_EN		BIT(0)
-#define RG_DSI_MPPLL_DIV_MSK		(0x1ff << 1)
-#define RG_DSI_MPPLL_PREDIV		(3 << 1)
-#define RG_DSI_MPPLL_TXDIV0		(3 << 3)
-#define RG_DSI_MPPLL_TXDIV1		(3 << 5)
-#define RG_DSI_MPPLL_POSDIV		(7 << 7)
-#define RG_DSI_MPPLL_MONVC_EN		BIT(10)
-#define RG_DSI_MPPLL_MONREF_EN		BIT(11)
-#define RG_DSI_MPPLL_VOD_EN		BIT(12)
-
-#define MIPITX_DSI_PLL_CON1	0x54
-#define RG_DSI_MPPLL_SDM_FRA_EN		BIT(0)
-#define RG_DSI_MPPLL_SDM_SSC_PH_INIT	BIT(1)
-#define RG_DSI_MPPLL_SDM_SSC_EN		BIT(2)
-#define RG_DSI_MPPLL_SDM_SSC_PRD	(0xffff << 16)
-
-#define MIPITX_DSI_PLL_CON2	0x58
-
-#define MIPITX_DSI_PLL_TOP	0x64
-#define RG_DSI_MPPLL_PRESERVE		(0xff << 8)
-
-#define MIPITX_DSI_PLL_PWR	0x68
-#define RG_DSI_MPPLL_SDM_PWR_ON		BIT(0)
-#define RG_DSI_MPPLL_SDM_ISO_EN		BIT(1)
-#define RG_DSI_MPPLL_SDM_PWR_ACK	BIT(8)
-
-#define MIPITX_DSI_SW_CTRL	0x80
-#define SW_CTRL_EN			BIT(0)
-
-#define MIPITX_DSI_SW_CTRL_CON0	0x84
-#define SW_LNTC_LPTX_PRE_OE		BIT(0)
-#define SW_LNTC_LPTX_OE			BIT(1)
-#define SW_LNTC_LPTX_P			BIT(2)
-#define SW_LNTC_LPTX_N			BIT(3)
-#define SW_LNTC_HSTX_PRE_OE		BIT(4)
-#define SW_LNTC_HSTX_OE			BIT(5)
-#define SW_LNTC_HSTX_ZEROCLK		BIT(6)
-#define SW_LNT0_LPTX_PRE_OE		BIT(7)
-#define SW_LNT0_LPTX_OE			BIT(8)
-#define SW_LNT0_LPTX_P			BIT(9)
-#define SW_LNT0_LPTX_N			BIT(10)
-#define SW_LNT0_HSTX_PRE_OE		BIT(11)
-#define SW_LNT0_HSTX_OE			BIT(12)
-#define SW_LNT0_LPRX_EN			BIT(13)
-#define SW_LNT1_LPTX_PRE_OE		BIT(14)
-#define SW_LNT1_LPTX_OE			BIT(15)
-#define SW_LNT1_LPTX_P			BIT(16)
-#define SW_LNT1_LPTX_N			BIT(17)
-#define SW_LNT1_HSTX_PRE_OE		BIT(18)
-#define SW_LNT1_HSTX_OE			BIT(19)
-#define SW_LNT2_LPTX_PRE_OE		BIT(20)
-#define SW_LNT2_LPTX_OE			BIT(21)
-#define SW_LNT2_LPTX_P			BIT(22)
-#define SW_LNT2_LPTX_N			BIT(23)
-#define SW_LNT2_HSTX_PRE_OE		BIT(24)
-#define SW_LNT2_HSTX_OE			BIT(25)
-
-struct mtk_mipitx_data {
-	const u32 mppll_preserve;
-};
-
-struct mtk_mipi_tx {
-	struct device *dev;
-	void __iomem *regs;
-	u32 data_rate;
-	const struct mtk_mipitx_data *driver_data;
-	struct clk_hw pll_hw;
-	struct clk *pll;
-};
+#include "mtk_mipi_tx.h"
 
-static inline struct mtk_mipi_tx *mtk_mipi_tx_from_clk_hw(struct clk_hw *hw)
+inline struct mtk_mipi_tx *mtk_mipi_tx_from_clk_hw(struct clk_hw *hw)
 {
 	return container_of(hw, struct mtk_mipi_tx, pll_hw);
 }
 
-static void mtk_mipi_tx_clear_bits(struct mtk_mipi_tx *mipi_tx, u32 offset,
-				   u32 bits)
+void mtk_mipi_tx_clear_bits(struct mtk_mipi_tx *mipi_tx, u32 offset,
+			    u32 bits)
 {
 	u32 temp = readl(mipi_tx->regs + offset);
 
 	writel(temp & ~bits, mipi_tx->regs + offset);
 }
 
-static void mtk_mipi_tx_set_bits(struct mtk_mipi_tx *mipi_tx, u32 offset,
-				 u32 bits)
+void mtk_mipi_tx_set_bits(struct mtk_mipi_tx *mipi_tx, u32 offset,
+			  u32 bits)
 {
 	u32 temp = readl(mipi_tx->regs + offset);
 
 	writel(temp | bits, mipi_tx->regs + offset);
 }
 
-static void mtk_mipi_tx_update_bits(struct mtk_mipi_tx *mipi_tx, u32 offset,
-				    u32 mask, u32 data)
+void mtk_mipi_tx_update_bits(struct mtk_mipi_tx *mipi_tx, u32 offset,
+			     u32 mask, u32 data)
 {
 	u32 temp = readl(mipi_tx->regs + offset);
 
 	writel((temp & ~mask) | (data & mask), mipi_tx->regs + offset);
 }
 
-static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
-{
-	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
-	u8 txdiv, txdiv0, txdiv1;
-	u64 pcw;
-
-	dev_dbg(mipi_tx->dev, "prepare: %u Hz\n", mipi_tx->data_rate);
-
-	if (mipi_tx->data_rate >= 500000000) {
-		txdiv = 1;
-		txdiv0 = 0;
-		txdiv1 = 0;
-	} else if (mipi_tx->data_rate >= 250000000) {
-		txdiv = 2;
-		txdiv0 = 1;
-		txdiv1 = 0;
-	} else if (mipi_tx->data_rate >= 125000000) {
-		txdiv = 4;
-		txdiv0 = 2;
-		txdiv1 = 0;
-	} else if (mipi_tx->data_rate > 62000000) {
-		txdiv = 8;
-		txdiv0 = 2;
-		txdiv1 = 1;
-	} else if (mipi_tx->data_rate >= 50000000) {
-		txdiv = 16;
-		txdiv0 = 2;
-		txdiv1 = 2;
-	} else {
-		return -EINVAL;
-	}
-
-	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_BG_CON,
-				RG_DSI_VOUT_MSK |
-				RG_DSI_BG_CKEN | RG_DSI_BG_CORE_EN,
-				(4 << 20) | (4 << 17) | (4 << 14) |
-				(4 << 11) | (4 << 8) | (4 << 5) |
-				RG_DSI_BG_CKEN | RG_DSI_BG_CORE_EN);
-
-	usleep_range(30, 100);
-
-	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_TOP_CON,
-				RG_DSI_LNT_IMP_CAL_CODE | RG_DSI_LNT_HS_BIAS_EN,
-				(8 << 4) | RG_DSI_LNT_HS_BIAS_EN);
-
-	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_DSI_CON,
-			     RG_DSI_CKG_LDOOUT_EN | RG_DSI_LDOCORE_EN);
-
-	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_PWR,
-				RG_DSI_MPPLL_SDM_PWR_ON |
-				RG_DSI_MPPLL_SDM_ISO_EN,
-				RG_DSI_MPPLL_SDM_PWR_ON);
-
-	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
-			       RG_DSI_MPPLL_PLL_EN);
-
-	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
-				RG_DSI_MPPLL_TXDIV0 | RG_DSI_MPPLL_TXDIV1 |
-				RG_DSI_MPPLL_PREDIV,
-				(txdiv0 << 3) | (txdiv1 << 5));
-
-	/*
-	 * PLL PCW config
-	 * PCW bit 24~30 = integer part of pcw
-	 * PCW bit 0~23 = fractional part of pcw
-	 * pcw = data_Rate*4*txdiv/(Ref_clk*2);
-	 * Post DIV =4, so need data_Rate*4
-	 * Ref_clk is 26MHz
-	 */
-	pcw = div_u64(((u64)mipi_tx->data_rate * 2 * txdiv) << 24,
-		      26000000);
-	writel(pcw, mipi_tx->regs + MIPITX_DSI_PLL_CON2);
-
-	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_DSI_PLL_CON1,
-			     RG_DSI_MPPLL_SDM_FRA_EN);
-
-	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_DSI_PLL_CON0, RG_DSI_MPPLL_PLL_EN);
-
-	usleep_range(20, 100);
-
-	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_PLL_CON1,
-			       RG_DSI_MPPLL_SDM_SSC_EN);
-
-	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_TOP,
-				RG_DSI_MPPLL_PRESERVE,
-				mipi_tx->driver_data->mppll_preserve);
-
-	return 0;
-}
-
-static void mtk_mipi_tx_pll_unprepare(struct clk_hw *hw)
-{
-	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
-
-	dev_dbg(mipi_tx->dev, "unprepare\n");
-
-	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
-			       RG_DSI_MPPLL_PLL_EN);
-
-	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_TOP,
-				RG_DSI_MPPLL_PRESERVE, 0);
-
-	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_PWR,
-				RG_DSI_MPPLL_SDM_ISO_EN |
-				RG_DSI_MPPLL_SDM_PWR_ON,
-				RG_DSI_MPPLL_SDM_ISO_EN);
-
-	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_TOP_CON,
-			       RG_DSI_LNT_HS_BIAS_EN);
-
-	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_CON,
-			       RG_DSI_CKG_LDOOUT_EN | RG_DSI_LDOCORE_EN);
-
-	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_BG_CON,
-			       RG_DSI_BG_CKEN | RG_DSI_BG_CORE_EN);
-
-	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
-			       RG_DSI_MPPLL_DIV_MSK);
-}
-
-static long mtk_mipi_tx_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-				       unsigned long *prate)
+long mtk_mipi_tx_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *prate)
 {
 	return clamp_val(rate, 50000000, 1250000000);
 }
 
-static int mtk_mipi_tx_pll_set_rate(struct clk_hw *hw, unsigned long rate,
-				    unsigned long parent_rate)
+int mtk_mipi_tx_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long parent_rate)
 {
 	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
 
@@ -307,37 +60,14 @@ static int mtk_mipi_tx_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
-static unsigned long mtk_mipi_tx_pll_recalc_rate(struct clk_hw *hw,
-						 unsigned long parent_rate)
+unsigned long mtk_mipi_tx_pll_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
 {
 	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
 
 	return mipi_tx->data_rate;
 }
 
-static const struct clk_ops mtk_mipi_tx_pll_ops = {
-	.prepare = mtk_mipi_tx_pll_prepare,
-	.unprepare = mtk_mipi_tx_pll_unprepare,
-	.round_rate = mtk_mipi_tx_pll_round_rate,
-	.set_rate = mtk_mipi_tx_pll_set_rate,
-	.recalc_rate = mtk_mipi_tx_pll_recalc_rate,
-};
-
-static int mtk_mipi_tx_power_on_signal(struct phy *phy)
-{
-	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
-	u32 reg;
-
-	for (reg = MIPITX_DSI_CLOCK_LANE;
-	     reg <= MIPITX_DSI_DATA_LANE3; reg += 4)
-		mtk_mipi_tx_set_bits(mipi_tx, reg, RG_DSI_LNTx_LDOOUT_EN);
-
-	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_TOP_CON,
-			       RG_DSI_PAD_TIE_LOW_EN);
-
-	return 0;
-}
-
 static int mtk_mipi_tx_power_on(struct phy *phy)
 {
 	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
@@ -349,30 +79,16 @@ static int mtk_mipi_tx_power_on(struct phy *phy)
 		return ret;
 
 	/* Enable DSI Lane LDO outputs, disable pad tie low */
-	mtk_mipi_tx_power_on_signal(phy);
-
+	mipi_tx->driver_data->mipi_tx_enable_signal(phy);
 	return 0;
 }
 
-static void mtk_mipi_tx_power_off_signal(struct phy *phy)
-{
-	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
-	u32 reg;
-
-	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_DSI_TOP_CON,
-			     RG_DSI_PAD_TIE_LOW_EN);
-
-	for (reg = MIPITX_DSI_CLOCK_LANE;
-	     reg <= MIPITX_DSI_DATA_LANE3; reg += 4)
-		mtk_mipi_tx_clear_bits(mipi_tx, reg, RG_DSI_LNTx_LDOOUT_EN);
-}
-
 static int mtk_mipi_tx_power_off(struct phy *phy)
 {
 	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
 
 	/* Enable pad tie low, disable DSI Lane LDO outputs */
-	mtk_mipi_tx_power_off_signal(phy);
+	mipi_tx->driver_data->mipi_tx_disable_signal(phy);
 
 	/* Disable PLL and power down core */
 	clk_disable_unprepare(mipi_tx->pll);
@@ -386,15 +102,23 @@ static const struct phy_ops mtk_mipi_tx_ops = {
 	.owner = THIS_MODULE,
 };
 
+static void mtk_mipi_tx_clk_get_ops(struct mtk_mipi_tx *mipi_tx,
+				    const struct clk_ops **ops)
+{
+	if (mipi_tx && mipi_tx->driver_data &&
+	    mipi_tx->driver_data->mipi_tx_clk_ops)
+		*ops = mipi_tx->driver_data->mipi_tx_clk_ops;
+	else
+		dev_err(mipi_tx->dev, "Failed to get clk ops of phy\n");
+}
+
 static int mtk_mipi_tx_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mtk_mipi_tx *mipi_tx;
 	struct resource *mem;
-	struct clk *ref_clk;
 	const char *ref_clk_name;
 	struct clk_init_data clk_init = {
-		.ops = &mtk_mipi_tx_pll_ops,
 		.num_parents = 1,
 		.parent_names = (const char * const *)&ref_clk_name,
 		.flags = CLK_SET_RATE_GATE,
@@ -408,6 +132,7 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mipi_tx->driver_data = of_device_get_match_data(dev);
+
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mipi_tx->regs = devm_ioremap_resource(dev, mem);
 	if (IS_ERR(mipi_tx->regs)) {
@@ -416,13 +141,14 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ref_clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(ref_clk)) {
-		ret = PTR_ERR(ref_clk);
+	mipi_tx->ref_clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(mipi_tx->ref_clk)) {
+		ret = PTR_ERR(mipi_tx->ref_clk);
 		dev_err(dev, "Failed to get reference clock: %d\n", ret);
 		return ret;
 	}
-	ref_clk_name = __clk_get_name(ref_clk);
+
+	ref_clk_name = __clk_get_name(mipi_tx->ref_clk);
 
 	ret = of_property_read_string(dev->of_node, "clock-output-names",
 				      &clk_init.name);
@@ -431,6 +157,8 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	mtk_mipi_tx_clk_get_ops(mipi_tx, &clk_init.ops);
+
 	mipi_tx->pll_hw.init = &clk_init;
 	mipi_tx->pll = devm_clk_register(dev, &mipi_tx->pll_hw);
 	if (IS_ERR(mipi_tx->pll)) {
@@ -465,20 +193,12 @@ static int mtk_mipi_tx_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct mtk_mipitx_data mt2701_mipitx_data = {
-	.mppll_preserve = (3 << 8)
-};
-
-static const struct mtk_mipitx_data mt8173_mipitx_data = {
-	.mppll_preserve = (0 << 8)
-};
-
 static const struct of_device_id mtk_mipi_tx_match[] = {
 	{ .compatible = "mediatek,mt2701-mipi-tx",
 	  .data = &mt2701_mipitx_data },
 	{ .compatible = "mediatek,mt8173-mipi-tx",
 	  .data = &mt8173_mipitx_data },
-	{},
+	{ },
 };
 
 struct platform_driver mtk_mipi_tx_driver = {
diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.h b/drivers/gpu/drm/mediatek/mtk_mipi_tx.h
new file mode 100644
index 000000000000..2d7f05b0d6a7
--- /dev/null
+++ b/drivers/gpu/drm/mediatek/mtk_mipi_tx.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Author: Jitao Shi <jitao.shi@mediatek.com>
+ */
+
+#ifndef _MTK_MIPI_TX_H
+#define _MTK_MIPI_TX_H
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/phy/phy.h>
+
+struct mtk_mipitx_data {
+	const u32 mppll_preserve;
+	const struct clk_ops *mipi_tx_clk_ops;
+	void (*mipi_tx_enable_signal)(struct phy *phy);
+	void (*mipi_tx_disable_signal)(struct phy *phy);
+};
+
+struct mtk_mipi_tx {
+	struct device *dev;
+	void __iomem *regs;
+	u32 data_rate;
+	struct clk *ref_clk;
+	const struct mtk_mipitx_data *driver_data;
+	struct clk_hw pll_hw;
+	struct clk *pll;
+};
+
+struct mtk_mipi_tx *mtk_mipi_tx_from_clk_hw(struct clk_hw *hw);
+void mtk_mipi_tx_clear_bits(struct mtk_mipi_tx *mipi_tx, u32 offset, u32 bits);
+void mtk_mipi_tx_set_bits(struct mtk_mipi_tx *mipi_tx, u32 offset, u32 bits);
+void mtk_mipi_tx_update_bits(struct mtk_mipi_tx *mipi_tx, u32 offset, u32 mask,
+			     u32 data);
+long mtk_mipi_tx_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *prate);
+int mtk_mipi_tx_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long parent_rate);
+unsigned long mtk_mipi_tx_pll_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate);
+
+extern const struct mtk_mipitx_data mt2701_mipitx_data;
+extern const struct mtk_mipitx_data mt8173_mipitx_data;
+
+#endif
diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c b/drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c
new file mode 100644
index 000000000000..8e57cdf85b06
--- /dev/null
+++ b/drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c
@@ -0,0 +1,290 @@
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
+#define MIPITX_DSI_CON		0x00
+#define RG_DSI_LDOCORE_EN		BIT(0)
+#define RG_DSI_CKG_LDOOUT_EN		BIT(1)
+#define RG_DSI_BCLK_SEL			(3 << 2)
+#define RG_DSI_LD_IDX_SEL		(7 << 4)
+#define RG_DSI_PHYCLK_SEL		(2 << 8)
+#define RG_DSI_DSICLK_FREQ_SEL		BIT(10)
+#define RG_DSI_LPTX_CLMP_EN		BIT(11)
+
+#define MIPITX_DSI_CLOCK_LANE	0x04
+#define MIPITX_DSI_DATA_LANE0	0x08
+#define MIPITX_DSI_DATA_LANE1	0x0c
+#define MIPITX_DSI_DATA_LANE2	0x10
+#define MIPITX_DSI_DATA_LANE3	0x14
+#define RG_DSI_LNTx_LDOOUT_EN		BIT(0)
+#define RG_DSI_LNTx_CKLANE_EN		BIT(1)
+#define RG_DSI_LNTx_LPTX_IPLUS1		BIT(2)
+#define RG_DSI_LNTx_LPTX_IPLUS2		BIT(3)
+#define RG_DSI_LNTx_LPTX_IMINUS		BIT(4)
+#define RG_DSI_LNTx_LPCD_IPLUS		BIT(5)
+#define RG_DSI_LNTx_LPCD_IMINUS		BIT(6)
+#define RG_DSI_LNTx_RT_CODE		(0xf << 8)
+
+#define MIPITX_DSI_TOP_CON	0x40
+#define RG_DSI_LNT_INTR_EN		BIT(0)
+#define RG_DSI_LNT_HS_BIAS_EN		BIT(1)
+#define RG_DSI_LNT_IMP_CAL_EN		BIT(2)
+#define RG_DSI_LNT_TESTMODE_EN		BIT(3)
+#define RG_DSI_LNT_IMP_CAL_CODE		(0xf << 4)
+#define RG_DSI_LNT_AIO_SEL		(7 << 8)
+#define RG_DSI_PAD_TIE_LOW_EN		BIT(11)
+#define RG_DSI_DEBUG_INPUT_EN		BIT(12)
+#define RG_DSI_PRESERVE			(7 << 13)
+
+#define MIPITX_DSI_BG_CON	0x44
+#define RG_DSI_BG_CORE_EN		BIT(0)
+#define RG_DSI_BG_CKEN			BIT(1)
+#define RG_DSI_BG_DIV			(0x3 << 2)
+#define RG_DSI_BG_FAST_CHARGE		BIT(4)
+#define RG_DSI_VOUT_MSK			(0x3ffff << 5)
+#define RG_DSI_V12_SEL			(7 << 5)
+#define RG_DSI_V10_SEL			(7 << 8)
+#define RG_DSI_V072_SEL			(7 << 11)
+#define RG_DSI_V04_SEL			(7 << 14)
+#define RG_DSI_V032_SEL			(7 << 17)
+#define RG_DSI_V02_SEL			(7 << 20)
+#define RG_DSI_BG_R1_TRIM		(0xf << 24)
+#define RG_DSI_BG_R2_TRIM		(0xf << 28)
+
+#define MIPITX_DSI_PLL_CON0	0x50
+#define RG_DSI_MPPLL_PLL_EN		BIT(0)
+#define RG_DSI_MPPLL_DIV_MSK		(0x1ff << 1)
+#define RG_DSI_MPPLL_PREDIV		(3 << 1)
+#define RG_DSI_MPPLL_TXDIV0		(3 << 3)
+#define RG_DSI_MPPLL_TXDIV1		(3 << 5)
+#define RG_DSI_MPPLL_POSDIV		(7 << 7)
+#define RG_DSI_MPPLL_MONVC_EN		BIT(10)
+#define RG_DSI_MPPLL_MONREF_EN		BIT(11)
+#define RG_DSI_MPPLL_VOD_EN		BIT(12)
+
+#define MIPITX_DSI_PLL_CON1	0x54
+#define RG_DSI_MPPLL_SDM_FRA_EN		BIT(0)
+#define RG_DSI_MPPLL_SDM_SSC_PH_INIT	BIT(1)
+#define RG_DSI_MPPLL_SDM_SSC_EN		BIT(2)
+#define RG_DSI_MPPLL_SDM_SSC_PRD	(0xffff << 16)
+
+#define MIPITX_DSI_PLL_CON2	0x58
+
+#define MIPITX_DSI_PLL_TOP	0x64
+#define RG_DSI_MPPLL_PRESERVE		(0xff << 8)
+
+#define MIPITX_DSI_PLL_PWR	0x68
+#define RG_DSI_MPPLL_SDM_PWR_ON		BIT(0)
+#define RG_DSI_MPPLL_SDM_ISO_EN		BIT(1)
+#define RG_DSI_MPPLL_SDM_PWR_ACK	BIT(8)
+
+#define MIPITX_DSI_SW_CTRL	0x80
+#define SW_CTRL_EN			BIT(0)
+
+#define MIPITX_DSI_SW_CTRL_CON0	0x84
+#define SW_LNTC_LPTX_PRE_OE		BIT(0)
+#define SW_LNTC_LPTX_OE			BIT(1)
+#define SW_LNTC_LPTX_P			BIT(2)
+#define SW_LNTC_LPTX_N			BIT(3)
+#define SW_LNTC_HSTX_PRE_OE		BIT(4)
+#define SW_LNTC_HSTX_OE			BIT(5)
+#define SW_LNTC_HSTX_ZEROCLK		BIT(6)
+#define SW_LNT0_LPTX_PRE_OE		BIT(7)
+#define SW_LNT0_LPTX_OE			BIT(8)
+#define SW_LNT0_LPTX_P			BIT(9)
+#define SW_LNT0_LPTX_N			BIT(10)
+#define SW_LNT0_HSTX_PRE_OE		BIT(11)
+#define SW_LNT0_HSTX_OE			BIT(12)
+#define SW_LNT0_LPRX_EN			BIT(13)
+#define SW_LNT1_LPTX_PRE_OE		BIT(14)
+#define SW_LNT1_LPTX_OE			BIT(15)
+#define SW_LNT1_LPTX_P			BIT(16)
+#define SW_LNT1_LPTX_N			BIT(17)
+#define SW_LNT1_HSTX_PRE_OE		BIT(18)
+#define SW_LNT1_HSTX_OE			BIT(19)
+#define SW_LNT2_LPTX_PRE_OE		BIT(20)
+#define SW_LNT2_LPTX_OE			BIT(21)
+#define SW_LNT2_LPTX_P			BIT(22)
+#define SW_LNT2_LPTX_N			BIT(23)
+#define SW_LNT2_HSTX_PRE_OE		BIT(24)
+#define SW_LNT2_HSTX_OE			BIT(25)
+
+static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
+{
+	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
+	u8 txdiv, txdiv0, txdiv1;
+	u64 pcw;
+
+	dev_dbg(mipi_tx->dev, "prepare: %u Hz\n", mipi_tx->data_rate);
+
+	if (mipi_tx->data_rate >= 500000000) {
+		txdiv = 1;
+		txdiv0 = 0;
+		txdiv1 = 0;
+	} else if (mipi_tx->data_rate >= 250000000) {
+		txdiv = 2;
+		txdiv0 = 1;
+		txdiv1 = 0;
+	} else if (mipi_tx->data_rate >= 125000000) {
+		txdiv = 4;
+		txdiv0 = 2;
+		txdiv1 = 0;
+	} else if (mipi_tx->data_rate > 62000000) {
+		txdiv = 8;
+		txdiv0 = 2;
+		txdiv1 = 1;
+	} else if (mipi_tx->data_rate >= 50000000) {
+		txdiv = 16;
+		txdiv0 = 2;
+		txdiv1 = 2;
+	} else {
+		return -EINVAL;
+	}
+
+	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_BG_CON,
+				RG_DSI_VOUT_MSK |
+				RG_DSI_BG_CKEN | RG_DSI_BG_CORE_EN,
+				(4 << 20) | (4 << 17) | (4 << 14) |
+				(4 << 11) | (4 << 8) | (4 << 5) |
+				RG_DSI_BG_CKEN | RG_DSI_BG_CORE_EN);
+
+	usleep_range(30, 100);
+
+	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_TOP_CON,
+				RG_DSI_LNT_IMP_CAL_CODE | RG_DSI_LNT_HS_BIAS_EN,
+				(8 << 4) | RG_DSI_LNT_HS_BIAS_EN);
+
+	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_DSI_CON,
+			     RG_DSI_CKG_LDOOUT_EN | RG_DSI_LDOCORE_EN);
+
+	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_PWR,
+				RG_DSI_MPPLL_SDM_PWR_ON |
+				RG_DSI_MPPLL_SDM_ISO_EN,
+				RG_DSI_MPPLL_SDM_PWR_ON);
+
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
+			       RG_DSI_MPPLL_PLL_EN);
+
+	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
+				RG_DSI_MPPLL_TXDIV0 | RG_DSI_MPPLL_TXDIV1 |
+				RG_DSI_MPPLL_PREDIV,
+				(txdiv0 << 3) | (txdiv1 << 5));
+
+	/*
+	 * PLL PCW config
+	 * PCW bit 24~30 = integer part of pcw
+	 * PCW bit 0~23 = fractional part of pcw
+	 * pcw = data_Rate*4*txdiv/(Ref_clk*2);
+	 * Post DIV =4, so need data_Rate*4
+	 * Ref_clk is 26MHz
+	 */
+	pcw = div_u64(((u64)mipi_tx->data_rate * 2 * txdiv) << 24,
+		      26000000);
+	writel(pcw, mipi_tx->regs + MIPITX_DSI_PLL_CON2);
+
+	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_DSI_PLL_CON1,
+			     RG_DSI_MPPLL_SDM_FRA_EN);
+
+	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_DSI_PLL_CON0, RG_DSI_MPPLL_PLL_EN);
+
+	usleep_range(20, 100);
+
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_PLL_CON1,
+			       RG_DSI_MPPLL_SDM_SSC_EN);
+
+	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_TOP,
+				RG_DSI_MPPLL_PRESERVE,
+				mipi_tx->driver_data->mppll_preserve);
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
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
+			       RG_DSI_MPPLL_PLL_EN);
+
+	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_TOP,
+				RG_DSI_MPPLL_PRESERVE, 0);
+
+	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_PWR,
+				RG_DSI_MPPLL_SDM_ISO_EN |
+				RG_DSI_MPPLL_SDM_PWR_ON,
+				RG_DSI_MPPLL_SDM_ISO_EN);
+
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_TOP_CON,
+			       RG_DSI_LNT_HS_BIAS_EN);
+
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_CON,
+			       RG_DSI_CKG_LDOOUT_EN | RG_DSI_LDOCORE_EN);
+
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_BG_CON,
+			       RG_DSI_BG_CKEN | RG_DSI_BG_CORE_EN);
+
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
+			       RG_DSI_MPPLL_DIV_MSK);
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
+	u32 reg;
+
+	for (reg = MIPITX_DSI_CLOCK_LANE;
+	     reg <= MIPITX_DSI_DATA_LANE3; reg += 4)
+		mtk_mipi_tx_set_bits(mipi_tx, reg, RG_DSI_LNTx_LDOOUT_EN);
+
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_TOP_CON,
+			       RG_DSI_PAD_TIE_LOW_EN);
+}
+
+static void mtk_mipi_tx_power_off_signal(struct phy *phy)
+{
+	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
+	u32 reg;
+
+	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_DSI_TOP_CON,
+			     RG_DSI_PAD_TIE_LOW_EN);
+
+	for (reg = MIPITX_DSI_CLOCK_LANE;
+	     reg <= MIPITX_DSI_DATA_LANE3; reg += 4)
+		mtk_mipi_tx_clear_bits(mipi_tx, reg, RG_DSI_LNTx_LDOOUT_EN);
+}
+
+const struct mtk_mipitx_data mt2701_mipitx_data = {
+	.mppll_preserve = (3 << 8),
+	.mipi_tx_clk_ops = &mtk_mipi_tx_pll_ops,
+	.mipi_tx_enable_signal = mtk_mipi_tx_power_on_signal,
+	.mipi_tx_disable_signal = mtk_mipi_tx_power_off_signal,
+};
+
+const struct mtk_mipitx_data mt8173_mipitx_data = {
+	.mppll_preserve = (0 << 8),
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
