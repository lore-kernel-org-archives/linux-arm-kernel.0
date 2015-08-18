From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 18 Aug 2015 10:08:59 +0200
Subject: [PATCH 08/10] ARM: marvell/dt: define crypto SRAM ranges for all
 armada-38x boards
In-Reply-To: <1439885341-14644-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1439885341-14644-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1439885341-14644-9-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the crypto SRAM ranges so that the resources referenced by the
sa-sram node can be properly extracted from the DT.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/armada-385-db-ap.dts    | 4 +++-
 arch/arm/boot/dts/armada-385-linksys.dtsi | 4 +++-
 arch/arm/boot/dts/armada-388-db.dts       | 4 +++-
 arch/arm/boot/dts/armada-388-gp.dts       | 4 +++-
 arch/arm/boot/dts/armada-388-rd.dts       | 4 +++-
 5 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385-db-ap.dts b/arch/arm/boot/dts/armada-385-db-ap.dts
index 89f5a95..4de813c 100644
--- a/arch/arm/boot/dts/armada-385-db-ap.dts
+++ b/arch/arm/boot/dts/armada-385-db-ap.dts
@@ -59,7 +59,9 @@
 
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
-			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000>;
+			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
+			  MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000
+			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000>;
 
 		internal-regs {
 			spi1: spi at 10680 {
diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
index 74a9c6b..3710755 100644
--- a/arch/arm/boot/dts/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
@@ -57,7 +57,9 @@
 
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
-			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000>;
+			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
+			  MBUS_ID(0x09, 0x09) 0 0xf1100000 0x10000
+			  MBUS_ID(0x09, 0x05) 0 0xf1110000 0x10000>;
 
 		internal-regs {
 
diff --git a/arch/arm/boot/dts/armada-388-db.dts b/arch/arm/boot/dts/armada-388-db.dts
index 91ac8c1..ff47af5 100644
--- a/arch/arm/boot/dts/armada-388-db.dts
+++ b/arch/arm/boot/dts/armada-388-db.dts
@@ -64,7 +64,9 @@
 
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
-			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000>;
+			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
+			  MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000
+			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000>;
 
 		internal-regs {
 			spi at 10600 {
diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
index 353c925..4baac93 100644
--- a/arch/arm/boot/dts/armada-388-gp.dts
+++ b/arch/arm/boot/dts/armada-388-gp.dts
@@ -58,7 +58,9 @@
 
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
-			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000>;
+			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
+			  MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000
+			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000>;
 
 		internal-regs {
 			spi at 10600 {
diff --git a/arch/arm/boot/dts/armada-388-rd.dts b/arch/arm/boot/dts/armada-388-rd.dts
index b657b16..853f973 100644
--- a/arch/arm/boot/dts/armada-388-rd.dts
+++ b/arch/arm/boot/dts/armada-388-rd.dts
@@ -65,7 +65,9 @@
 
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
-			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000>;
+			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
+			  MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000
+			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000>;
 
 		internal-regs {
 			spi at 10600 {
-- 
1.9.1
