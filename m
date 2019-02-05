Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160CEC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:46:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF3A22080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MspEywsS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SJyC4N8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3A22080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RMW/QN8iyS8CUkJewhkmm5gT+gmoH363qJbcAlL+l9U=; b=MspEywsS2EyvCe
	xepweCjKrJX3haYMDW9dkDursfakyoDMz9pX/wrqxjXJAw8KVrwonre5u8tWn1Eu5vIDRl+vWufVJ
	25XKhmUgnwEuJ1FO3OTcKedyHjI/gzVWvwBrX6chIh0lIJTsqPXOl0tW6gWVo3c5XVwgusuUXohvj
	aJa4uZ1ArdeAb3SJOkT/VYnEfG+lL0GZiW5+D+BIQnjkl/h7VQM0iSCWybao68s/btRriD2gfhlWJ
	Mw2ityxWSdVbKZaiF0C/rb+ChKMyjs+43rXdxv7TvaGMtWc4TmETjPF1HFkXgVfUflblAEJXi5otd
	lZiznZsQQWnwOADnboPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr06t-0005ax-C3; Tue, 05 Feb 2019 12:45:55 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr06W-0005C8-10
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 12:45:34 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x15CjVtf002601;
 Tue, 5 Feb 2019 06:45:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549370731;
 bh=1GVgpiGNWts2UcU2s8/GvFzfISCRRhs9Y1ATdyse4GE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=SJyC4N8tjd7HsJEuMzjKr228j1Cf6Y/ZV1bLo5uF7MzglH9XbzkP8pSqtJVYCqWcN
 KOmkppiK/T8SJJ7yeFu0ZN4oQB9OSZGiqqltOgkEtxE3KWhpyIhaARmVE1gJ1QZTMd
 q0yIljDj+7E7LNBsLZWX4ZjBozd/HnJv2gzbUzlk=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x15CjVOG008600
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Feb 2019 06:45:31 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 5
 Feb 2019 06:45:31 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 5 Feb 2019 06:45:31 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x15CjOVO012216;
 Tue, 5 Feb 2019 06:45:29 -0600
From: Roger Quadros <rogerq@ti.com>
To: <t-kristo@ti.com>
Subject: [PATCH v2 2/3] arm64: dts: ti: k3-am6: add USB support
Date: Tue, 5 Feb 2019 14:45:21 +0200
Message-ID: <1549370722-414-3-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549370722-414-1-git-send-email-rogerq@ti.com>
References: <1549370722-414-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_044532_518769_D96D5180 
X-CRM114-Status: GOOD (  14.46  )
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
Cc: nm@ti.com, devicetree@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Roger Quadros <rogerq@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Adds support for USB0 and USB1 instances on the AM6 SoC.
USB0 is limited to high-speed for now.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 76 ++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 7b0acf2..9ae62d5 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -213,4 +213,80 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x00100000 0x1c000>;
 	};
+
+	dwc3_0: dwc3@4000000 {
+		compatible = "ti,am654-dwc3";
+		reg = <0x0 0x4000000 0x0 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x4000000 0x20000>;
+		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+		dma-coherent;
+		power-domains = <&k3_pds 151>;
+		assigned-clocks = <&k3_clks 151 2>, <&k3_clks 151 7>;
+		assigned-clock-parents = <&k3_clks 151 4>,	/* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
+					 <&k3_clks 151 9>;	/* set PIPE3_TXB_CLK to CLK_12M_RC/256 (for HS only) */
+
+		usb0: usb@10000 {
+			compatible = "snps,dwc3";
+			reg = <0x10000 0x10000>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "peripheral",
+					  "host",
+					  "otg";
+			maximum-speed = "high-speed";
+			dr_mode = "otg";
+			phys = <&usb0_phy>;
+			phy-names = "usb2-phy";
+			snps,dis_u3_susphy_quirk;
+		};
+	};
+
+	usb0_phy: phy@4100000 {
+		compatible = "ti,am654-usb2", "ti,omap-usb2";
+		reg = <0x0 0x4100000 0x0 0x54>;
+		syscon-phy-power = <&scm_conf 0x4000>;
+		clocks = <&k3_clks 151 0>, <&k3_clks 151 1>;
+		clock-names = "wkupclk", "refclk";
+		#phy-cells = <0>;
+	};
+
+	dwc3_1: dwc3@4020000 {
+		compatible = "ti,am654-dwc3";
+		reg = <0x0 0x4020000 0x0 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x4020000 0x20000>;
+		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+		dma-coherent;
+		power-domains = <&k3_pds 152>;
+		assigned-clocks = <&k3_clks 152 2>;
+		assigned-clock-parents = <&k3_clks 152 4>;	/* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
+
+		usb1: usb@10000 {
+			compatible = "snps,dwc3";
+			reg = <0x10000 0x10000>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "peripheral",
+					  "host",
+					  "otg";
+			maximum-speed = "high-speed";
+			dr_mode = "otg";
+			phys = <&usb1_phy>;
+			phy-names = "usb2-phy";
+		};
+	};
+
+	usb1_phy: phy@4110000 {
+		compatible = "ti,am654-usb2", "ti,omap-usb2";
+		reg = <0x0 0x4110000 0x0 0x54>;
+		syscon-phy-power = <&scm_conf 0x4020>;
+		clocks = <&k3_clks 152 0>, <&k3_clks 152 1>;
+		clock-names = "wkupclk", "refclk";
+		#phy-cells = <0>;
+	};
 };
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
