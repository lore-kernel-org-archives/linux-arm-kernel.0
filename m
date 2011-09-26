From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 26 Sep 2011 18:50:17 +0200
Subject: [PATCH 09/13] arm/dts: OMAP3: Add i2c controller nodes
In-Reply-To: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
References: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
Message-ID: <1317055821-20652-10-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add i2c controllers nodes into the main ocp bus.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index d202bb5..8ff794f 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -13,6 +13,12 @@
 / {
 	compatible = "ti,omap3430", "ti,omap3";
 
+	aliases {
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+	};
+
 	cpus {
 		cpu at 0 {
 			compatible = "arm,cortex-a8";
@@ -59,5 +65,26 @@
 			interrupt-controller;
 			#interrupt-cells = <1>;
 		};
+
+		i2c1: i2c at 1 {
+			compatible = "ti,omap3-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "i2c1";
+		};
+
+		i2c2: i2c at 2 {
+			compatible = "ti,omap3-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "i2c2";
+		};
+
+		i2c3: i2c at 3 {
+			compatible = "ti,omap3-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "i2c3";
+		};
 	};
 };
-- 
1.7.0.4
