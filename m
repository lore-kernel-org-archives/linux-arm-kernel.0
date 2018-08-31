From: venture@google.com (Patrick Venture)
Date: Fri, 31 Aug 2018 13:58:55 -0700
Subject: [PATCH v2 2/2] ARM: dts: aspeed: quanta-q71l: Add four PSUs
Message-ID: <20180831205855.242061-1-venture@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the four PSUs via generic PMBUS.

Signed-off-by: Patrick Venture <venture@google.com>
---
Changes for v2:
 - Fixed the commit header typo s/q7l1/q71l/
---
 arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts b/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
index 586050e1c0e6..c655564e6c6d 100644
--- a/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
@@ -318,24 +318,44 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			psu at 59 {
+				compatible = "pmbus";
+				reg = <0x59>;
+			};
 		};
 
 		i2c_psu1: i2c at 1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+
+			psu at 58 {
+				compatible = "pmbus";
+				reg = <0x58>;
+			};
 		};
 
 		i2c_psu3: i2c at 2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+
+			psu at 58 {
+				compatible = "pmbus";
+				reg = <0x58>;
+			};
 		};
 
 		i2c_psu2: i2c at 3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
+
+			psu at 59 {
+				compatible = "pmbus";
+				reg = <0x59>;
+			};
 		};
 	};
 
-- 
2.19.0.rc1.350.ge57e33dbd1-goog
