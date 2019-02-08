Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113D1C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:23:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D28FA20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jLbu7IGj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="IgrzmjkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28FA20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ioYkfIJDxL7sru5qGtmcIm6JLyC82rg4hn9i/wNKGUM=; b=jLbu7IGjVewiNlDlafilN7nsab
	K2pqc8vYcu2PI4VyKVnrLyYh6orzXqEMmcPRepk8yy0A6APWoSjrp1eyz1RrbN17v9Fhbl/HGTJhe
	g399YdQAsludJs6T4wFPDcdRHHgFQB+eoIHYUb2znOcsLAbBXaeh9A3YGMW2wDY2PCIwE8XAtuNAg
	ifmRDelLls2ErQUz0Nq2PGAhGPVa8cQrOm9tVE0jJRHGWWlJMjuU6oEuLgqGpU9cG4GAq+wDCUVS9
	TGqX0LIztXJ4L5Nmxan6aqlZFYesTL/teEsIXFxi1xJJrcLVR5GSW0d9Do0llJoRWXWqzpxogrt19
	nW0eCQGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs4Ft-0002CT-77; Fri, 08 Feb 2019 11:23:37 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs4FT-0005IB-D7
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:23:33 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 75BBA25BF16;
 Fri,  8 Feb 2019 22:14:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549624459; bh=BUxNtVRoMGIhJ1aMgQNK/FSCnfMroFvEmZHYPQiAHBs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IgrzmjkSYjOHBQJ4gVvPXswd6SBOGXXJZLK9RAf6EPoy7MUuo16bsM8A28cly/pRs
 DBIzA9JheSa6f63hJSCp4FG0AFuMpN4zCNpAPe2Y1p8d9Ao7iCSTJ9Egcw8hixyR8o
 aJWKZJfRx5FMfzkyHqP/O1FweMm1jieHcUWDe6x8=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id DBE5C940974; Fri,  8 Feb 2019 12:14:15 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 09/12] ARM: dts: r7s9210: Initial SoC device tree
Date: Fri,  8 Feb 2019 12:14:10 +0100
Message-Id: <bbbcd02b825529076951a37ee632cdb33df414c7.1549623128.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1549623128.git.horms+renesas@verge.net.au>
References: <cover.1549623128.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_032312_387590_51E85741 
X-CRM114-Status: GOOD (  10.89  )
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
Cc: Simon Horman <horms+renesas@verge.net.au>,
 Chris Brandt <chris.brandt@renesas.com>, Magnus Damm <magnus.damm@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

Basic support for the RZ/A2 (R7S9210) SoC.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s9210.dtsi | 218 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 218 insertions(+)
 create mode 100644 arch/arm/boot/dts/r7s9210.dtsi

diff --git a/arch/arm/boot/dts/r7s9210.dtsi b/arch/arm/boot/dts/r7s9210.dtsi
new file mode 100644
index 000000000000..22baa96f5974
--- /dev/null
+++ b/arch/arm/boot/dts/r7s9210.dtsi
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the R7S9210 SoC
+ *
+ * Copyright (C) 2018 Renesas Electronics Corporation
+ *
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/r7s9210-cpg-mssr.h>
+
+/ {
+	compatible = "renesas,r7s9210";
+	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	/* External clocks */
+	extal_clk: extal {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		/* Value must be set by board */
+		clock-frequency = <0>;
+	};
+
+	rtc_x1_clk: rtc_x1 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		/* If clk present, value (32678) must be set by board */
+		clock-frequency = <0>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+			clock-frequency = <528000000>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		L2: cache-controller@1f003000 {
+			compatible = "arm,pl310-cache";
+			reg = <0x1f003000 0x1000>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			arm,early-bresp-disable;
+			arm,full-line-zero-disable;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		scif0: serial@e8007000 {
+			compatible = "renesas,scif-r7s9210";
+			reg = <0xe8007000 0x18>;
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD 47>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		scif1: serial@e8007800 {
+			compatible = "renesas,scif-r7s9210";
+			reg = <0xe8007800 0x18>;
+			interrupts = <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD 46>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		scif2: serial@e8008000 {
+			compatible = "renesas,scif-r7s9210";
+			reg = <0xe8008000 0x18>;
+			interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD 45>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		scif3: serial@e8008800 {
+			compatible = "renesas,scif-r7s9210";
+			reg = <0xe8008800 0x18>;
+			interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD 44>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		scif4: serial@e8009000 {
+			compatible = "renesas,scif-r7s9210";
+			reg = <0xe8009000 0x18>;
+			interrupts = <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 291 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 292 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 292 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD 43>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		ostm0: timer@e803b000 {
+			compatible = "renesas,r7s9210-ostm", "renesas,ostm";
+			reg = <0xe803b000 0x30>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD 36>;
+			clock-names = "ostm0";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		ostm1: timer@e803c000 {
+			compatible = "renesas,r7s9210-ostm", "renesas,ostm";
+			reg = <0xe803c000 0x30>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD 35>;
+			clock-names = "ostm1";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		ostm2: timer@e803d000 {
+			compatible = "renesas,r7s9210-ostm", "renesas,ostm";
+			reg = <0xe803d000 0x30>;
+			interrupts = <GIC_SPI 58 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD 34>;
+			clock-names = "ostm2";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller@e8221000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0xe8221000 0x1000>,
+			      <0xe8222000 0x1000>;
+		};
+
+		cpg: clock-controller@fcfe0010 {
+			compatible = "renesas,r7s9210-cpg-mssr";
+			reg = <0xfcfe0010 0x455>;
+			clocks = <&extal_clk>;
+			clock-names = "extal";
+			#clock-cells = <2>;
+			#power-domain-cells = <0>;
+		};
+
+		wdt: watchdog@fcfe7000 {
+			compatible = "renesas,r7s9210-wdt", "renesas,rza-wdt";
+			reg = <0xfcfe7000 0x26>;
+			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_CORE R7S9210_CLK_P0>;
+		};
+
+		bsid: chipid@fcfe8004 {
+			compatible = "renesas,bsid";
+			reg = <0xfcfe8004 4>;
+		};
+
+		pinctrl: pin-controller@fcffe000 {
+			compatible = "renesas,r7s9210-pinctrl";
+			reg = <0xfcffe000 0x1000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 0 176>;
+		};
+	};
+};
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
