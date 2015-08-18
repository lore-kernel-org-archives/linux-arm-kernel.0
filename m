From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 18 Aug 2015 10:08:53 +0200
Subject: [PATCH 02/10] ARM: marvell/dt: define crypto SRAM ranges for all
 armada-xp boards
In-Reply-To: <1439885341-14644-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1439885341-14644-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1439885341-14644-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the crypto SRAM ranges so that the resources referenced by the
sa-sram node can be properly extracted from the DT.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-axpwifiap.dts        | 4 +++-
 arch/arm/boot/dts/armada-xp-db.dts               | 4 +++-
 arch/arm/boot/dts/armada-xp-gp.dts               | 4 +++-
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts  | 4 +++-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts    | 4 +++-
 arch/arm/boot/dts/armada-xp-matrix.dts           | 4 +++-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts   | 4 +++-
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 4 +++-
 arch/arm/boot/dts/armada-xp-synology-ds414.dts   | 4 +++-
 9 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index 60bbfe3..23fc670 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -69,7 +69,9 @@
 
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
-			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
+			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
+			  MBUS_ID(0x09, 0x09) 0 0 0xf8100000 0x10000
+			  MBUS_ID(0x09, 0x05) 0 0 0xf8110000 0x10000>;
 
 		pcie-controller {
 			status = "okay";
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 7dd900f..f774101 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -75,7 +75,9 @@
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
-			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000>;
+			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000
+			  MBUS_ID(0x09, 0x09) 0 0 0xf8100000 0x10000
+			  MBUS_ID(0x09, 0x05) 0 0 0xf8110000 0x10000>;
 
 		devbus-bootcs {
 			status = "okay";
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index bf724ca..4878d73 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -94,7 +94,9 @@
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
-			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000>;
+			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000
+			  MBUS_ID(0x09, 0x09) 0 0 0xf8100000 0x10000
+			  MBUS_ID(0x09, 0x05) 0 0 0xf8110000 0x10000>;
 
 		devbus-bootcs {
 			status = "okay";
diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index 06a6a6c..58b5008 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -64,7 +64,9 @@
 
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
-			MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
+			MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
+			MBUS_ID(0x09, 0x09) 0 0 0xf8100000 0x10000
+			MBUS_ID(0x09, 0x05) 0 0 0xf8110000 0x10000>;
 
 		pcie-controller {
 			status = "okay";
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index fdd187c..6e9820e 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -69,7 +69,9 @@
 
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
-			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
+			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
+			  MBUS_ID(0x09, 0x09) 0 0 0xf8100000 0x10000
+			  MBUS_ID(0x09, 0x05) 0 0 0xf8110000 0x10000>;
 
 		pcie-controller {
 			status = "okay";
diff --git a/arch/arm/boot/dts/armada-xp-matrix.dts b/arch/arm/boot/dts/armada-xp-matrix.dts
index f894bc8..6ab3383 100644
--- a/arch/arm/boot/dts/armada-xp-matrix.dts
+++ b/arch/arm/boot/dts/armada-xp-matrix.dts
@@ -67,7 +67,9 @@
 
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
-			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
+			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
+			  MBUS_ID(0x09, 0x09) 0 0 0xf8100000 0x10000
+			  MBUS_ID(0x09, 0x05) 0 0 0xf8110000 0x10000>;
 
 		internal-regs {
 			serial at 12000 {
diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
index 1516fc2..979fae9 100644
--- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
+++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
@@ -63,7 +63,9 @@
 
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
-			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
+			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
+			  MBUS_ID(0x09, 0x09) 0 0 0xf8100000 0x10000
+			  MBUS_ID(0x09, 0x05) 0 0 0xf8110000 0x10000>;
 
 		pcie-controller {
 			status = "okay";
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 990e8a2..a5db177 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -65,7 +65,9 @@
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
-			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x8000000>;
+			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x8000000
+			  MBUS_ID(0x09, 0x09) 0 0 0xf8100000 0x10000
+			  MBUS_ID(0x09, 0x05) 0 0 0xf8110000 0x10000>;
 
 		devbus-bootcs {
 			status = "okay";
diff --git a/arch/arm/boot/dts/armada-xp-synology-ds414.dts b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
index 20267ad..2391b11 100644
--- a/arch/arm/boot/dts/armada-xp-synology-ds414.dts
+++ b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
@@ -77,7 +77,9 @@
 
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
-			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
+			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
+			  MBUS_ID(0x09, 0x09) 0 0 0xf8100000 0x10000
+			  MBUS_ID(0x09, 0x05) 0 0 0xf8110000 0x10000>;
 
 		pcie-controller {
 			status = "okay";
-- 
1.9.1
