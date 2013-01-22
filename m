From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 22 Jan 2013 20:46:33 +0100
Subject: [PATCH] ARM: kirkwood: fix missing #interrupt-cells property
Message-ID: <1358883993-17280-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpio controller on kirkwood can provide interrupts but is missing
the #interrupt-cells property. This patch just adds it to both gpio
controllers.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Jamie Lentin <jm@lentin.co.uk>
Cc: Jean-Francois Moine <moinejf@free.fr>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/kirkwood.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 110d6cb..d6ab442 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -36,6 +36,7 @@
 			reg = <0x10100 0x40>;
 			ngpios = <32>;
 			interrupt-controller;
+			#interrupt-cells = <2>;
 			interrupts = <35>, <36>, <37>, <38>;
 		};
 
@@ -46,6 +47,7 @@
 			reg = <0x10140 0x40>;
 			ngpios = <18>;
 			interrupt-controller;
+			#interrupt-cells = <2>;
 			interrupts = <39>, <40>, <41>;
 		};
 
-- 
1.7.10.4
