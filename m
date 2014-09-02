From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue,  2 Sep 2014 09:57:09 -0600
Subject: [PATCH 1/2] ARM: tegra: add touchpad to Venice2 DT
Message-ID: <1409673430-7039-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Venice2 contains an Atmel MXT touchpad. Add an I2C node for it to DT.
The Linux driver doesn't quite work on this platform yet, but adding
the DT node causes no issues, and will allow the device to work once
the driver is fixed.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra124-venice2.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 70ad91d1a20b..dcbe5858faf1 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -606,6 +606,14 @@
 	i2c at 0,7000c400 {
 		status = "okay";
 		clock-frequency = <100000>;
+
+		trackpad at 4b {
+			compatible = "atmel,maxtouch";
+			reg = <0x4b>;
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(W, 3) IRQ_TYPE_LEVEL_LOW>;
+			linux,gpio-keymap = <0 0 0 BTN_LEFT>;
+		};
 	};
 
 	i2c at 0,7000c500 {
-- 
1.9.1
