Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE89C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:37:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5561B20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UaxMKiEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5561B20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1lccOqNdxi2e2EjpnekpQxa7VAiFrSfTPOnfBfPNHbg=; b=UaxMKiEYWCOTJx
	QfAxPX9pK7/EZQybZdhNc+ktYNzLSj/jCKBHG4LDl7MXEcVWK9YYFLu/nH8Cwp4RTT8VStkqT077l
	usRJgNd2GZom15yS8QgM4lWxvWwKrDpspjRwZplyu11VS09tUhqmsV9WOg/kG9+NAQv4rH0ylJPOo
	GbYm7AfdWyiqj9aTgXg87BXBG+8vNPsz7AApfu7v8SVKAUucQsBB9vtVsQ0ChNPinBH7yMXYvlAQ6
	0wf1vVC/tMP+AuWFpMCxmWs4o8YfvTsBUjDVzfgywR5Yb/PCHrzno4dpWBsWYosLUucoYwKz/xMP5
	RjvgFDNuWhspVQTS2wzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTmX0-00055Z-IM; Mon, 03 Dec 2018 11:36:54 +0000
Received: from [210.61.82.184] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTmWi-0004l3-9O; Mon, 03 Dec 2018 11:36:38 +0000
X-UUID: e46e1232a2c34a38b9c90099b25a15a6-20181203
X-UUID: e46e1232a2c34a38b9c90099b25a15a6-20181203
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by
 mailgw02.mediatek.com (envelope-from <yt.shen@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1057093915; Mon, 03 Dec 2018 19:36:23 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 3 Dec 2018 19:36:22 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Mon, 3 Dec 2018 19:36:22 +0800
From: YT Shen <yt.shen@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 2/8] arm64: dts: add iommu/smi nodes for MT2712
Date: Mon, 3 Dec 2018 19:35:56 +0800
Message-ID: <1543836962-18293-3-git-send-email-yt.shen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543836962-18293-1-git-send-email-yt.shen@mediatek.com>
References: <1543836962-18293-1-git-send-email-yt.shen@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_033636_577473_EF1E98D8 
X-CRM114-Status: UNSURE (   9.41  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 YT Shen <yt.shen@mediatek.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Signed-off-by: YT Shen <yt.shen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 128 ++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 6c228a2..d429770 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/mt2712-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/memory/mt2712-larb-port.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/power/mt2712-power.h>
 #include "mt2712-pinfunc.h"
@@ -313,12 +314,33 @@
 		status = "disabled";
 	};
 
+	iommu0: iommu@10205000 {
+		compatible = "mediatek,mt2712-m4u";
+		reg = <0 0x10205000 0 0x1000>;
+		interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infracfg CLK_INFRA_M4U>;
+		clock-names = "bclk";
+		mediatek,larbs = <&larb0 &larb1 &larb2
+				  &larb3 &larb6>;
+		#iommu-cells = <1>;
+	};
+
 	apmixedsys: syscon@10209000 {
 		compatible = "mediatek,mt2712-apmixedsys", "syscon";
 		reg = <0 0x10209000 0 0x1000>;
 		#clock-cells = <1>;
 	};
 
+	iommu1: iommu@1020a000 {
+		compatible = "mediatek,mt2712-m4u";
+		reg = <0 0x1020a000 0 0x1000>;
+		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infracfg CLK_INFRA_M4U>;
+		clock-names = "bclk";
+		mediatek,larbs = <&larb4 &larb5 &larb7>;
+		#iommu-cells = <1>;
+	};
+
 	mcucfg: syscon@10220000 {
 		compatible = "mediatek,mt2712-mcucfg", "syscon";
 		reg = <0 0x10220000 0 0x1000>;
@@ -543,12 +565,85 @@
 		#clock-cells = <1>;
 	};
 
+	larb0: larb@14021000 {
+		compatible = "mediatek,mt2712-smi-larb";
+		reg = <0 0x14021000 0 0x1000>;
+		mediatek,smi = <&smi_common0>;
+		mediatek,larb-id = <0>;
+		power-domains = <&scpsys MT2712_POWER_DOMAIN_MM>;
+		clocks = <&mmsys CLK_MM_SMI_LARB0>,
+			 <&mmsys CLK_MM_SMI_LARB0>;
+		clock-names = "apb", "smi";
+	};
+
+	smi_common0: smi@14022000 {
+		compatible = "mediatek,mt2712-smi-common";
+		reg = <0 0x14022000 0 0x1000>;
+		power-domains = <&scpsys MT2712_POWER_DOMAIN_MM>;
+		clocks = <&mmsys CLK_MM_SMI_COMMON>,
+			 <&mmsys CLK_MM_SMI_COMMON>;
+		clock-names = "apb", "smi";
+	};
+
+	larb4: larb@14027000 {
+		compatible = "mediatek,mt2712-smi-larb";
+		reg = <0 0x14027000 0 0x1000>;
+		mediatek,smi = <&smi_common1>;
+		mediatek,larb-id = <4>;
+		power-domains = <&scpsys MT2712_POWER_DOMAIN_MM>;
+		clocks = <&mmsys CLK_MM_SMI_LARB4>,
+			 <&mmsys CLK_MM_SMI_LARB4>;
+		clock-names = "apb", "smi";
+	};
+
+	larb5: larb@14030000 {
+		compatible = "mediatek,mt2712-smi-larb";
+		reg = <0 0x14030000 0 0x1000>;
+		mediatek,smi = <&smi_common1>;
+		mediatek,larb-id = <5>;
+		power-domains = <&scpsys MT2712_POWER_DOMAIN_MM>;
+		clocks = <&mmsys CLK_MM_SMI_LARB5>,
+			 <&mmsys CLK_MM_SMI_LARB5>;
+		clock-names = "apb", "smi";
+	};
+
+	smi_common1: smi@14031000 {
+		compatible = "mediatek,mt2712-smi-common";
+		reg = <0 0x14031000 0 0x1000>;
+		power-domains = <&scpsys MT2712_POWER_DOMAIN_MM>;
+		clocks = <&mmsys CLK_MM_SMI_COMMON1>,
+			 <&mmsys CLK_MM_SMI_COMMON1>;
+		clock-names = "apb", "smi";
+	};
+
+	larb7: larb@14032000 {
+		compatible = "mediatek,mt2712-smi-larb";
+		reg = <0 0x14032000 0 0x1000>;
+		mediatek,smi = <&smi_common1>;
+		mediatek,larb-id = <7>;
+		power-domains = <&scpsys MT2712_POWER_DOMAIN_MM>;
+		clocks = <&mmsys CLK_MM_SMI_LARB7>,
+			 <&mmsys CLK_MM_SMI_LARB7>;
+		clock-names = "apb", "smi";
+	};
+
 	imgsys: syscon@15000000 {
 		compatible = "mediatek,mt2712-imgsys", "syscon";
 		reg = <0 0x15000000 0 0x1000>;
 		#clock-cells = <1>;
 	};
 
+	larb2: larb@15001000 {
+		compatible = "mediatek,mt2712-smi-larb";
+		reg = <0 0x15001000 0 0x1000>;
+		mediatek,smi = <&smi_common0>;
+		mediatek,larb-id = <2>;
+		power-domains = <&scpsys MT2712_POWER_DOMAIN_ISP>;
+		clocks = <&imgsys CLK_IMG_SMI_LARB2>,
+			 <&imgsys CLK_IMG_SMI_LARB2>;
+		clock-names = "apb", "smi";
+	};
+
 	bdpsys: syscon@15010000 {
 		compatible = "mediatek,mt2712-bdpsys", "syscon";
 		reg = <0 0x15010000 0 0x1000>;
@@ -561,12 +656,45 @@
 		#clock-cells = <1>;
 	};
 
+	larb1: larb@16010000 {
+		compatible = "mediatek,mt2712-smi-larb";
+		reg = <0 0x16010000 0 0x1000>;
+		mediatek,smi = <&smi_common0>;
+		mediatek,larb-id = <1>;
+		power-domains = <&scpsys MT2712_POWER_DOMAIN_VDEC>;
+		clocks = <&vdecsys CLK_VDEC_CKEN>,
+			 <&vdecsys CLK_VDEC_LARB1_CKEN>;
+		clock-names = "apb", "smi";
+	};
+
 	vencsys: syscon@18000000 {
 		compatible = "mediatek,mt2712-vencsys", "syscon";
 		reg = <0 0x18000000 0 0x1000>;
 		#clock-cells = <1>;
 	};
 
+	larb3: larb@18001000 {
+		compatible = "mediatek,mt2712-smi-larb";
+		reg = <0 0x18001000 0 0x1000>;
+		mediatek,smi = <&smi_common0>;
+		mediatek,larb-id = <3>;
+		power-domains = <&scpsys MT2712_POWER_DOMAIN_VENC>;
+		clocks = <&vencsys CLK_VENC_SMI_COMMON_CON>,
+			 <&vencsys CLK_VENC_VENC>;
+		clock-names = "apb", "smi";
+	};
+
+	larb6: larb@18002000 {
+		compatible = "mediatek,mt2712-smi-larb";
+		reg = <0 0x18002000 0 0x1000>;
+		mediatek,smi = <&smi_common0>;
+		mediatek,larb-id = <6>;
+		power-domains = <&scpsys MT2712_POWER_DOMAIN_VENC>;
+		clocks = <&vencsys CLK_VENC_SMI_COMMON_CON>,
+			 <&vencsys CLK_VENC_VENC>;
+		clock-names = "apb", "smi";
+	};
+
 	jpgdecsys: syscon@19000000 {
 		compatible = "mediatek,mt2712-jpgdecsys", "syscon";
 		reg = <0 0x19000000 0 0x1000>;
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
