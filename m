Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138D2C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:54:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3EE32081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q/Zaoduu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3EE32081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tnPNSCczp16Q5ramD5lftRXv52OFlGJptR1KRS3M1AU=; b=Q/Zaoduu/jkfUB
	NfCGv7YjdViOaNI5me+NywIsqFcm7ogYLr6HZkwjlVYJ2bY7mDW9gH1cqdMc+9XEPVNdI2dPUZUDl
	z43lozuYc77XoN5ejsG9nvkW7z/7FZB1zTZtUgxaNO/PmLKibwRccSMV1v7k3lhLjfkYNkVvgLFXU
	oYN4l6V+xZHhcG8IKb63ej0b7AOtCH0o1N98oj9cnGzpA/mBkm3d4HaEUugHijd0WaxbPbxZkmGZ7
	5wVN763qdmctC3Tamz/+PEk3eK5mCL380ytnvZBbxnWylQe7l9h1W2UAiYxJQsL8CyAoYpXNtvXwl
	x1KrZAUygofP9LTD78Dw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVQtL-0003qr-7m; Sat, 08 Dec 2018 00:54:47 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVQtG-0003q0-MP
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 00:54:45 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 1090480C0;
 Sat,  8 Dec 2018 00:54:31 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Subject: [PATCH] ARM: dts: Add missing ranges for dra7 mcasp l3 ports
Date: Fri,  7 Dec 2018 16:54:03 -0800
Message-Id: <20181208005403.26330-1-tony@atomide.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_165442_793322_69AFED1D 
X-CRM114-Status: UNSURE (   9.51  )
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, devicetree@vger.kernel.org,
 =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

We need to add mcasp l3 port ranges for mcasp to use a correct l3
data port address for dma. And we're also missing the optional clocks
that we have tagged with HWMOD_OPT_CLKS_NEEDED in omap_hwmod_7xx_data.c.

Note that for reading the module revision register HWMOD_OPT_CLKS_NEEDED
do not seem to be needed. So they could be probably directly managed
only by the mcasp driver, and then we could leave them out for the
interconnect target module.

Fixes: 4ed0dfe3cf39 ("ARM: dts: dra7: Move l4 child devices to probe
them with ti-sysc")
Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7-l4.dtsi | 92 ++++++++++++++++++++++++----------
 1 file changed, 66 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -2296,7 +2296,15 @@
 	reg-names = "ap", "la", "ia0", "ia1", "ia2";
 	#address-cells = <1>;
 	#size-cells = <1>;
-	ranges = <0x00000000 0x48400000 0x400000>;	/* segment 0 */
+	ranges = <0x00000000 0x48400000 0x400000>,	/* segment 0 */
+		 <0x45800000 0x45800000 0x400000>,	/* L3 data port */
+		 <0x45c00000 0x45c00000 0x400000>,	/* L3 data port */
+		 <0x46000000 0x46000000 0x400000>,	/* L3 data port */
+		 <0x48436000 0x48436000 0x400000>,	/* L3 data port */
+		 <0x4843a000 0x4843a000 0x400000>,	/* L3 data port */
+		 <0x4844c000 0x4844c000 0x400000>,	/* L3 data port */
+		 <0x48450000 0x48450000 0x400000>,	/* L3 data port */
+		 <0x48454000 0x48454000 0x400000>;	/* L3 data port */
 
 	segment@0 {					/* 0x48400000 */
 		compatible = "simple-bus";
@@ -2364,7 +2372,15 @@
 			 <0x0005b000 0x0005b000 0x001000>,	/* ap 59 */
 			 <0x0005c000 0x0005c000 0x001000>,	/* ap 60 */
 			 <0x0005d000 0x0005d000 0x001000>,	/* ap 61 */
-			 <0x0005e000 0x0005e000 0x001000>;	/* ap 62 */
+			 <0x0005e000 0x0005e000 0x001000>,	/* ap 62 */
+			 <0x45800000 0x45800000 0x400000>,	/* L3 data port */
+			 <0x45c00000 0x45c00000 0x400000>,	/* L3 data port */
+			 <0x46000000 0x46000000 0x400000>,	/* L3 data port */
+			 <0x48436000 0x48436000 0x400000>,	/* L3 data port */
+			 <0x4843a000 0x4843a000 0x400000>,	/* L3 data port */
+			 <0x4844c000 0x4844c000 0x400000>,	/* L3 data port */
+			 <0x48450000 0x48450000 0x400000>,	/* L3 data port */
+			 <0x48454000 0x48454000 0x400000>;	/* L3 data port */
 
 		target-module@20000 {			/* 0x48420000, ap 47 02.0 */
 			compatible = "ti,sysc-omap2", "ti,sysc";
@@ -2727,11 +2743,14 @@
 					<SYSC_IDLE_NO>,
 					<SYSC_IDLE_SMART>;
 			/* Domains (P, C): ipu_pwrdm, ipu_clkdm */
-			clocks = <&ipu_clkctrl DRA7_IPU_MCASP1_CLKCTRL 0>;
-			clock-names = "fck";
+			clocks = <&ipu_clkctrl DRA7_IPU_MCASP1_CLKCTRL 0>,
+				 <&ipu_clkctrl DRA7_IPU_MCASP1_CLKCTRL 24>,
+				 <&ipu_clkctrl DRA7_IPU_MCASP1_CLKCTRL 28>;
+			clock-names = "fck", "ahclkx", "ahclkr";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0x60000 0x2000>;
+			ranges = <0x0 0x60000 0x2000>,
+				 <0x45800000 0x45800000 0x400000>;
 
 			mcasp1: mcasp@0 {
 				compatible = "ti,dra7-mcasp-audio";
@@ -2761,11 +2780,14 @@
 					<SYSC_IDLE_NO>,
 					<SYSC_IDLE_SMART>;
 			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
-			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP2_CLKCTRL 0>;
-			clock-names = "fck";
+			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP2_CLKCTRL 0>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP2_CLKCTRL 24>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP2_CLKCTRL 28>;
+			clock-names = "fck", "ahclkx", "ahclkr";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0x64000 0x2000>;
+			ranges = <0x0 0x64000 0x2000>,
+				 <0x45c00000 0x45c00000 0x400000>;
 
 			mcasp2: mcasp@0 {
 				compatible = "ti,dra7-mcasp-audio";
@@ -2795,11 +2817,14 @@
 					<SYSC_IDLE_NO>,
 					<SYSC_IDLE_SMART>;
 			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
-			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP3_CLKCTRL 0>;
-			clock-names = "fck";
+			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP3_CLKCTRL 0>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP3_CLKCTRL 24>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP3_CLKCTRL 28>;
+			clock-names = "fck", "ahclkx", "ahclkr";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0x68000 0x2000>;
+			ranges = <0x0 0x68000 0x2000>,
+				 <0x46000000 0x46000000 0x400000>;
 
 			mcasp3: mcasp@0 {
 				compatible = "ti,dra7-mcasp-audio";
@@ -2828,11 +2853,14 @@
 					<SYSC_IDLE_NO>,
 					<SYSC_IDLE_SMART>;
 			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
-			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP4_CLKCTRL 0>;
-			clock-names = "fck";
+			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP4_CLKCTRL 0>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP4_CLKCTRL 24>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP4_CLKCTRL 28>;
+			clock-names = "fck", "ahclkx", "ahclkr";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0x6c000 0x2000>;
+			ranges = <0x0 0x6c000 0x2000>,
+				 <0x48436000 0x48436000 0x400000>;
 
 			mcasp4: mcasp@0 {
 				compatible = "ti,dra7-mcasp-audio";
@@ -2861,11 +2889,14 @@
 					<SYSC_IDLE_NO>,
 					<SYSC_IDLE_SMART>;
 			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
-			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP5_CLKCTRL 0>;
-			clock-names = "fck";
+			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP5_CLKCTRL 0>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP5_CLKCTRL 24>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP5_CLKCTRL 28>;
+			clock-names = "fck", "ahclkx", "ahclkr";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0x70000 0x2000>;
+			ranges = <0x0 0x70000 0x2000>,
+				 <0x4843a000 0x4843a000 0x400000>;
 
 			mcasp5: mcasp@0 {
 				compatible = "ti,dra7-mcasp-audio";
@@ -2894,11 +2925,14 @@
 					<SYSC_IDLE_NO>,
 					<SYSC_IDLE_SMART>;
 			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
-			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP6_CLKCTRL 0>;
-			clock-names = "fck";
+			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP6_CLKCTRL 0>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP6_CLKCTRL 24>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP6_CLKCTRL 28>;
+			clock-names = "fck", "ahclkx", "ahclkr";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0x74000 0x2000>;
+			ranges = <0x0 0x74000 0x2000>,
+				 <0x4844c000 0x4844c000 0x400000>;
 
 			mcasp6: mcasp@0 {
 				compatible = "ti,dra7-mcasp-audio";
@@ -2927,11 +2961,14 @@
 					<SYSC_IDLE_NO>,
 					<SYSC_IDLE_SMART>;
 			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
-			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP7_CLKCTRL 0>;
-			clock-names = "fck";
+			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP7_CLKCTRL 0>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP7_CLKCTRL 24>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP7_CLKCTRL 28>;
+			clock-names = "fck", "ahclkx", "ahclkr";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0x78000 0x2000>;
+			ranges = <0x0 0x78000 0x2000>,
+				 <0x48450000 0x48450000 0x400000>;
 
 			mcasp7: mcasp@0 {
 				compatible = "ti,dra7-mcasp-audio";
@@ -2960,11 +2997,14 @@
 					<SYSC_IDLE_NO>,
 					<SYSC_IDLE_SMART>;
 			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
-			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP8_CLKCTRL 0>;
-			clock-names = "fck";
+			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP8_CLKCTRL 0>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP8_CLKCTRL 24>,
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP8_CLKCTRL 28>;
+			clock-names = "fck", "ahclkx", "ahclkr";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0x7c000 0x2000>;
+			ranges = <0x0 0x7c000 0x2000>,
+				 <0x48454000 0x48454000 0x400000>;
 
 			mcasp8: mcasp@0 {
 				compatible = "ti,dra7-mcasp-audio";
-- 
2.19.2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
