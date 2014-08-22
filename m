From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 22 Aug 2014 15:18:28 -0600
Subject: [PATCH] ARM: tegra: add PCIe-related pins to the Jetson TK1 pinmux
 tables
Message-ID: <1408742308-18004-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This pinmux tables currently omit any configuration for PCIe clk_req,
wake, and rst pins, which in turn causes intermittent failures in
U-Boot's PCIe support. Import an updated version of the pinmux tables
which rectifies this.

(While I'm still hoping to remove the pinmux tables from DTs for
Tegra124+ devices, while they're still here, they may as well be
complete and correct).

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index 6c0253198e09..cdefaaa15ac6 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1251,6 +1251,41 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
+			pex_l0_rst_n_pdd1 {
+				nvidia,pins = "pex_l0_rst_n_pdd1";
+				nvidia,function = "pe0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pex_l0_clkreq_n_pdd2 {
+				nvidia,pins = "pex_l0_clkreq_n_pdd2";
+				nvidia,function = "pe0";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pex_wake_n_pdd3 {
+				nvidia,pins = "pex_wake_n_pdd3";
+				nvidia,function = "pe";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pex_l1_rst_n_pdd5 {
+				nvidia,pins = "pex_l1_rst_n_pdd5";
+				nvidia,function = "pe1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pex_l1_clkreq_n_pdd6 {
+				nvidia,pins = "pex_l1_clkreq_n_pdd6";
+				nvidia,function = "pe1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
 			clk3_out_pee0 {
 				nvidia,pins = "clk3_out_pee0";
 				nvidia,function = "extperiph3";
-- 
1.9.1
