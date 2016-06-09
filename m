From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 9 Jun 2016 20:43:55 +0530
Subject: [PATCH] ARM: dts: DRA7: fix unit address of second PCIe instance
Message-ID: <f79ded6b0b41c8e13f8f396d47f9522e5471d327.1465484975.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kishon Vijay Abraham I <kishon@ti.com>

The unit address of the second PCIe instance
is set to be same as that of the first instance
(copy-paste error).

Fix it.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index a26b9a01af5d..0ba791add7f6 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -330,7 +330,7 @@
 			ranges = <0x51800000 0x51800000 0x3000
 				  0x0	     0x30000000 0x10000000>;
 			status = "disabled";
-			pcie at 51000000 {
+			pcie at 51800000 {
 				compatible = "ti,dra7-pcie";
 				reg = <0x51800000 0x2000>, <0x51802000 0x14c>, <0x1000 0x2000>;
 				reg-names = "rc_dbics", "ti_conf", "config";
-- 
2.6.3
