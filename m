From: jaz@semihalf.com (Grzegorz Jaszczyk)
Date: Thu,  4 Aug 2016 12:14:17 +0200
Subject: [PATCH v2 14/17] ARM: dts: mvebu: armada-398: update the dtsi about
 missing interfaces
In-Reply-To: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
References: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
Message-ID: <1470305660-6601-15-git-send-email-jaz@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Beside interfaces described in the armada-39x.dtsi and armada-395.dtsi, the
Armada 398 SoC family supports 2 additional SATA port (2 ports in one unit)

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-398.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-398.dtsi b/arch/arm/boot/dts/armada-398.dtsi
index fdc2591..234a998 100644
--- a/arch/arm/boot/dts/armada-398.dtsi
+++ b/arch/arm/boot/dts/armada-398.dtsi
@@ -44,7 +44,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "armada-39x.dtsi"
+#include "armada-395.dtsi"
 
 / {
 	compatible = "marvell,armada398", "marvell,armada390";
@@ -55,6 +55,14 @@
 				compatible = "marvell,mv88f6928-pinctrl";
 				reg = <0x18000 0x20>;
 			};
+
+			sata at e0000 {
+				compatible = "marvell,armada-380-ahci";
+				reg = <0xe0000 0x2000>;
+				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gateclk 30>;
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
1.8.3.1
