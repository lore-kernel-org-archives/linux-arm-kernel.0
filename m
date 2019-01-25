Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD6DC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:26:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06F6A218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="juR63mIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F6A218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=kVuLkiT4NGzCBt40lXa2+L5F9AcFpQzmlFegxZvB8Sc=; b=juR63mIi6IR80J
	0EW8gVD2rNrPP2E83q4Ya7EE14EhxX9LlTnzuQfB+WFK0jIb5INWqqKJcO74ThDwzNUDmLDEfL3S1
	6S5sDI/EHXHW16xHEvtok7iK9ZJcg0XI9kjB5ffYBgsevUvZysKnFksImsCueh4K15+j1fQIbOCax
	xWzWuEMl0POcaCIl6zdjcIVO2iUNNr1zsmZV3S+5zWVnO0omTLEtRhtfK7vqStYzKOqt4esVHcbC1
	W13+hpPPNXWGo/gRaN4Y85qLcVTX+AFSwepIQBDG7SpMymB9ciwHEkld2M3kMpUVaCvCJSEUy+e9d
	DnLnt43kp4hiaaLo+Bew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn4Ix-0003X6-8m; Fri, 25 Jan 2019 16:26:07 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn4It-0003WM-AC
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 16:26:04 +0000
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28]
 helo=dude02.pengutronix.de.)
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gn4Ip-0005NH-Qb; Fri, 25 Jan 2019 17:25:59 +0100
From: Lucas Stach <l.stach@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2 1/2] arm64: dts: fsl: imx8mq: add USB nodes
Date: Fri, 25 Jan 2019 17:25:58 +0100
Message-Id: <20190125162559.15101-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_082603_504005_2B6D6411 
X-CRM114-Status: UNSURE (   8.02  )
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
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v2: Drop snps,power-down-scale, which isn't supported by upstream
    driver, yet.
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 64 +++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index af2584d51fa2..51c9e899c35d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -472,6 +472,70 @@
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
