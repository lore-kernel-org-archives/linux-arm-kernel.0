From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 20 Nov 2014 16:55:27 +0100
Subject: [PATCH 8/9] ARM: dts: sun6i: Add pinmux settings for the ir pins
In-Reply-To: <1416498928-1300-1-git-send-email-hdegoede@redhat.com>
References: <1416498928-1300-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1416498928-1300-9-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinmux settings for the ir receive pin of the A31.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index d33e758..90b7537 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -922,6 +922,13 @@
 			#interrupt-cells = <2>;
 			#size-cells = <0>;
 			#gpio-cells = <3>;
+
+			ir_pins_a: ir at 0 {
+				allwinner,pins = "PL4";
+				allwinner,function = "s_ir";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 	};
 };
-- 
2.1.0
