Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFEBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:38:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D58D320672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GMNZgCOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58D320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4sAWOY4fk1Xbc5Bt3e9WOTobSKKIBBogTjWBrdOf0gQ=; b=GMNZgCOzZ5Bei5
	8lxBxxmfrxuibqz+B7C5QAarOX49quwm5lWY79f5xfYC/in6U9kin+wiCUitdGwD1hq1MxEu+B3xp
	+F+tjl1SeO+2+swVGCH2LSN2k5ifW9YwFxcrQJaFsK8LluozIOp6nmdGvDJtrz+3YdIxIcHJdn5/O
	M2AplL1bUsBVJlG6ieD54lSH0NWoa9+9tYP9MoYH5b6ikmZjct1N/cD9GELzelvG/skwENA2qM61P
	F8KK7VHJkz7aiJr8fRzTUKX9jKRYDD8CqR3uJfTGv5cQurGqor+zYAJ+f48+oA/q2/K9CK2rSzAUC
	WMR4ohG8//XuhP1VTqDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYsAP-0003kE-Qx; Mon, 17 Dec 2018 12:38:37 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYs97-0002SN-O9; Mon, 17 Dec 2018 12:37:21 +0000
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80]
 helo=phil.dip.tu-dresden.de)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gYs8t-0003o4-8O; Mon, 17 Dec 2018 13:37:03 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	hjc@rock-chips.com
Subject: [PATCH 07/15] drm/rockchip: dw-mipi-dsi: add support for
 rk3368-variant
Date: Mon, 17 Dec 2018 13:36:42 +0100
Message-Id: <20181217123650.6773-8-heiko@sntech.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181217123650.6773-1-heiko@sntech.de>
References: <20181217123650.6773-1-heiko@sntech.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_043718_093020_D74C3F7C 
X-CRM114-Status: GOOD (  14.11  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, architt@codeaurora.org,
 Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, a.hajda@samsung.com, robh+dt@kernel.org,
 Laurent.pinchart@ideasonboard.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the compatible and grf values and allow the driver to also
not select a specific crtc input on systems with only one vop.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../display/rockchip/dw_mipi_dsi_rockchip.txt |  1 +
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 25 +++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
index 6bb59ab39f2f..869fbc256d51 100644
--- a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
@@ -5,6 +5,7 @@ Required properties:
 - #address-cells: Should be <1>.
 - #size-cells: Should be <0>.
 - compatible: "rockchip,rk3288-mipi-dsi", "snps,dw-mipi-dsi".
+	      "rockchip,rk3368-mipi-dsi", "snps,dw-mipi-dsi".
 	      "rockchip,rk3399-mipi-dsi", "snps,dw-mipi-dsi".
 - reg: Represent the physical address range of the controller.
 - interrupts: Represent the controller's interrupt to the CPU(s).
diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 7ee359bcee62..041647bfce71 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -142,6 +142,11 @@
 #define RK3288_DSI0_LCDC_SEL		BIT(6)
 #define RK3288_DSI1_LCDC_SEL		BIT(9)
 
+#define RK3368_GRF_SOC_CON7		0x41c
+#define RK3368_DSI_TURNDISABLE		BIT(5)
+#define RK3368_DSI_FORCERXMODE		BIT(6)
+#define RK3368_DSI_FORCETXSTOPMODE	(0xf << 7)
+
 #define RK3399_GRF_SOC_CON20		0x6250
 #define RK3399_DSI0_LCDC_SEL		BIT(0)
 #define RK3399_DSI1_LCDC_SEL		BIT(4)
@@ -192,7 +197,7 @@ enum {
 struct rockchip_dw_dsi_chip_data {
 	u32 reg;
 
-	u32 lcdsel_grf_reg;
+	int lcdsel_grf_reg;
 	u32 lcdsel_big;
 	u32 lcdsel_lit;
 
@@ -566,7 +571,7 @@ static const struct dw_mipi_dsi_phy_ops dw_mipi_dsi_rockchip_phy_ops = {
 static void dw_mipi_dsi_rockchip_config(struct dw_mipi_dsi_rockchip *dsi,
 					int mux)
 {
-	if (dsi->cdata->lcdsel_grf_reg)
+	if (dsi->cdata->lcdsel_grf_reg >= 0)
 		regmap_write(dsi->grf_regmap, dsi->cdata->lcdsel_grf_reg,
 			mux ? dsi->cdata->lcdsel_lit : dsi->cdata->lcdsel_big);
 
@@ -1008,6 +1013,19 @@ static const struct rockchip_dw_dsi_chip_data rk3288_chip_data[] = {
 	{ /* sentinel */ }
 };
 
+static const struct rockchip_dw_dsi_chip_data rk3368_chip_data[] = {
+	{
+		.reg = 0xff960000,
+		.lcdsel_grf_reg = -1,
+		.lanecfg1_grf_reg = RK3368_GRF_SOC_CON7,
+		.lanecfg1 = HIWORD_UPDATE(0, RK3368_DSI_TURNDISABLE |
+					     RK3368_DSI_FORCERXMODE |
+					     RK3368_DSI_FORCETXSTOPMODE),
+		.max_data_lanes = 4,
+	},
+	{ /* sentinel */ }
+};
+
 static const struct rockchip_dw_dsi_chip_data rk3399_chip_data[] = {
 	{
 		.reg = 0xff960000,
@@ -1058,6 +1076,9 @@ static const struct of_device_id dw_mipi_dsi_rockchip_dt_ids[] = {
 	{
 	 .compatible = "rockchip,rk3288-mipi-dsi",
 	 .data = &rk3288_chip_data,
+	}, {
+	 .compatible = "rockchip,rk3368-mipi-dsi",
+	 .data = &rk3368_chip_data,
 	}, {
 	 .compatible = "rockchip,rk3399-mipi-dsi",
 	 .data = &rk3399_chip_data,
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
