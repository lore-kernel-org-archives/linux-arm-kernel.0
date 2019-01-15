Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9359BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:03:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615502085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oL+QyDLW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615502085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hFFEl+SS+EgWgtVh4/RcRrBuYicSINOvmwGy1OIcOCU=; b=oL+QyDLWjppXoL
	kycgRUum6BWpTzgCYXZBv1lK8qvVXgTGo2qnAAfqQOblRjO17D1IYD4mAgp+a4Jm5NuQWKAHSO0Z4
	EZCGeDgOv7AO53Xr7Hk4FLabvjtVaC5yxBh1oePWkL8G6/Hy7o8sN/Vnkm9i/GPTx9VbMRe2AuLKG
	ICGdOwkVPjD8ichcH0bt3LQI+FuYyFnTTniZ8U3Hq17V2Nuh91rOzKBRZgr0haytqjvKvoTHXbR/u
	BiGhQUcBbggdB0ZL90gV+x/YLGBqs9SbN4Aw3qIQh0LZ5J2bxTZULyfrTMopoHoy7whlrFUjBsFa6
	lrRmGf25+DEG4Gj0M/Pw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjMVI-00046m-Ow; Tue, 15 Jan 2019 11:03:32 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjMVE-00046B-Qb
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 11:03:30 +0000
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28]
 helo=dude02.pengutronix.de.)
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gjMVB-0005Vm-Dl; Tue, 15 Jan 2019 12:03:25 +0100
From: Lucas Stach <l.stach@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 1/2] arm64: dts: fsl: imx8mq: add USB nodes
Date: Tue, 15 Jan 2019 12:03:24 +0100
Message-Id: <20190115110325.13236-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_030329_034574_7155FF15 
X-CRM114-Status: UNSURE (   8.26  )
X-CRM114-Notice: Please train this message.
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, patchwork-lst@pengutronix.de,
 NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 66 +++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 5bd1f106ed84..d25ab50d6b88 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -470,6 +470,72 @@
 			};
 		};
 
+		usb_dwc3_0: usb@38100000 {
+			compatible = "fsl,imx8mq-dwc3", "snps,dwc3";
+			reg = <0x38100000 0x10000>;
+			clocks = <&clk IMX8MQ_CLK_USB_BUS>,
+			         <&clk IMX8MQ_CLK_USB_CORE_REF>,
+			         <&clk IMX8MQ_CLK_USB1_CTRL_ROOT>;
+			clock-names = "bus_early", "ref", "suspend";
+			assigned-clocks = <&clk IMX8MQ_CLK_USB_BUS>,
+			                  <&clk IMX8MQ_CLK_USB_CORE_REF>;
+			assigned-clock-parents = <&clk IMX8MQ_SYS2_PLL_500M>,
+			                         <&clk IMX8MQ_SYS1_PLL_100M>;
+			assigned-clock-rates = <500000000>, <100000000>;
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb3_phy0>, <&usb3_phy0>;
+			phy-names = "usb2-phy", "usb3-phy";
+			power-domains = <&pgc_otg1>;
+			snps,power-down-scale = <2>;
+			usb3-resume-missing-cas;
+			status = "disabled";
+		};
+
+		usb3_phy0: phy@381f0040 {
+			compatible = "fsl,imx8mq-usb-phy";
+			reg = <0x381f0040 0x40>;
+			clocks = <&clk IMX8MQ_CLK_USB1_PHY_ROOT>;
+			clock-names = "phy";
+			assigned-clocks = <&clk IMX8MQ_CLK_USB_PHY_REF>;
+			assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_100M>;
+			assigned-clock-rates = <100000000>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		usb_dwc3_1: usb@38200000 {
+			compatible = "fsl,imx8mq-dwc3", "snps,dwc3";
+			reg = <0x38200000 0x10000>;
+			clocks = <&clk IMX8MQ_CLK_USB_BUS>,
+			         <&clk IMX8MQ_CLK_USB_CORE_REF>,
+			         <&clk IMX8MQ_CLK_USB2_CTRL_ROOT>;
+			clock-names = "bus_early", "ref", "suspend";
+			assigned-clocks = <&clk IMX8MQ_CLK_USB_BUS>,
+			                  <&clk IMX8MQ_CLK_USB_CORE_REF>;
+			assigned-clock-parents = <&clk IMX8MQ_SYS2_PLL_500M>,
+			                         <&clk IMX8MQ_SYS1_PLL_100M>;
+			assigned-clock-rates = <500000000>, <100000000>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb3_phy1>, <&usb3_phy1>;
+			phy-names = "usb2-phy", "usb3-phy";
+			power-domains = <&pgc_otg2>;
+			snps,power-down-scale = <2>;
+			usb3-resume-missing-cas;
+			status = "disabled";
+		};
+
+		usb3_phy1: phy@382f0040 {
+			compatible = "fsl,imx8mq-usb-phy";
+			reg = <0x382f0040 0x40>;
+			clocks = <&clk IMX8MQ_CLK_USB2_PHY_ROOT>;
+			clock-names = "phy";
+			assigned-clocks = <&clk IMX8MQ_CLK_USB_PHY_REF>;
+			assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_100M>;
+			assigned-clock-rates = <100000000>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@38800000 {
 			compatible = "arm,gic-v3";
 			reg = <0x38800000 0x10000>,	/* GIC Dist */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
