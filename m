From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 19 Dec 2017 15:01:31 +0530
Subject: [PATCH 5/7] ARM: dts: dra7: Remove deprecated PCI compatible string
In-Reply-To: <20171219093133.16565-1-kishon@ti.com>
References: <20171219093133.16565-1-kishon@ti.com>
Message-ID: <20171219093133.16565-6-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since SoC specific compatible strings are used for PCIe in
dra74x.dtsi and dra72x.dtsi, remove the compatible property
from dra7.dtsi which uses the deprecated compatible string.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 333f6a634ff9..1efa908c7bce 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -293,7 +293,6 @@
 			 * node and enable pcie1_ep mode.
 			 */
 			pcie1_rc: pcie at 51000000 {
-				compatible = "ti,dra7-pcie";
 				reg = <0x51000000 0x2000>, <0x51002000 0x14c>, <0x1000 0x2000>;
 				reg-names = "rc_dbics", "ti_conf", "config";
 				interrupts = <0 232 0x4>, <0 233 0x4>;
@@ -325,7 +324,6 @@
 			};
 
 			pcie1_ep: pcie_ep at 51000000 {
-				compatible = "ti,dra7-pcie-ep";
 				reg = <0x51000000 0x28>, <0x51002000 0x14c>, <0x51001000 0x28>, <0x1000 0x10000000>;
 				reg-names = "ep_dbics", "ti_conf", "ep_dbics2", "addr_space";
 				interrupts = <0 232 0x4>;
@@ -350,7 +348,6 @@
 				  0x0	     0x30000000 0x10000000>;
 			status = "disabled";
 			pcie2_rc: pcie at 51800000 {
-				compatible = "ti,dra7-pcie";
 				reg = <0x51800000 0x2000>, <0x51802000 0x14c>, <0x1000 0x2000>;
 				reg-names = "rc_dbics", "ti_conf", "config";
 				interrupts = <0 355 0x4>, <0 356 0x4>;
-- 
2.11.0
