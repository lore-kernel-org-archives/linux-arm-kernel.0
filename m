From: vivien.didelot@savoirfairelinux.com (Vivien Didelot)
Date: Thu, 12 Jan 2017 18:06:20 -0500
Subject: [PATCH] ARM: dts: vf610-zii-dev: add EEPROM entry to Rev C
Message-ID: <20170112230620.1735-1-vivien.didelot@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ZII Dev Rev C board has EEPROMs hanging the 88E6390 Ethernet switch
chips. Add an "eeprom-length" property to allow access from ethtool.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
index fbedb7bb3628..6a45bd24ffe6 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
@@ -71,6 +71,7 @@
 				#size-cells = <0>;
 				reg = <0>;
 				dsa,member = <0 0>;
+				eeprom-length = <512>;
 
 				ports {
 					#address-cells = <1>;
@@ -128,6 +129,7 @@
 				#size-cells = <0>;
 				reg = <0>;
 				dsa,member = <0 1>;
+				eeprom-length = <512>;
 
 				ports {
 					#address-cells = <1>;
-- 
2.11.0
