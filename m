From: zyw@rock-chips.com (zyw at rock-chips.com)
Date: Wed, 15 Oct 2014 13:49:04 -0700
Subject: [PATCH 3/4] ARM: dts: add RK3288 suspend support
In-Reply-To: <1413405987-16196-1-git-send-email-zyw@rock-chips.com>
References: <1413405987-16196-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1413406144-16329-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Zhong <zyw@rock-chips.com>

add pmu_intmem subnode for suspend, add suspend pinctrl

Signed-off-by: Tony Xie <xxx@rock-chips.com>
Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 arch/arm/boot/dts/rk3288.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 5950b0a..081af7a 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -241,6 +241,11 @@
 		status = "disabled";
 	};
 
+	pmu_intmem at ff720000 {
+		compatible = "mmio-sram", "rockchip,rk3288-pmu-sram";
+		reg = <0xff720000 0x4000>;
+	};
+
 	pmu: power-management at ff730000 {
 		compatible = "rockchip,rk3288-pmu", "syscon";
 		reg = <0xff730000 0x100>;
@@ -421,6 +426,12 @@
 			bias-disable;
 		};
 
+		sleep {
+			global_pwroff: global-pwroff {
+				rockchip,pins = <0 0 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
 		i2c0 {
 			i2c0_xfer: i2c0-xfer {
 				rockchip,pins = <0 15 RK_FUNC_1 &pcfg_pull_none>,
-- 
1.7.9.5
