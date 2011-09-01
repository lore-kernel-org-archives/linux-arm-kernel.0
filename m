From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 1 Sep 2011 19:25:08 +0200
Subject: [PATCH 3/7] arm/dts: OMAP3: Add i2c controllers nodes
In-Reply-To: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
Message-ID: <1314897912-18178-4-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add i2c controllers nodes into the main ocp bus.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 5a95a69..aab2129 100644
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
 	/*
 	 * XXX: The cpus node is mandatory, but since the CPUs are as well part
 	 * of the mpu subsystem below, it is not clear where the information
@@ -64,5 +70,26 @@
 			interrupt-controller;
 			#interrupt-cells = <1>;
 		};
+
+		i2c1: i2c at 1 {
+			compatible = "ti,omap3-i2c", "ti,omap-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			hwmods = "i2c1";
+		};
+
+		i2c2: i2c at 2 {
+			compatible = "ti,omap3-i2c", "ti,omap-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			hwmods = "i2c2";
+		};
+
+		i2c3: i2c at 3 {
+			compatible = "ti,omap3-i2c", "ti,omap-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			hwmods = "i2c3";
+		};
 	};
 };
-- 
1.7.0.4
