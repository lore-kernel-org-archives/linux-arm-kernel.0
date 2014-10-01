From: hdegoede@redhat.com (Hans de Goede)
Date: Wed,  1 Oct 2014 09:26:05 +0200
Subject: [PATCH v2 2/3] ARM: dts: sun7i: Add uart3_pins_b pinctrl setting
In-Reply-To: <1412148366-18346-1-git-send-email-hdegoede@redhat.com>
References: <1412148366-18346-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1412148366-18346-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The uart3_pins_a multiplexes the uart3 pins to port G, add a pinctrl entry
for mapping them to port H (as used on the Bananapi).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index cb5abef..302dc1f 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -677,6 +677,13 @@
 				allwinner,pull = <0>;
 			};
 
+			uart3_pins_b: uart3 at 1 {
+				allwinner,pins = "PH0", "PH1";
+				allwinner,function = "uart3";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			uart4_pins_a: uart4 at 0 {
 				allwinner,pins = "PG10", "PG11";
 				allwinner,function = "uart4";
-- 
2.1.0
