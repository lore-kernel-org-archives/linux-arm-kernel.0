From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed,  8 Mar 2017 18:35:19 +0100
Subject: [PATCH] ARM64: dts: marvell: armada-3720 add RTC support
Message-ID: <20170308173519.28685-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 3720 DB board has an RTC on the I2C bus. It's a PT7C4337A from
Pericom but which claims to be fully compatible with the ds1337.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index 10207f96f090..38fa7a85c28a 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -98,6 +98,12 @@
 		 * IO0_7: PWR_EN_SGMII	IO1_7: PWR_MCI_PS
 		 */
 	};
+
+	rtc at 68  {
+		/* PT7C4337A from pericom fully compatible with the ds1337 */
+		compatible = "dallas,ds1337";
+		reg = <0x68>;
+	};
 };
 
 /* CON3 */
-- 
2.11.0
