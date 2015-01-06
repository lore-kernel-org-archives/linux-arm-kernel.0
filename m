From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue,  6 Jan 2015 11:37:26 +0100
Subject: [PATCH 1/4] ARM: tegra: rely on bootloader pinmux programming on
 nyan-big
In-Reply-To: <1420540653-14816-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1420540653-14816-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1420540653-14816-2-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following 6dbaff2b, the kernel expects that the bootloader has correctly
programmed the Tegra pinmux.

DTs for the Jetson and the Venice2 had been updated already but this one
was left behind.

Have tested this with the stock vendor firmware (coreboot) and have found no
issues.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm/boot/dts/tegra124-nyan-big.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-nyan-big.dts b/arch/arm/boot/dts/tegra124-nyan-big.dts
index 53181d3..4752572 100644
--- a/arch/arm/boot/dts/tegra124-nyan-big.dts
+++ b/arch/arm/boot/dts/tegra124-nyan-big.dts
@@ -44,10 +44,10 @@
 	};
 
 	pinmux at 0,70000868 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinmux_default>;
+		pinctrl-names = "boot";
+		pinctrl-0 = <&pinmux_boot>;
 
-		pinmux_default: common {
+		pinmux_boot: common {
 			dap_mclk1_pw4 {
 				nvidia,pins = "dap_mclk1_pw4";
 				nvidia,function = "extperiph1";
-- 
1.9.3
