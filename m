Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88803C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 08:56:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D242083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 08:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a3vLrdTQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KviqmsQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D242083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YkSn++YNpmO5McfrfSXD5E3BV0TvabA16ubNLXaElis=; b=a3vLrdTQcXjKgH
	jptoGlKltpyiUYrhXEa6T1O7EGNfIHGIjSehfhEV4gvHUS80iNk2RomubBNnUYF3yE0onHtvDEuMf
	pxbMLi7wHUd/PwDQAZwBRAq/Yy/wnEcoRtSOOuZSXpuYYwrhy38p6EXANdBVB5B0bJDRFxnGrpil6
	sPE2cOe/jzR6XWKfiU7uqRdW+KdbYiuwGUpmu58JjJeNgxxOzXiQvifsgRs/jqz0YCTg05tW/pjXs
	PAd3Sht/CRZV83vMwK7Us0LLONrKFXZAoM6Yri0EkvLaO6xDpoY8EgY/apQAqf9+2BmpdKCCMv2Ei
	9nCfHllAfnqtgLOjbx/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVYPh-00039u-Tr; Sat, 08 Dec 2018 08:56:41 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVYPf-00032j-UJ; Sat, 08 Dec 2018 08:56:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vKnVvP4RwOdY85ZavoHi3xJodn7YplqpdMRmy7HF3lI=; b=KviqmsQo/DgwZOI3W4m7mZK0O
 nzitY1ioN1nB5ni+g+geuXfVl5UGfB1dsXMppuHBtDIsfh2bbwzcpvv5RTbr8xBCWv8yb93IzHQ2e
 h259z5ayuG8gVYXPQIvnfGE1yRPM6DlD1fF5DoRUZcJCovokaLL2LYSdpo2GmBg3GzBy2VGXu6FN6
 NBZMjA4NRV2zz3XMA8c3Ib7ZF/oCrzOL+MzWn5V9lBfHlGze9FyW3I9v+3BB1Y3U+pBKZofeKCuxD
 6vE+7D3PBal/eUJ/iFyR4kve+CT+eCqaCvHdYaL3B6wWoQGK4l47uRfEZIj//yvmmxWH7IWjllHm8
 P403zR/eA==;
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVYCJ-0008Bx-5K; Sat, 08 Dec 2018 08:42:55 +0000
X-UUID: 9fab8f638e7246358ea8c8b0b65590cb-20181208
X-UUID: 9fab8f638e7246358ea8c8b0b65590cb-20181208
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 687613278; Sat, 08 Dec 2018 16:42:32 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 8 Dec 2018 16:42:24 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 8 Dec 2018 16:42:24 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 10/18] iommu/mediatek: Add mt8183 IOMMU support
Date: Sat, 8 Dec 2018 16:39:23 +0800
Message-ID: <1544258371-4600-11-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: EF62400055CCB32A799D54AB1A14844A69F8F39E731B40694238316D5C9806C02000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_084251_784316_CC27380B 
X-CRM114-Status: GOOD (  21.99  )
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
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, arnd@arndb.de,
 srv_heupstream@mediatek.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 yong.wu@mediatek.com, Arvind Yadav <arvind.yadav.cs@gmail.com>,
 yingjoe.chen@mediatek.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The M4U IP blocks in mt8183 is MediaTek's generation2 M4U which use
the ARM Short-descriptor like mt8173, and most of the HW registers
are the same.

Here list main differences between mt8183 and mt8173/mt2712:
1) mt8183 has only one M4U HW like mt8173 while mt2712 has two.
2) mt8183 don't have the "bclk" clock, it use the EMI clock instead.
3) mt8183 can support the dram over 4GB, but it doesn't call this "4GB
mode".
4) mt8183 pgtable base register(0x0) extend bit[1:0] which represent
the bit[33:32] in the physical address of the pgtable base, But the
standard ttbr0[1] means the S bit which is enabled defaultly, Hence,
we add a mask.
5) mt8183 HW has a GALS modules, SMI should enable "has_gals" support.
6) the larb-id in smi-common is remapped. M4U should enable
larbid_remapped support.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 31 ++++++++++++++++++++++---------
 drivers/iommu/mtk_iommu.h |  1 +
 drivers/memory/mtk-smi.c  | 19 +++++++++++++++++++
 3 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 8ab3b69..d91a554 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -36,6 +36,7 @@
 #include "mtk_iommu.h"
 
 #define REG_MMU_PT_BASE_ADDR			0x000
+#define MMU_PT_ADDR_MASK			GENMASK(31, 7)
 
 #define REG_MMU_INVALIDATE			0x020
 #define F_ALL_INVLD				0x2
@@ -54,7 +55,7 @@
 #define REG_MMU_CTRL_REG			0x110
 #define F_MMU_PREFETCH_RT_REPLACE_MOD		BIT(4)
 #define F_MMU_TF_PROTECT_SEL_SHIFT(data) \
-	((data)->plat_data->m4u_plat == M4U_MT2712 ? 4 : 5)
+	((data)->plat_data->m4u_plat == M4U_MT8173 ? 5 : 4)
 /* It's named by F_MMU_TF_PROT_SEL in mt2712. */
 #define F_MMU_TF_PROTECT_SEL(prot, data) \
 	(((prot) & 0x3) << F_MMU_TF_PROTECT_SEL_SHIFT(data))
@@ -347,7 +348,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 	/* Update the pgtable base address register of the M4U HW */
 	if (!data->m4u_dom) {
 		data->m4u_dom = dom;
-		writel(dom->cfg.arm_v7s_cfg.ttbr[0],
+		writel(dom->cfg.arm_v7s_cfg.ttbr[0] & MMU_PT_ADDR_MASK,
 		       data->base + REG_MMU_PT_BASE_ADDR);
 	}
 
@@ -510,6 +511,7 @@ static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 
 static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 {
+	enum mtk_iommu_plat m4u_plat = data->plat_data->m4u_plat;
 	u32 regval;
 	int ret;
 
@@ -520,7 +522,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	}
 
 	regval = F_MMU_TF_PROTECT_SEL(2, data);
-	if (data->plat_data->m4u_plat == M4U_MT8173)
+	if (m4u_plat == M4U_MT8173)
 		regval |= F_MMU_PREFETCH_RT_REPLACE_MOD;
 	writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
 
@@ -541,14 +543,14 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
 	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
 
-	if (data->plat_data->m4u_plat == M4U_MT8173)
+	if (m4u_plat == M4U_MT8173)
 		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
 	else
 		regval = lower_32_bits(data->protect_base) |
 			 upper_32_bits(data->protect_base);
 	writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
 
-	if (data->enable_4GB && data->plat_data->m4u_plat != M4U_MT8173) {
+	if (data->enable_4GB && m4u_plat == M4U_MT2712) {
 		/*
 		 * If 4GB mode is enabled, the validate PA range is from
 		 * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
@@ -558,8 +560,11 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	}
 	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
 
-	/* It's MISC control register whose default value is ok except mt8173.*/
-	if (data->plat_data->m4u_plat == M4U_MT8173)
+	/*
+	 * It's MISC control register whose default value is ok
+	 * except mt8173 and mt8183.
+	 */
+	if (m4u_plat == M4U_MT8173 || m4u_plat == M4U_MT8183)
 		writel_relaxed(0, data->base + REG_MMU_STANDARD_AXI_MODE);
 
 	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
@@ -713,6 +718,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
 	struct mtk_iommu_suspend_reg *reg = &data->reg;
+	struct mtk_iommu_domain *m4u_dom = data->m4u_dom;
 	void __iomem *base = data->base;
 	int ret;
 
@@ -728,8 +734,8 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 	writel_relaxed(reg->int_control0, base + REG_MMU_INT_CONTROL0);
 	writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
 	writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
-	if (data->m4u_dom)
-		writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
+	if (m4u_dom)
+		writel(m4u_dom->cfg.arm_v7s_cfg.ttbr[0] & MMU_PT_ADDR_MASK,
 		       base + REG_MMU_PT_BASE_ADDR);
 	return 0;
 }
@@ -750,9 +756,16 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 	.has_bclk     = true,
 };
 
+static const struct mtk_iommu_plat_data mt8183_data = {
+	.m4u_plat            = M4U_MT8183,
+	.larbid_remap_enable = true,
+	.larbid_remapped     = {0, 4, 5, 6, 7, 2, 3, 1},
+};
+
 static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
 	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
+	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
 	{}
 };
 
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 3877050..6385dec 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -39,6 +39,7 @@ enum mtk_iommu_plat {
 	M4U_MT2701,
 	M4U_MT2712,
 	M4U_MT8173,
+	M4U_MT8183,
 };
 
 struct mtk_iommu_plat_data {
diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 3720c77..bced778 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -285,6 +285,12 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
 	.larb_special_mask = BIT(8) | BIT(9),          /* bdpsys */
 };
 
+static const struct mtk_smi_larb_gen mtk_smi_larb_mt8183 = {
+	.has_gals          = true,
+	.config_port       = mtk_smi_larb_config_port_gen2_general,
+	.larb_special_mask = BIT(2) | BIT(3) | BIT(7), /* IPU0 | IPU1 | CCU */
+};
+
 static const struct of_device_id mtk_smi_larb_of_ids[] = {
 	{
 		.compatible = "mediatek,mt8173-smi-larb",
@@ -298,6 +304,10 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
 		.compatible = "mediatek,mt2712-smi-larb",
 		.data = &mtk_smi_larb_mt2712
 	},
+	{
+		.compatible = "mediatek,mt8183-smi-larb",
+		.data = &mtk_smi_larb_mt8183
+	},
 	{}
 };
 
@@ -391,6 +401,11 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
 	.gen = MTK_SMI_GEN2,
 };
 
+static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
+	.gen      = MTK_SMI_GEN2,
+	.has_gals = true,
+};
+
 static const struct of_device_id mtk_smi_common_of_ids[] = {
 	{
 		.compatible = "mediatek,mt8173-smi-common",
@@ -404,6 +419,10 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
 		.compatible = "mediatek,mt2712-smi-common",
 		.data = &mtk_smi_common_gen2,
 	},
+	{
+		.compatible = "mediatek,mt8183-smi-common",
+		.data = &mtk_smi_common_mt8183,
+	},
 	{}
 };
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
