From: kever.yang@rock-chips.com (Kever Yang)
Date: Wed, 10 Sep 2014 18:05:54 +0800
Subject: [PATCH 2/2] ARM: dts: add intmem node for rk3288 smp support
In-Reply-To: <1410343554-8383-1-git-send-email-kever.yang@rock-chips.com>
References: <1410343554-8383-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <1410343554-8383-3-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add intmem node des which is needed by platsmp.c
and enable the smp.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 arch/arm/boot/dts/rk3288.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index dca586e..562ec5f 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -40,6 +40,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		enable-method = "rockchip,rk3288-smp";
 		cpu at 500 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a12";
@@ -353,6 +354,23 @@
 		status = "disabled";
 	};
 
+	bus_intmem at ff700000 {
+		compatible = "mmio-sram";
+		reg = <0xff700000 0x18000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xff700000 0x18000>;
+			smp-sram at 0 {
+			compatible = "rockchip,rk3066-smp-sram";
+			reg = <0x00 0x10>;
+		};
+	};
+
+	pmu_intmem at ff720000 {
+		compatible = "mmio-sram";
+		reg = <0xff720000 0x4000>;
+	};
+
 	pmu: power-management at ff730000 {
 		compatible = "rockchip,rk3288-pmu", "syscon";
 		reg = <0xff730000 0x100>;
-- 
1.9.1
