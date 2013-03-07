From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu,  7 Mar 2013 09:54:22 -0300
Subject: [PATCH 2/5] ARM: mvebu: Add Device Bus support for Armada 370/XP SoC
In-Reply-To: <1362660865-2755-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1362660865-2755-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1362660865-2755-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armada 370 and Armada XP SoC have a Device Bus controller to
handle NOR, NAND, SRAM and FPGA devices.
This patch adds the device tree node to enable the controller.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi |    7 +++++++
 arch/arm/boot/dts/armada-xp.dtsi  |    7 +++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 1bc1d4d..9360cd4 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -156,5 +156,12 @@
 			clocks = <&coreclk 0>;
 		};
 
+		device-bus at d0010400 {
+			compatible = "marvell,armada370-devbus";
+			reg = <0xd0010400 0xe0>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 0a2f066..195a7eb 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -154,5 +154,12 @@
 			status = "disabled";
 		};
 
+		device-bus at d0010400 {
+			compatible = "marvell,armadaxp-devbus";
+			reg = <0xd0010400 0xe0>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.8.6
