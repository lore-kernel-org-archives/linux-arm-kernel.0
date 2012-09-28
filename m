From: mporter@ti.com (Matt Porter)
Date: Fri, 28 Sep 2012 15:37:52 -0400
Subject: [PATCH v2 7/7] ARM: dts: AM33xx PRUSS support
In-Reply-To: <1348861072-14507-1-git-send-email-mporter@ti.com>
References: <1348861072-14507-1-git-send-email-mporter@ti.com>
Message-ID: <1348861072-14507-8-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds a pruss node and an example of use on Beaglebone.

Signed-off-by: Matt Porter <mporter@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts |    4 ++++
 arch/arm/boot/dts/am33xx.dtsi     |   11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index c634f87..9e070c2 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -78,3 +78,7 @@
 		};
 	};
 };
+
+&pruss {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index bb31bff..399feb3 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -210,5 +210,16 @@
 			interrupt-parent = <&intc>;
 			interrupts = <91>;
 		};
+
+		pruss: pruss at 4a300000 {
+			compatible = "ti,pruss-v2";
+			ti,hwmods = "pruss";
+			ti,deassert-hard-reset = "pruss", "pruss";
+			reg = <0x4a300000 0x080000>;
+			ti,pintc-offset = <0x20000>;
+			interrupt-parent = <&intc>;
+			interrupts = <20 21 22 23 24 25 26 27>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.9.5
