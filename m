From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Sat, 08 Jul 2017 20:16:55 +0100
Subject: [PATCH CFT 6/6] arm64: dts: marvell: mcbin: add support for PCIe
In-Reply-To: <20170708191317.GM4902@n2100.armlinux.org.uk>
References: <20170708191317.GM4902@n2100.armlinux.org.uk>
Message-ID: <E1dTvDr-0007FB-7Z@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for PCIe with the the PCIe reset signal wired up to the
appropriate GPIO pin.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index 1372558d037b..53346ccad6cf 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -161,6 +161,15 @@
 	};
 };
 
+&cpm_pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cpm_pcie_pins>;
+	num-lanes = <4>;
+	num-viewport = <8>;
+	reset-gpio = <&cpm_gpio1 20 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
 &cpm_pinctrl {
 	cpm_ge_mdio_pins: ge-mdio-pins {
 		marvell,pins = "mpp32", "mpp34";
@@ -178,6 +187,10 @@
 		marvell,pins = "mpp47";
 		marvell,function = "gpio";
 	};
+	cpm_pcie_pins: pcie-pins {
+		marvell,pins = "mpp52";
+		marvell,function = "gpio";
+	};
 	cpm_sdhci_pins: sdhci-pins {
 		marvell,pins = "mpp55", "mpp56", "mpp57", "mpp58", "mpp59",
 			       "mpp60", "mpp61";
-- 
2.7.4
