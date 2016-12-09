From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Fri,  9 Dec 2016 12:04:17 +0100
Subject: [PATCH v2 09/11] ARM: dts: sun8i-a33-sinlinx-sina33: use AXP223 DTSI
In-Reply-To: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
Message-ID: <20161209110419.28981-10-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously, the Sinlinx SinA33 used everything declared in AXP221 DTSI
while it has an AXP223 PMIC.

This corrects that so the Sinlinx SinA33 can get some features the
AXP223 has (at the moment, ability to have 100mA as maximal current on
VBUS power supply).

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index fef6abc..1fc459c 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -145,7 +145,7 @@
 	};
 };
 
-#include "axp22x.dtsi"
+#include "axp223.dtsi"
 
 &reg_aldo1 {
 	regulator-always-on;
-- 
2.9.3
