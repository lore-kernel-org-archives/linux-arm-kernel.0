From: mirza.krak@gmail.com (Mirza Krak)
Date: Thu, 27 Oct 2016 16:01:10 +0200
Subject: [PATCH V3 4/6] ARM: tegra: Add Tegra30 GMI support
In-Reply-To: <1477576872-2665-1-git-send-email-mirza.krak@gmail.com>
References: <1477576872-2665-1-git-send-email-mirza.krak@gmail.com>
Message-ID: <1477576872-2665-5-git-send-email-mirza.krak@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mirza Krak <mirza.krak@gmail.com>

Add a device node for the GMI controller found on Tegra30.

Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Tested-on: Colibri T20/T30 on EvalBoard V3.x and GMI-Memory Board
---

Changes in v2:
- added address-cells, size-cells and ranges properties

Changes in v3:
- no changes

 arch/arm/boot/dts/tegra30.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 5030065..bbb1c00 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -439,6 +439,19 @@
 		status = "disabled";
 	};

+	gmi at 70009000 {
+		compatible = "nvidia,tegra30-gmi";
+		reg = <0x70009000 0x1000>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <0 0 0x48000000 0x7ffffff>;
+		clocks = <&tegra_car TEGRA30_CLK_NOR>;
+		clock-names = "gmi";
+		resets = <&tegra_car 42>;
+		reset-names = "gmi";
+		status = "disabled";
+	};
+
 	pwm: pwm at 7000a000 {
 		compatible = "nvidia,tegra30-pwm", "nvidia,tegra20-pwm";
 		reg = <0x7000a000 0x100>;
--
2.1.4
