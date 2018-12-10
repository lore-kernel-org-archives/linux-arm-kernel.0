Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC8EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:10:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D149D20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Iyr0ytxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D149D20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xX6ZnIIfD58Bx+r3dnxe/CT/C0KMDc4GHLqQCPFOdtk=; b=Iyr0ytxQ+sCfd3
	3JBoGourAupXmhcW8bPPavI6ZkhQpPvjqdshIKpfV1jSn1Y0lG82dQUKQvyYB7DsXUEJvB94KFC4z
	rsTZ9xiZgxRfR31hvhnlrf8Q1XyJBH9lQd28bvYaFGQhkodFERUKrj02sHxxS/dEgF0JJoAxwbCEC
	vFxZKIpt0s6gKre2IpkM342u/kqhd7AxuMN/4GKDAGm/zRwccjcYR8sSPBFzx6MVRP0W92bqxJFx3
	4feJxI7jJldsKJlAeXF8M9jPlq1krtcHZCBqypfPo8mMWf75PgqKMoQ+dOe93bujbB6+DNTNMN3EX
	vcFrkxxSThA9a+vKNfrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWTkw-0004mk-8b; Mon, 10 Dec 2018 22:10:26 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWTkt-0004J8-1O
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 22:10:24 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 9554A80F0;
 Mon, 10 Dec 2018 22:10:15 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Subject: [PATCH] ARM: dts: Fix ranges for am335x epwmss
Date: Mon, 10 Dec 2018 14:10:05 -0800
Message-Id: <20181210221005.24386-1-tony@atomide.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_141023_119830_A6D0FF87 
X-CRM114-Status: GOOD (  10.88  )
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

Looks like I missed the ranges for am335x epwmss. Let's set it up the
same way as for am437x and dra7.

Fixes: 87fc89ced3a7 ("ARM: dts: am335x: Move l4 child devices to probe
them with ti-sysc")
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am335x-cm-t335.dts |  2 +-
 arch/arm/boot/dts/am335x-evm.dts     |  2 +-
 arch/arm/boot/dts/am335x-evmsk.dts   |  2 +-
 arch/arm/boot/dts/am335x-shc.dts     |  2 +-
 arch/arm/boot/dts/am33xx-l4.dtsi     | 36 ++++++++++++----------------
 5 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -393,7 +393,7 @@ status = "okay";
 &epwmss0 {
 	status = "okay";
 
-	ecap0: ecap@48300100 {
+	ecap0: ecap@100 {
 		status = "okay";
 		pinctrl-names = "default";
 		pinctrl-0 = <&ecap0_pins>;
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -519,7 +519,7 @@
 &epwmss0 {
 	status = "okay";
 
-	ecap0: ecap@48300100 {
+	ecap0: ecap@100 {
 		status = "okay";
 		pinctrl-names = "default";
 		pinctrl-0 = <&ecap0_pins>;
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -540,7 +540,7 @@
 &epwmss2 {
 	status = "okay";
 
-	ecap2: ecap@48304100 {
+	ecap2: ecap@100 {
 		status = "okay";
 		pinctrl-names = "default";
 		pinctrl-0 = <&ecap2_pins>;
diff --git a/arch/arm/boot/dts/am335x-shc.dts b/arch/arm/boot/dts/am335x-shc.dts
--- a/arch/arm/boot/dts/am335x-shc.dts
+++ b/arch/arm/boot/dts/am335x-shc.dts
@@ -138,7 +138,7 @@
 &epwmss1 {
 	status = "okay";
 
-	ehrpwm1: pwm@48302200 {
+	ehrpwm1: pwm@200 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&ehrpwm1_pins>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -1899,15 +1899,13 @@
 				#address-cells = <1>;
 				#size-cells = <1>;
 				status = "disabled";
-				ranges = <0x48300100 0x48300100 0x80   /* ECAP */
-					  0x48300180 0x48300180 0x80   /* EQEP */
-					  0x48300200 0x48300200 0x80>; /* EHRPWM */
+				ranges = <0 0 0x1000>;
 
-				ecap0: ecap@48300100 {
+				ecap0: ecap@100 {
 					compatible = "ti,am3352-ecap",
 						     "ti,am33xx-ecap";
 					#pwm-cells = <3>;
-					reg = <0x48300100 0x80>;
+					reg = <0x100 0x80>;
 					clocks = <&l4ls_gclk>;
 					clock-names = "fck";
 					interrupts = <31>;
@@ -1915,11 +1913,11 @@
 					status = "disabled";
 				};
 
-				ehrpwm0: pwm@48300200 {
+				ehrpwm0: pwm@200 {
 					compatible = "ti,am3352-ehrpwm",
 						     "ti,am33xx-ehrpwm";
 					#pwm-cells = <3>;
-					reg = <0x48300200 0x80>;
+					reg = <0x200 0x80>;
 					clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
 					clock-names = "tbclk", "fck";
 					status = "disabled";
@@ -1954,15 +1952,13 @@
 				#address-cells = <1>;
 				#size-cells = <1>;
 				status = "disabled";
-				ranges = <0x48302100 0x48302100 0x80   /* ECAP */
-					  0x48302180 0x48302180 0x80   /* EQEP */
-					  0x48302200 0x48302200 0x80>; /* EHRPWM */
+				ranges = <0 0 0x1000>;
 
-				ecap1: ecap@48302100 {
+				ecap1: ecap@100 {
 					compatible = "ti,am3352-ecap",
 						     "ti,am33xx-ecap";
 					#pwm-cells = <3>;
-					reg = <0x48302100 0x80>;
+					reg = <0x100 0x80>;
 					clocks = <&l4ls_gclk>;
 					clock-names = "fck";
 					interrupts = <47>;
@@ -1970,11 +1966,11 @@
 					status = "disabled";
 				};
 
-				ehrpwm1: pwm@48302200 {
+				ehrpwm1: pwm@200 {
 					compatible = "ti,am3352-ehrpwm",
 						     "ti,am33xx-ehrpwm";
 					#pwm-cells = <3>;
-					reg = <0x48302200 0x80>;
+					reg = <0x200 0x80>;
 					clocks = <&ehrpwm1_tbclk>, <&l4ls_gclk>;
 					clock-names = "tbclk", "fck";
 					status = "disabled";
@@ -2009,15 +2005,13 @@
 				#address-cells = <1>;
 				#size-cells = <1>;
 				status = "disabled";
-				ranges = <0x48304100 0x48304100 0x80   /* ECAP */
-					  0x48304180 0x48304180 0x80   /* EQEP */
-					  0x48304200 0x48304200 0x80>; /* EHRPWM */
+				ranges = <0 0 0x1000>;
 
-				ecap2: ecap@48304100 {
+				ecap2: ecap@100 {
 					compatible = "ti,am3352-ecap",
 						     "ti,am33xx-ecap";
 					#pwm-cells = <3>;
-					reg = <0x48304100 0x80>;
+					reg = <0x100 0x80>;
 					clocks = <&l4ls_gclk>;
 					clock-names = "fck";
 					interrupts = <61>;
@@ -2025,11 +2019,11 @@
 					status = "disabled";
 				};
 
-				ehrpwm2: pwm@48304200 {
+				ehrpwm2: pwm@200 {
 					compatible = "ti,am3352-ehrpwm",
 						     "ti,am33xx-ehrpwm";
 					#pwm-cells = <3>;
-					reg = <0x48304200 0x80>;
+					reg = <0x200 0x80>;
 					clocks = <&ehrpwm2_tbclk>, <&l4ls_gclk>;
 					clock-names = "tbclk", "fck";
 					status = "disabled";
-- 
2.19.2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
