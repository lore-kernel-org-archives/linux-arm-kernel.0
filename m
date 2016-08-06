From: mirza.krak@gmail.com (Mirza Krak)
Date: Sat,  6 Aug 2016 21:40:51 +0200
Subject: [PATCH 5/6] ARM: tegra: Add Tegra20 GMI support
In-Reply-To: <1470512452-8322-1-git-send-email-mirza.krak@gmail.com>
References: <1470512452-8322-1-git-send-email-mirza.krak@gmail.com>
Message-ID: <1470512452-8322-6-git-send-email-mirza.krak@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mirza Krak <mirza.krak@gmail.com>

Add a device node for the GMI controller found on Tegra20.

Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 2207c08..9b97863 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -376,6 +376,17 @@
 		status = "disabled";
 	};
 
+
+	gmi at 70009000 {
+		compatible = "nvidia,tegra20-gmi";
+		reg = <70009000 0x1000>;
+		clocks = <&tegra_car TEGRA20_CLK_NOR>;
+		clock-names = "gmi";
+		resets = < &tegra_car 42>;
+		reset-names = "gmi";
+		status = "disabled";
+	};
+
 	pwm: pwm at 7000a000 {
 		compatible = "nvidia,tegra20-pwm";
 		reg = <0x7000a000 0x100>;
-- 
2.1.4
