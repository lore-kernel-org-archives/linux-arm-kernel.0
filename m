From: ravibabu@ti.com (Ravi Babu)
Date: Fri, 13 Jan 2017 18:10:34 +0530
Subject: [PATCH 2/2] ARM: dts: dra72x-evm: increase QSPI SPL partition size
In-Reply-To: <1484311234-21978-1-git-send-email-ravibabu@ti.com>
References: <1484311234-21978-1-git-send-email-ravibabu@ti.com>
Message-ID: <1484311234-21978-3-git-send-email-ravibabu@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SPL size for DRA72x platform has increased and
is now more than 64KB. Increase QSPI SPL partition
size to 256KB for DRA72x EVM.

QSPI partition numbers change because of this.

Signed-off-by: Ravi Babu <ravibabu@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra72-evm-common.dtsi | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index e50fbee..ae1a663 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -439,41 +439,29 @@
 		 */
 		partition at 0 {
 			label = "QSPI.SPL";
-			reg = <0x00000000 0x000010000>;
+			reg = <0x00000000 0x000040000>;
 		};
 		partition at 1 {
-			label = "QSPI.SPL.backup1";
-			reg = <0x00010000 0x00010000>;
-		};
-		partition at 2 {
-			label = "QSPI.SPL.backup2";
-			reg = <0x00020000 0x00010000>;
-		};
-		partition at 3 {
-			label = "QSPI.SPL.backup3";
-			reg = <0x00030000 0x00010000>;
-		};
-		partition at 4 {
 			label = "QSPI.u-boot";
 			reg = <0x00040000 0x00100000>;
 		};
-		partition at 5 {
+		partition at 2 {
 			label = "QSPI.u-boot-spl-os";
 			reg = <0x00140000 0x00080000>;
 		};
-		partition at 6 {
+		partition at 3 {
 			label = "QSPI.u-boot-env";
 			reg = <0x001c0000 0x00010000>;
 		};
-		partition at 7 {
+		partition at 4 {
 			label = "QSPI.u-boot-env.backup1";
 			reg = <0x001d0000 0x0010000>;
 		};
-		partition at 8 {
+		partition at 5 {
 			label = "QSPI.kernel";
 			reg = <0x001e0000 0x0800000>;
 		};
-		partition at 9 {
+		partition at 6 {
 			label = "QSPI.file-system";
 			reg = <0x009e0000 0x01620000>;
 		};
-- 
1.9.1
