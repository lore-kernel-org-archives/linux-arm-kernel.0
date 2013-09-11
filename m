From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 11 Sep 2013 11:10:07 +0200
Subject: [PATCH 2/4] ARM: sun7i: Add the muxing options for the EMAC
In-Reply-To: <1378890609-28563-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1378890609-28563-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1378890609-28563-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A20 has several muxing options for the EMAC. Yet, the currently
supported boards only use one set of them. Add that pin set to the DTSI.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index e996f1d..80559cb 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -214,6 +214,17 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
+			emac_pins_a: emac0 at 0 {
+				allwinner,pins = "PA0", "PA1", "PA2",
+						"PA3", "PA4", "PA5", "PA6",
+						"PA7", "PA8", "PA9", "PA10",
+						"PA11", "PA12", "PA13", "PA14",
+						"PA15", "PA16";
+				allwinner,function = "emac";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
1.8.4
