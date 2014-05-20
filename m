From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 May 2014 16:43:28 +0200
Subject: [PATCH] ARM: mvebu: fix definitions of PCIe interfaces on Armada 38x
Message-ID: <1400597008-4148-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due a copy/paste error, the 'reg' values for the third PCIe interface
on Armada 380, and the third and fourth PCIe interfaces on Armada 385
are wrong: they are equal to the one of the second PCIe interface.

This patch fixes this by using the appropriate 'reg' values for those
PCIe interfaces.

Without this fix, the third and fourth PCIe interfaces are unusable on
those platforms.

Reported-by: Nadav Haklai <nadavh@marvell.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Fixes: 0d3d96ab0059 ("ARM: mvebu: add Device Tree description of the Armada 380/385 SoCs")
---
This is based on mvebu/dt. It should be pushed to 3.15-rc.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-380.dtsi | 2 +-
 arch/arm/boot/dts/armada-385.dtsi | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/armada-380.dtsi b/arch/arm/boot/dts/armada-380.dtsi
index aa71718..e69bc67 100644
--- a/arch/arm/boot/dts/armada-380.dtsi
+++ b/arch/arm/boot/dts/armada-380.dtsi
@@ -101,7 +101,7 @@
 			pcie at 3,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82000800 0 0x44000 0 0x2000>;
-				reg = <0x1000 0 0 0 0>;
+				reg = <0x1800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
 				#interrupt-cells = <1>;
diff --git a/arch/arm/boot/dts/armada-385.dtsi b/arch/arm/boot/dts/armada-385.dtsi
index 2c7990d..f011009 100644
--- a/arch/arm/boot/dts/armada-385.dtsi
+++ b/arch/arm/boot/dts/armada-385.dtsi
@@ -112,7 +112,7 @@
 			pcie at 3,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82000800 0 0x44000 0 0x2000>;
-				reg = <0x1000 0 0 0 0>;
+				reg = <0x1800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
 				#interrupt-cells = <1>;
@@ -133,7 +133,7 @@
 			pcie at 4,0 {
 				device_type = "pci";
 				assigned-addresses = <0x82000800 0 0x48000 0 0x2000>;
-				reg = <0x1000 0 0 0 0>;
+				reg = <0x2000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
 				#interrupt-cells = <1>;
-- 
1.9.3
