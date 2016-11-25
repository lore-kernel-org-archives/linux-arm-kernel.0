From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Fri, 25 Nov 2016 10:09:19 +0100
Subject: [PATCH 08/10] ARM: dts: sun8i-a33-sinlinx-sina33: use AXP223 DTSI
In-Reply-To: <20161125090921.23138-1-quentin.schulz@free-electrons.com>
References: <20161125090921.23138-1-quentin.schulz@free-electrons.com>
Message-ID: <20161125090921.23138-9-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously, the Sinlinx SinA33 used everything declared in AXP221 DTSI
while it has an AXP223 PMIC.

This corrects that so the Sinlinx SinA33 can get some features the
AXP223 has (at the moment, ability to have 100mA as maximal current on
VBUS power supply).

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index 573aa2c..3373164 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -161,7 +161,7 @@
 	};
 };
 
-#include "axp22x.dtsi"
+#include "axp223.dtsi"
 
 &reg_aldo1 {
 	regulator-always-on;
-- 
2.9.3
