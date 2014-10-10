From: kever.yang@rock-chips.com (Kever Yang)
Date: Fri, 10 Oct 2014 14:26:10 -0700
Subject: [PATCH v3 6/6] ARM: dts: rockchip: add intmem node for rk3288 smp
 support
In-Reply-To: <1412976370-14468-1-git-send-email-kever.yang@rock-chips.com>
References: <1412976370-14468-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <1412976370-14468-7-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add intmem node des which is needed by platsmp.c

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v3:
- remove 'enable-method' from this patch
- add compitable name "rockchip,rk3288-pmu-sram" for pmu-intmem

Changes in v2:
- adjust the alignment

 arch/arm/boot/dts/rk3288.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 44108fe..5e9c56d 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -441,6 +441,23 @@
 		status = "disabled";
 	};
 
+	bus_intmem at ff700000 {
+		compatible = "mmio-sram";
+		reg = <0xff700000 0x18000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xff700000 0x18000>;
+		smp-sram at 0 {
+			compatible = "rockchip,rk3066-smp-sram";
+			reg = <0x00 0x10>;
+		};
+	};
+
+	pmu_intmem at ff720000 {
+		compatible = "mmio-sram", "rockchip,rk3288-pmu-sram";
+		reg = <0xff720000 0x4000>;
+	};
+
 	pmu: power-management at ff730000 {
 		compatible = "rockchip,rk3066-pmu", "syscon";
 		reg = <0xff730000 0x100>;
-- 
1.9.1
