From: plaes@plaes.org (Priit Laes)
Date: Wed, 23 Sep 2015 10:38:34 +0300
Subject: [PATCH v2 4/4] ARM: dts: sun4i: gemei-g9: Enable sun4i audio codec
 support
In-Reply-To: <1442993914-20295-1-git-send-email-plaes@plaes.org>
References: <1442993914-20295-1-git-send-email-plaes@plaes.org>
Message-ID: <1442993914-20295-5-git-send-email-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gemei G9 has internal speakers and headphone jack. Audio switching
from internal speakers to headphones is automatically handled by
extra FT2012Q audio amplifier chip that works out of the box.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
index b7cab72..2db75c4 100644
--- a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
@@ -65,12 +65,19 @@
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
+	routing =
+		"Headphone Jack", "HP Left",
+		"Headphone Jack", "HP Right";
+		/* TODO: input configuration */
+	status = "okay";
+};
 
 &cpu0 {
 	cpu-supply = <&reg_dcdc2>;
-- 
2.5.3
