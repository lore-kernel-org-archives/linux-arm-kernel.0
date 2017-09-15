From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 15 Sep 2017 11:18:08 +0200
Subject: [PATCH v2 4/8] ARM: dts: rockchip: add rk3036 gpu node
In-Reply-To: <20170915091812.13368-1-heiko@sntech.de>
References: <20170915091812.13368-1-heiko@sntech.de>
Message-ID: <20170915091812.13368-5-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3036 uses a Mali400 GPU with one pixel processor.
This adds the core node for it, which can be enabled
in board devicetrees.

Rockchip Mali GPUs use only one clock line for both bus and core.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3036.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 4916c65e0ace..5b084c0143ce 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -152,6 +152,25 @@
 		};
 	};
 
+	gpu: gpu at 10090000 {
+		compatible = "rockchip,rk3036-mali", "arm,mali-400";
+		reg = <0x10090000 0x10000>;
+		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "gp",
+				  "gpmmu",
+				  "pp0",
+				  "pp0mmu";
+		assigned-clocks = <&cru SCLK_GPU>;
+		assigned-clock-rates = <100000000>;
+		clocks = <&cru SCLK_GPU>, <&cru SCLK_GPU>;
+		clock-names = "core", "bus";
+		resets = <&cru SRST_GPU>;
+		status = "disabled";
+	};
+
 	vop: vop at 10118000 {
 		compatible = "rockchip,rk3036-vop";
 		reg = <0x10118000 0x19c>;
-- 
2.14.1
