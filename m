From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu,  8 Aug 2013 18:03:09 -0300
Subject: [PATCH for v3.12] ARM: mvebu: Relocate PCIe node in Armada 370 RD
 board
Message-ID: <1375995789-24146-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pcie-controller node needs to be relocated according the MBus
DT binding, since it's now a child of the mbus-compatible node.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
Applies on mvebu's for-next.

Jason,

Please pick this in mvebu/mbus_dt. Somehow this slipped through
our tests until just now.

Thanks!

 arch/arm/boot/dts/armada-370-rd.dts | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index 0b3acf3..f81810a 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -31,6 +31,22 @@
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
 
+		pcie-controller {
+			status = "okay";
+
+			/* Internal mini-PCIe connector */
+			pcie at 1,0 {
+				/* Port 0, Lane 0 */
+				status = "okay";
+			};
+
+			/* Internal mini-PCIe connector */
+			pcie at 2,0 {
+				/* Port 1, Lane 0 */
+				status = "okay";
+			};
+		};
+
 		internal-regs {
 			serial at 12000 {
 				clock-frequency = <200000000>;
@@ -88,22 +104,6 @@
 					gpios = <&gpio0 6 1>;
 				};
 			};
-
-			pcie-controller {
-				status = "okay";
-
-				/* Internal mini-PCIe connector */
-				pcie at 1,0 {
-					/* Port 0, Lane 0 */
-					status = "okay";
-				};
-
-				/* Internal mini-PCIe connector */
-				pcie at 2,0 {
-					/* Port 1, Lane 0 */
-					status = "okay";
-				};
-			};
 		};
 	};
  };
-- 
1.8.1.5
