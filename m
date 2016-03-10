From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 10 Mar 2016 11:09:14 +0100
Subject: [PATCH v5 net-next 06/10] ARM: dts: armada-xp-openblocks-ax3-4: Add
 BM support
In-Reply-To: <1457604558-1121-1-git-send-email-gregory.clement@free-electrons.com>
References: <1457604558-1121-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1457604558-1121-7-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow Openblock AX3 using hardware buffer management with mvneta.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index a5db17782e08..3aa29a91c7b8 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -67,7 +67,8 @@
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x8000000
 			  MBUS_ID(0x09, 0x09) 0 0 0xf8100000 0x10000
-			  MBUS_ID(0x09, 0x05) 0 0 0xf8110000 0x10000>;
+			  MBUS_ID(0x09, 0x05) 0 0 0xf8110000 0x10000
+			  MBUS_ID(0x0c, 0x04) 0 0 0xd1200000 0x100000>;
 
 		devbus-bootcs {
 			status = "okay";
@@ -176,21 +177,29 @@
 				status = "okay";
 				phy = <&phy0>;
 				phy-mode = "sgmii";
+				buffer-manager = <&bm>;
+				bm,pool-long = <0>;
 			};
 			ethernet at 74000 {
 				status = "okay";
 				phy = <&phy1>;
 				phy-mode = "sgmii";
+				buffer-manager = <&bm>;
+				bm,pool-long = <1>;
 			};
 			ethernet at 30000 {
 				status = "okay";
 				phy = <&phy2>;
 				phy-mode = "sgmii";
+				buffer-manager = <&bm>;
+				bm,pool-long = <2>;
 			};
 			ethernet at 34000 {
 				status = "okay";
 				phy = <&phy3>;
 				phy-mode = "sgmii";
+				buffer-manager = <&bm>;
+				bm,pool-long = <3>;
 			};
 			i2c at 11000 {
 				status = "okay";
@@ -219,6 +228,14 @@
 			usb at 51000 {
 				status = "okay";
 			};
+
+			bm at c0000 {
+				status = "okay";
+			};
+		};
+
+		bm-bppi {
+			status = "okay";
 		};
 	};
 };
-- 
2.5.0
