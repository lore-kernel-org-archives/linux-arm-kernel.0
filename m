From: finley.xiao@rock-chips.com (Finlye Xiao)
Date: Wed, 10 Aug 2016 14:50:42 +0800
Subject: [PATCH v1 3/4] arm64: dts: rockchip: add efuse0 device node for rk3399
In-Reply-To: <1470811843-42668-1-git-send-email-finley.xiao@rock-chips.com>
References: <1470811843-42668-1-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <1470811843-42668-4-git-send-email-finley.xiao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Finley Xiao <finley.xiao@rock-chips.com>

Add a efuse0 node in the device tree for the ARM64 rk3399 SoC.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 4c84229..7f764ca 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -899,6 +899,35 @@
 		status = "disabled";
 	};
 
+	efuse0: efuse0 at ff690000 {
+		compatible = "rockchip,rk3399-efuse";
+		reg = <0x0 0xff690000 0x0 0x80>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		clocks = <&cru PCLK_EFUSE1024NS>;
+		clock-names = "pclk_efuse";
+
+		/* Data cells */
+		cpul_leakage: cpul-leakage {
+			reg = <0x1a 0x1>;
+		};
+		cpub_leakage: cpub-leakage {
+			reg = <0x17 0x1>;
+		};
+		gpu_leakage: gpu-leakage {
+			reg = <0x18 0x1>;
+		};
+		center_leakage: center-leakage {
+			reg = <0x19 0x1>;
+		};
+		logic_leakage: logic-leakage {
+			reg = <0x1b 0x1>;
+		};
+		wafer_info: wafer-info {
+			reg = <0x1c 0x1>;
+		};
+	};
+
 	pmucru: pmu-clock-controller at ff750000 {
 		compatible = "rockchip,rk3399-pmucru";
 		reg = <0x0 0xff750000 0x0 0x1000>;
-- 
1.9.1
