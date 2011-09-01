From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 1 Sep 2011 19:21:22 +0200
Subject: [PATCH 06/13] arm/dts: OMAP4: Add i2c controller nodes
In-Reply-To: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
References: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Message-ID: <1314897689-17791-7-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add i2c controllers nodes into the main ocp bus.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index b5c798c..fb81a4d 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -21,6 +21,10 @@
 	interrupt-parent = <&gic>;
 
 	aliases {
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
 	};
 
 	/*
@@ -178,5 +182,33 @@
 			#gpio-cells = <2>;
 			gpio-controller;
 		};
+
+		i2c1: i2c at 1 {
+			compatible = "ti,omap4-i2c", "ti,omap-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			hwmods = "i2c1";
+		};
+
+		i2c2: i2c at 2 {
+			compatible = "ti,omap4-i2c", "ti,omap-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			hwmods = "i2c2";
+		};
+
+		i2c3: i2c at 3 {
+			compatible = "ti,omap4-i2c", "ti,omap-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			hwmods = "i2c3";
+		};
+
+		i2c4: i2c at 4 {
+			compatible = "ti,omap4-i2c", "ti,omap-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			hwmods = "i2c4";
+		};
 	};
 };
-- 
1.7.0.4
