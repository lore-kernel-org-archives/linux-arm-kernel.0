From: mw@semihalf.com (Marcin Wojtas)
Date: Tue, 16 May 2017 01:28:32 +0200
Subject: [PATCH 1/2] arm64: marvell: dts: fill MachiatoBin board description
In-Reply-To: <1494890913-8360-1-git-send-email-mw@semihalf.com>
References: <1494890913-8360-1-git-send-email-mw@semihalf.com>
Message-ID: <1494890913-8360-2-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds following improvements to Armada 8040
MachiatoBin:
 * Add 'chosen' node with stdout-path assignment
 * Enable 1G sgmii port
 * Enable SDHCI controllers on AP and CP HW blocks

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 34 +++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index f7bb0cc..19d395b 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -51,6 +51,10 @@
 	compatible = "marvell,armada8040-mcbin", "marvell,armada8040",
 			"marvell,armada-ap806-quad", "marvell,armada-ap806";
 
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
 	memory at 00000000 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
@@ -136,3 +140,33 @@
 	usb-phy = <&usb3h0_phy>;
 	status = "okay";
 };
+
+&cpm_mdio {
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
+};
+
+&cps_ethernet {
+	status = "okay";
+};
+
+&cps_eth1 {
+	status = "okay";
+	phy = <&phy0>;
+	phy-mode = "sgmii";
+};
+
+&ap_sdhci0 {
+	status = "okay";
+	bus-width = <8>;
+	no-1-8-v;
+	non-removable;
+};
+
+&cpm_sdhci0 {
+	status = "okay";
+	bus-width = <4>;
+	no-1-8-v;
+	non-removable;
+};
-- 
1.8.3.1
