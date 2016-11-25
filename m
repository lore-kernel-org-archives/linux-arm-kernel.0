From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Fri, 25 Nov 2016 10:09:18 +0100
Subject: [PATCH 07/10] ARM: dts: sun8i-a33-olinuxino: use AXP223 DTSI
In-Reply-To: <20161125090921.23138-1-quentin.schulz@free-electrons.com>
References: <20161125090921.23138-1-quentin.schulz@free-electrons.com>
Message-ID: <20161125090921.23138-8-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously, the Olimex A33-OlinuXino used everything declared in AXP221
DTSI while it has an AXP223 PMIC.

This corrects that so the Olimex A33-OlinuXino can get some features the
AXP223 has (at the moment, ability to have 100mA as maximal current on
VBUS power supply).

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
index 9ea637e..3e8f2ec 100644
--- a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
+++ b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
@@ -126,7 +126,7 @@
 	};
 };
 
-#include "axp22x.dtsi"
+#include "axp223.dtsi"
 
 &reg_aldo1 {
 	regulator-always-on;
-- 
2.9.3
