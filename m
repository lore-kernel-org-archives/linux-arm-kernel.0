From: mirza.krak@gmail.com (Mirza Krak)
Date: Tue, 19 Jul 2016 15:36:35 +0200
Subject: [RFC 4/6] ARM: tegra: Add Tegra30 NOR support
In-Reply-To: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
References: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
Message-ID: <1468935397-11926-5-git-send-email-mirza.krak@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mirza Krak <mirza.krak@gmail.com>

Add a device node for the NOR controller found on Tegra30.

Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 5030065..002db10 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -439,6 +439,17 @@
 		status = "disabled";
 	};
 
+	nor at 70009000 {
+		compatible = "nvidia,tegra20-nor", "nvidia,tegra30-nor";
+		reg = <0x70009000 0x1000>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		clocks = <&tegra_car TEGRA30_CLK_NOR>;
+		resets = < &tegra_car 42>;
+		reset-names = "nor";
+		status = "disabled";
+	};
+
 	pwm: pwm at 7000a000 {
 		compatible = "nvidia,tegra30-pwm", "nvidia,tegra20-pwm";
 		reg = <0x7000a000 0x100>;
-- 
2.1.4
