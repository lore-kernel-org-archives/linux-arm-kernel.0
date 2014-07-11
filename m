From: s-anna@ti.com (Suman Anna)
Date: Fri, 11 Jul 2014 17:04:10 -0500
Subject: [PATCHv2 3/5] ARM: dts: OMAP2+: Add sub mailboxes device node
 information
In-Reply-To: <1405116252-53612-1-git-send-email-s-anna@ti.com>
References: <1405116252-53612-1-git-send-email-s-anna@ti.com>
Message-ID: <1405116252-53612-4-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sub-mailbox devices are added to the Mailbox DT nodes on
OMAP2420, OMAP2430, OMAP3, AM33xx, AM43xx, OMAP4 and OMAP5
family of SoCs. This data represents the same mailboxes that
used to be represented in hwmod attribute data previously.
The node name is chosen based on the .name field of
omap_mbox_dev_info structure used in the hwmod data.

Cc: "Beno?t Cousson" <bcousson@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi   | 4 ++++
 arch/arm/boot/dts/am4372.dtsi   | 4 ++++
 arch/arm/boot/dts/omap2420.dtsi | 8 ++++++++
 arch/arm/boot/dts/omap2430.dtsi | 4 ++++
 arch/arm/boot/dts/omap3.dtsi    | 4 ++++
 arch/arm/boot/dts/omap4.dtsi    | 8 ++++++++
 arch/arm/boot/dts/omap5.dtsi    | 8 ++++++++
 7 files changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 3a0a161..e4f165a 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -354,6 +354,10 @@
 			ti,hwmods = "mailbox";
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <8>;
+			mbox_wkupm3: wkup_m3 {
+				ti,mbox-tx = <0 0 0>;
+				ti,mbox-rx = <0 0 3>;
+			};
 		};
 
 		timer1: timer at 44e31000 {
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index c9aee0e..3be2a87 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -168,6 +168,10 @@
 			ti,hwmods = "mailbox";
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <8>;
+			mbox_wkupm3: wkup_m3 {
+				ti,mbox-tx = <0 0 0>;
+				ti,mbox-rx = <0 0 3>;
+			};
 		};
 
 		timer1: timer at 44e31000 {
diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
index 6d21994..d14f16c 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -159,6 +159,14 @@
 			ti,hwmods = "mailbox";
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <6>;
+			mbox_dsp: dsp {
+				ti,mbox-tx = <0 0 0>;
+				ti,mbox-rx = <1 0 0>;
+			};
+			mbox_iva: iva {
+				ti,mbox-tx = <2 1 3>;
+				ti,mbox-rx = <3 1 3>;
+			};
 		};
 
 		timer1: timer at 48028000 {
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index aa6a354..db02be2 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -249,6 +249,10 @@
 			ti,hwmods = "mailbox";
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <6>;
+			mbox_dsp: dsp {
+				ti,mbox-tx = <0 0 0>;
+				ti,mbox-rx = <1 0 0>;
+			};
 		};
 
 		timer1: timer at 49018000 {
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 575a49b..b2ae8b8 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -334,6 +334,10 @@
 			interrupts = <26>;
 			ti,mbox-num-users = <2>;
 			ti,mbox-num-fifos = <2>;
+			mbox_dsp: dsp {
+				ti,mbox-tx = <0 0 0>;
+				ti,mbox-rx = <1 0 0>;
+			};
 		};
 
 		mcspi1: spi at 48098000 {
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 69408b5..bc54d66 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -656,6 +656,14 @@
 			ti,hwmods = "mailbox";
 			ti,mbox-num-users = <3>;
 			ti,mbox-num-fifos = <8>;
+			mbox_ipu: mbox_ipu {
+				ti,mbox-tx = <0 0 0>;
+				ti,mbox-rx = <1 0 0>;
+			};
+			mbox_dsp: mbox_dsp {
+				ti,mbox-tx = <3 0 0>;
+				ti,mbox-rx = <2 0 0>;
+			};
 		};
 
 		timer1: timer at 4a318000 {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 0e8336e..f7ec4cd 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -643,6 +643,14 @@
 			ti,hwmods = "mailbox";
 			ti,mbox-num-users = <3>;
 			ti,mbox-num-fifos = <8>;
+			mbox_ipu: mbox_ipu {
+				ti,mbox-tx = <0 0 0>;
+				ti,mbox-rx = <1 0 0>;
+			};
+			mbox_dsp: mbox_dsp {
+				ti,mbox-tx = <3 0 0>;
+				ti,mbox-rx = <2 0 0>;
+			};
 		};
 
 		timer1: timer at 4ae18000 {
-- 
2.0.0
