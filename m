From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Tue, 14 Aug 2018 09:39:48 +0200
Subject: [PATCH v2] ARM: dts: spear: fix stmpe811 interrupt properties
Message-ID: <20180814073949.27392-1-marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

The property "irq-over-gpio" simply does not exist (this is nowadays
actually auto detected) and the property "irq-gpios" is actually called
"irq-gpio".

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Fix commit message as pointed out by Viresh.

 arch/arm/boot/dts/spear320-hmi.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/spear320-hmi.dts b/arch/arm/boot/dts/spear320-hmi.dts
index 0d0da1f65f0e..d2d1fe944407 100644
--- a/arch/arm/boot/dts/spear320-hmi.dts
+++ b/arch/arm/boot/dts/spear320-hmi.dts
@@ -241,8 +241,7 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <0x41>;
-					irq-over-gpio;
-					irq-gpios = <&gpiopinctrl 29 0x4>;
+					irq-gpio = <&gpiopinctrl 29 0x4>;
 					id = <0>;
 					blocks = <0x5>;
 					irq-trigger = <0x1>;
-- 
2.14.4
