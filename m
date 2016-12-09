From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Fri,  9 Dec 2016 12:04:19 +0100
Subject: [PATCH v2 11/11] ARM: dtsi: sun8i-reference-design-tablet: use AXP223
 DTSI
In-Reply-To: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
Message-ID: <20161209110419.28981-12-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously, the sun8i tablets used everything declared in AXP221 DTSI
while they have an AXP223 PMIC.

This corrects that so the sun8i tablets can get some features the AXP223
has (at the moment, ability to have 100mA as maximal current on VBUS
power supply).

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
index 08cd001..ea79c33 100644
--- a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
@@ -136,7 +136,7 @@
 	};
 };
 
-#include "axp22x.dtsi"
+#include "axp223.dtsi"
 
 &reg_aldo1 {
 	regulator-always-on;
-- 
2.9.3
