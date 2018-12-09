Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5A4C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 10:22:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6638A20831
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 10:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CtvpmTs+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yEEglREe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6638A20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SUo9N7p8hwP2GpjgoMxqOEMG1XBsagra3pBULd/5zSQ=; b=CtvpmTs+75jBfv
	hNUIVtasteXHozYn4ZfltXTsCpSKieKupUFT72tjcTlRRPWzah9MTMBlLezw0AackgoE0e0srcmjd
	ww/BQ4WRbHkdaGD2FkddASQPLfzRDVxWn7VCqfvuVb6UIyGVvk3LSOZk6I2f8CuE+JHfd7rSyRWma
	siohKD7pAQRq7B+J8q7Arv97bqY3iS7ULYU2tRqt1RCD8XUBKUjcjxKdXfG4x+TfaUJH3br9TOQ6X
	6bQGPEWoT8fMcj8Hu4huYr/vj9rri7kROcIGUAR99HQKaONrjpxaLHY+pe9E0JzWBMlWeAciJAdiP
	VnZpHarqlztINS/UYmGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVwE5-0001OX-My; Sun, 09 Dec 2018 10:22:17 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVwDY-00011L-2a
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 10:21:45 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB9ALWsW052475;
 Sun, 9 Dec 2018 04:21:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544350892;
 bh=XGoiTSNXtYZhMXLAQ7Z8aJBCXAD/iRwvWnB8L11d+UM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=yEEglREeFboX3dLjfrfLNRtRvfIN+HOejKD9W4hIXLWOFINKIQmokDiVIgRi5HTgp
 EfH0X4X1aBLfEkW43IDTeToftfzfvfDOJyH8swes68UZ9MQiL8qTsiNsnvYUqm03ow
 s7j294EqiGefA8O/H6VSaTYKM+JemIu4xK5wMBTw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB9ALVNK053583
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 9 Dec 2018 04:21:32 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 9
 Dec 2018 04:21:31 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 9 Dec 2018 04:21:31 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB9ALQ8L007865;
 Sun, 9 Dec 2018 04:21:29 -0600
From: Vignesh R <vigneshr@ti.com>
To: Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-am654: Add McSPI DT nodes
Date: Sun, 9 Dec 2018 15:52:21 +0530
Message-ID: <20181209102222.7624-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181209102222.7624-1-vigneshr@ti.com>
References: <20181209102222.7624-1-vigneshr@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_022144_189582_3947591C 
X-CRM114-Status: GOOD (  12.76  )
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
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Vignesh R <vigneshr@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There are 3 instances of McSPI in MCU domain and 4 instances in Main domain.
Add DT nodes for all McSPI instances present on AM654 SoC.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 52 ++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi  | 30 ++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 0a0a8fc5df64..6c71e67b8988 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -138,4 +138,56 @@
 		clocks = <&k3_clks 39 0>;
 		clock-names = "fck";
 	};
+
+	main_spi0: spi@2100000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x0 0x2100000 0x0 0x400>;
+		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 137 1>;
+		power-domains = <&k3_pds 137>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	main_spi1: spi@2110000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x0 0x2110000 0x0 0x400>;
+		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 138 1>;
+		power-domains = <&k3_pds 138>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		assigned-clocks = <&k3_clks 137 1>;
+		assigned-clock-rates = <48000000>;
+	};
+
+	main_spi2: spi@2120000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x0 0x2120000 0x0 0x400>;
+		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 139 1>;
+		power-domains = <&k3_pds 139>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	main_spi3: spi@2130000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x0 0x2130000 0x0 0x400>;
+		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 140 1>;
+		power-domains = <&k3_pds 140>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	main_spi4: spi@2140000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x0 0x2140000 0x0 0x400>;
+		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 141 1>;
+		power-domains = <&k3_pds 141>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 1fd027748e1f..1aeae52fb239 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -26,4 +26,34 @@
 		clocks = <&k3_clks 114 1>;
 		power-domains = <&k3_pds 114>;
 	};
+
+	mcu_spi0: spi@40300000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x0 0x40300000 0x0 0x400>;
+		interrupts = <GIC_SPI 560 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 142 1>;
+		power-domains = <&k3_pds 142>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	mcu_spi1: spi@40310000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x0 0x40310000 0x0 0x400>;
+		interrupts = <GIC_SPI 561 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 143 1>;
+		power-domains = <&k3_pds 143>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	mcu_spi2: spi@40320000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x0 0x40320000 0x0 0x400>;
+		interrupts = <GIC_SPI 562 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 144 1>;
+		power-domains = <&k3_pds 144>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
 };
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
