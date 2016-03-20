From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 20 Mar 2016 17:00:29 +0100
Subject: [PATCH 1/8] ARM: dts: sun8i: Add mmc2_8bit_pins to sun8i-h3.dtsi
In-Reply-To: <1458489636-2825-1-git-send-email-hdegoede@redhat.com>
References: <1458489636-2825-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1458489636-2825-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a pinctrl node for mmc2 in 8 bits mode on H3 SoCs.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index dadb7f6..d1be2f5 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -417,6 +417,16 @@
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
+
+			mmc2_8bit_pins: mmc2_8bit {
+				allwinner,pins = "PC5", "PC6", "PC8",
+						 "PC9", "PC10", "PC11",
+						 "PC12", "PC13", "PC14",
+						 "PC15", "PC16";
+				allwinner,function = "mmc2";
+				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
 		};
 
 		ahb_rst: reset at 01c202c0 {
-- 
2.7.3
