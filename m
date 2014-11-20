From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 20 Nov 2014 16:55:28 +0100
Subject: [PATCH 9/9] ARM: dts: sun6i: Enable ir receiver on the Mele M9
In-Reply-To: <1416498928-1300-1-git-send-email-hdegoede@redhat.com>
References: <1416498928-1300-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1416498928-1300-10-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Mele M9 has an ir receiver, enable it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31-m9.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-m9.dts b/arch/arm/boot/dts/sun6i-a31-m9.dts
index 4202c64..94ddf9c 100644
--- a/arch/arm/boot/dts/sun6i-a31-m9.dts
+++ b/arch/arm/boot/dts/sun6i-a31-m9.dts
@@ -83,6 +83,12 @@
 				reg = <1>;
 			};
 		};
+
+		ir at 01f02000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&ir_pins_a>;
+			status = "okay";
+		};
 	};
 
 	leds {
-- 
2.1.0
