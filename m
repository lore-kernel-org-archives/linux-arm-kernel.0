From: carlo@caione.org (Carlo Caione)
Date: Sun,  4 May 2014 16:02:39 +0200
Subject: [PATCH 1/2] ARM: sunxi: dts: Enable syscon in DTSI
In-Reply-To: <1399212160-26934-1-git-send-email-carlo@caione.org>
References: <1399212160-26934-1-git-send-email-carlo@caione.org>
Message-ID: <1399212160-26934-2-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the proper nodes in the DTSI files for Allwinner
A20 and A31.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 5 +++++
 arch/arm/boot/dts/sun7i-a20.dtsi | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index bc46814..775e64a 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -237,6 +237,11 @@
 		#size-cells = <1>;
 		ranges;
 
+		syscon: syscon at 01c00000 {
+			compatible = "syscon";
+			reg = <0x01c00000 0x27>;
+		};
+
 		nmi_intc: interrupt-controller at 01f00c0c {
 			compatible = "allwinner,sun6i-a31-sc-nmi";
 			interrupt-controller;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 88171f4..14f8933 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -401,6 +401,11 @@
 		#size-cells = <1>;
 		ranges;
 
+		syscon: syscon at 01c00000 {
+			compatible = "syscon";
+			reg = <0x01c00000 0x27>;
+		};
+
 		nmi_intc: interrupt-controller at 01c00030 {
 			compatible = "allwinner,sun7i-a20-sc-nmi";
 			interrupt-controller;
-- 
1.8.3.2
