From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 18 Aug 2015 10:08:55 +0200
Subject: [PATCH 04/10] ARM: marvell/dt: define crypto SRAM ranges for all
 armada-370 boards
In-Reply-To: <1439885341-14644-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1439885341-14644-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1439885341-14644-5-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the crypto SRAM ranges so that the resources referenced by the
sa-sram node can be properly extracted from the DT.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts              | 3 ++-
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts   | 3 ++-
 arch/arm/boot/dts/armada-370-mirabox.dts         | 7 ++++++-
 arch/arm/boot/dts/armada-370-netgear-rn102.dts   | 3 ++-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts   | 3 ++-
 arch/arm/boot/dts/armada-370-rd.dts              | 3 ++-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts | 3 ++-
 7 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 03542f7..bb280de 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -74,7 +74,8 @@
 
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
-			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
+			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
+			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
 		internal-regs {
 			serial at 12000 {
diff --git a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
index af4dc54..e2a363b 100644
--- a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
+++ b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
@@ -69,7 +69,8 @@
 
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
-			MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
+			MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
+			MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
 		pcie-controller {
 			status = "okay";
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index 0f40d5d..3aa980a 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -61,7 +61,8 @@
 
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
-			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
+			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
+			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
 		pcie-controller {
 			status = "okay";
@@ -138,6 +139,10 @@
 				phy-mode = "rgmii-id";
 			};
 
+			crypto at 90000 {
+				status = "okay";
+			};
+
 			mvsdio at d4000 {
 				pinctrl-0 = <&sdio_pins3>;
 				pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index a312078..f43ee4a 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -63,7 +63,8 @@
 
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
-			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
+			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
+			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
 		pcie-controller {
 			status = "okay";
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index 00540f2..4c240de 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -63,7 +63,8 @@
 
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
-			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
+			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
+			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
 		pcie-controller {
 			status = "okay";
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index 19475e6..fbef730 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -74,7 +74,8 @@
 
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
-			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
+			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
+			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
 		pcie-controller {
 			status = "okay";
diff --git a/arch/arm/boot/dts/armada-370-synology-ds213j.dts b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
index 4f49243..836bcc0 100644
--- a/arch/arm/boot/dts/armada-370-synology-ds213j.dts
+++ b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
@@ -77,7 +77,8 @@
 
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
-			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
+			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
+			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
 		internal-regs {
 
-- 
1.9.1
