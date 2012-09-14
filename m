From: vbyravarasu@nvidia.com (Venu Byravarasu)
Date: Fri, 14 Sep 2012 14:55:54 +0530
Subject: [PATCH] arm: tegra: dt: Add pinmux entries for Vbus regulator controls
Message-ID: <1347614754-26357-1-git-send-email-vbyravarasu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding pinmux entries for PI4 and PH7 to enable Vbus for USB1
and USB3 controllers on Cardhu A02 board.

Signed-off-by: Venu Byravarasu <vbyravarasu@nvidia.com>
---

 arch/arm/boot/dts/tegra30-cardhu-a02.dts |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-cardhu-a02.dts b/arch/arm/boot/dts/tegra30-cardhu-a02.dts
index dd4222f..b76ad31 100644
--- a/arch/arm/boot/dts/tegra30-cardhu-a02.dts
+++ b/arch/arm/boot/dts/tegra30-cardhu-a02.dts
@@ -8,6 +8,26 @@
 	model = "NVIDIA Tegra30 Cardhu A02 evaluation board";
 	compatible = "nvidia,cardhu-a02", "nvidia,cardhu", "nvidia,tegra30";
 
+	pinmux {
+		gmi_rst_n_pi4 {
+			nvidia,pins = "gmi_rst_n_pi4";
+			nvidia,function = "gmi";
+			nvidia,tristate = <0>;
+			nvidia,enable-input = <1>;
+			nvidia,open-drain = <1>;
+			nvidia,pull = <0>;
+		};
+
+		gmi_ad15_ph7 {
+			nvidia,pins = "gmi_ad15_ph7";
+			nvidia,function = "gmi";
+			nvidia,tristate = <0>;
+			nvidia,enable-input = <1>;
+			nvidia,open-drain = <1>;
+			nvidia,pull = <0>;
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
1.7.1.1
