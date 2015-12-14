From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 14 Dec 2015 20:11:38 +0100
Subject: [PATCH/RFC 1/7] ARM: dt: mvebu: ix4-300d: Add compatible property to
 "partitions" node
In-Reply-To: <1450120304-2760-1-git-send-email-geert+renesas@glider.be>
References: <1450120304-2760-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1450120304-2760-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
property to "partitions" node"), the "partitions" subnode of an SPI
FLASH device node must have a compatible property. The partitions are no
longer detected if it is not present.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
The abovementioned commit is destined for v4.4.
---
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index 13cf69a8d0fb392b..fb9e1bbf23385b85 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -152,6 +152,7 @@
 				nand-on-flash-bbt;
 
 				partitions {
+					compatible = "fixed-partitions";
 					#address-cells = <1>;
 					#size-cells = <1>;
 
-- 
1.9.1
