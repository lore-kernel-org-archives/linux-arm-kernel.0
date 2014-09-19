From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 19 Sep 2014 22:14:43 +0200
Subject: [PATCH 7/8] ARM: mvebu: armada-xp: Add I2C eeprom on Lenovo ix4-300d
In-Reply-To: <1411157684-6991-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1411157684-6991-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1411157684-6991-8-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is an I2C eeprom connected on Lenovo ix4-300d, add the
corresponding node.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
IIRC, the eeprom contains some register init pairs (address, data) for
and is empty otherwise. I'll have to check the boot loader code again,
but (again) IIRC, stock u-boot already does the sequence in code and
ignores the eeprom.

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Benoit Masson <yahoo@perenite.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index c5ee6c00766c..cef50da88e45 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -98,6 +98,11 @@
 					reg = <0x2e>;
 				};
 
+				at24c64 at 50 {
+					compatible = "atmel,24c64";
+					reg = <0x50>;
+				};
+
 				pcf8563 at 51 {
 					compatible = "nxp,pcf8563";
 					reg = <0x51>;
-- 
2.0.0
