From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 15 Oct 2015 16:28:46 +0200
Subject: [PATCH 2/3] ARM: dts: sun6i: Add mmc2_pins_a pinmux setting to
 sun6i-a31.dtsi
In-Reply-To: <1444919327-23747-1-git-send-email-hdegoede@redhat.com>
References: <1444919327-23747-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1444919327-23747-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a pinmux setting for using mmc2 in regular 4 bit mode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index a97274a8..83c1879 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -691,7 +691,15 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			mmc2_8bit_emmc_pins: mmc2 at 0 {
+			mmc2_pins_a: mmc2 at 0 {
+				allwinner,pins = "PC6", "PC7", "PC8", "PC9",
+						 "PC10", "PC11";
+				allwinner,function = "mmc2";
+				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+			};
+
+			mmc2_8bit_emmc_pins: mmc2 at 1 {
 				allwinner,pins = "PC6", "PC7", "PC8", "PC9",
 						 "PC10", "PC11", "PC12",
 						 "PC13", "PC14", "PC15",
-- 
2.5.0
