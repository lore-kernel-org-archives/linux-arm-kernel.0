From: plaes@plaes.org (Priit Laes)
Date: Fri,  6 Nov 2015 19:54:46 +0200
Subject: [PATCH v3 3/3] ARM: dts: sun4i: gemei-g9: Enable sun4i audio codec
 support
In-Reply-To: <1446832486-32319-1-git-send-email-plaes@plaes.org>
References: <1446832486-32319-1-git-send-email-plaes@plaes.org>
Message-ID: <1446832486-32319-4-git-send-email-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gemei G9 has internal speakers and headphone jack. Audio switching
from internal speakers to headphones is automatically handled by
extra FT2012Q audio amplifier chip that works out of the box.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
Changes since v2:
 - Dropped routing property.

 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
index 16c1a67..1d73a98 100644
--- a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
@@ -65,12 +65,15 @@
 /*
  * TODO:
  *   2x cameras via CSI
- *   audio
+ *   audio input
  *   AXP battery management
  *   NAND
  *   OTG
  *   Touchscreen - gt801_2plus1 @ i2c adapter 2 @ 0x48
  */
+&codec {
+	status = "okay";
+};
 
 &cpu0 {
 	cpu-supply = <&reg_dcdc2>;
-- 
2.6.3
