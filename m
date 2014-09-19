From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 19 Sep 2014 22:14:44 +0200
Subject: [PATCH 8/8] ARM: mvebu: armada-xp: Fix 74hc595 count for Lenovo
 ix4-300d
In-Reply-To: <1411157684-6991-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1411157684-6991-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1411157684-6991-9-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is only one 74hc595 connected to GPIO but two were given
in the registers-number property. Fix it up.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Benoit Masson <yahoo@perenite.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index cef50da88e45..90d9002923f5 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -204,7 +204,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			reg = <0>;
-			registers-number = <2>;
+			registers-number = <1>;
 			spi-max-frequency = <100000>;
 		};
 	};
-- 
2.0.0
