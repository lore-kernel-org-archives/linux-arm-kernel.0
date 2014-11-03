From: s-anna@ti.com (Suman Anna)
Date: Mon, 3 Nov 2014 17:07:35 -0600
Subject: [PATCH 2/2] ARM: dts: OMAP2+: Add #mbox-cells property to all mailbox
 nodes
In-Reply-To: <1415056055-64201-1-git-send-email-s-anna@ti.com>
References: <1415056055-64201-1-git-send-email-s-anna@ti.com>
Message-ID: <1415056055-64201-3-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The '#mbox-cells' property is added to all the OMAP mailbox
nodes. This property is mandatory with the new mailbox framework.

Cc: "Beno?t Cousson" <bcousson@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi   |  1 +
 arch/arm/boot/dts/am4372.dtsi   |  1 +
 arch/arm/boot/dts/dra7.dtsi     | 13 +++++++++++++
 arch/arm/boot/dts/omap2420.dtsi |  1 +
 arch/arm/boot/dts/omap2430.dtsi |  1 +
 arch/arm/boot/dts/omap3.dtsi    |  1 +
 arch/arm/boot/dts/omap4.dtsi    |  1 +
 arch/arm/boot/dts/omap5.dtsi    |  1 +
 8 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 8318105..41659df 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -356,6 +356,7 @@
 			reg = <0x480C8000 0x200>;
 			interrupts = <77>;
 			ti,hwmods = "mailbox";
+			#mbox-cells = <1>;
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <8>;
 			mbox_wkupm3: wkup_m3 {
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 46660ff..4367f75 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -168,6 +168,7 @@
 			reg = <0x480C8000 0x200>;
 			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox";
+			#mbox-cells = <1>;
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <8>;
 			mbox_wkupm3: wkup_m3 {
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index b8c9c67..2af7867 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -425,6 +425,7 @@
 				     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox1";
+			#mbox-cells = <1>;
 			ti,mbox-num-users = <3>;
 			ti,mbox-num-fifos = <8>;
 			status = "disabled";
@@ -438,6 +439,7 @@
 				     <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox2";
+			#mbox-cells = <1>;
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
 			status = "disabled";
@@ -451,6 +453,7 @@
 				     <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox3";
+			#mbox-cells = <1>;
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
 			status = "disabled";
@@ -464,6 +467,7 @@
 				     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox4";
+			#mbox-cells = <1>;
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
 			status = "disabled";
@@ -477,6 +481,7 @@
 				     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox5";
+			#mbox-cells = <1>;
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
 			status = "disabled";
@@ -490,6 +495,7 @@
 				     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox6";
+			#mbox-cells = <1>;
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
 			status = "disabled";
@@ -503,6 +509,7 @@
 				     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox7";
+			#mbox-cells = <1>;
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
 			status = "disabled";
@@ -516,6 +523,7 @@
 				     <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox8";
+			#mbox-cells = <1>;
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
 			status = "disabled";
@@ -529,6 +537,7 @@
 				     <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox9";
+			#mbox-cells = <1>;
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
 			status = "disabled";
@@ -542,6 +551,7 @@
 				     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox10";
+			#mbox-cells = <1>;
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
 			status = "disabled";
@@ -555,6 +565,7 @@
 				     <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox11";
+			#mbox-cells = <1>;
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
 			status = "disabled";
@@ -568,6 +579,7 @@
 				     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox12";
+			#mbox-cells = <1>;
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
 			status = "disabled";
@@ -581,6 +593,7 @@
 				     <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox13";
+			#mbox-cells = <1>;
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
 			status = "disabled";
diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
index ae89aad..e2b2e93 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -157,6 +157,7 @@
 			interrupts = <26>, <34>;
 			interrupt-names = "dsp", "iva";
 			ti,hwmods = "mailbox";
+			#mbox-cells = <1>;
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <6>;
 			mbox_dsp: dsp {
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index b56d7161..0dc8de2 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -247,6 +247,7 @@
 			reg = <0x48094000 0x200>;
 			interrupts = <26>;
 			ti,hwmods = "mailbox";
+			#mbox-cells = <1>;
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <6>;
 			mbox_dsp: dsp {
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index d0e884d..8db7def 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -332,6 +332,7 @@
 			ti,hwmods = "mailbox";
 			reg = <0x48094000 0x200>;
 			interrupts = <26>;
+			#mbox-cells = <1>;
 			ti,mbox-num-users = <2>;
 			ti,mbox-num-fifos = <2>;
 			mbox_dsp: dsp {
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 878c979..a46eab8 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -661,6 +661,7 @@
 			reg = <0x4a0f4000 0x200>;
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox";
+			#mbox-cells = <1>;
 			ti,mbox-num-users = <3>;
 			ti,mbox-num-fifos = <8>;
 			mbox_ipu: mbox_ipu {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 256b7f6..b321fdf 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -651,6 +651,7 @@
 			reg = <0x4a0f4000 0x200>;
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox";
+			#mbox-cells = <1>;
 			ti,mbox-num-users = <3>;
 			ti,mbox-num-fifos = <8>;
 			mbox_ipu: mbox_ipu {
-- 
2.1.0
