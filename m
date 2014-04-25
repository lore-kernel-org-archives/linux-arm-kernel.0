From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 25 Apr 2014 16:07:15 +0200
Subject: [PATCH v2 17/18] ARM: mvebu: dts: Enable USB3 in Armada 375 DB
In-Reply-To: <1398434836-18908-1-git-send-email-gregory.clement@free-electrons.com>
References: <1398434836-18908-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1398434836-18908-18-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to enable the USB3 host controller on the Armada 375 DB
platform, we need to create a ranges at the soc node level to describe
the special static window for USB3.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375-db.dts | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-375-db.dts b/arch/arm/boot/dts/armada-375-db.dts
index 9378d3136b41..928de536a0ff 100644
--- a/arch/arm/boot/dts/armada-375-db.dts
+++ b/arch/arm/boot/dts/armada-375-db.dts
@@ -30,8 +30,9 @@
 	};
 
 	soc {
-		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
-			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000>;
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000 /* internal regs */
+			  MBUS_ID(0x05, 0x00) 0 0xff100000 0x20000  /* USB3 XHCI */
+			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000 /* bootrom */>;
 
 		internal-regs {
 			spi at 10600 {
@@ -126,5 +127,10 @@
 				status = "okay";
 			};
 		};
+
+		usb3-controller {
+			status = "okay";
+		};
+
 	};
 };
-- 
1.8.1.2
