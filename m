From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue,  2 Jul 2013 12:54:13 +0200
Subject: [PATCH 2/2] ARM: orion5x: add missing mbus include
In-Reply-To: <1372762453-12018-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1372762453-12018-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1372762453-12018-3-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

edmini_v2-setup is missing an include of linux/mbus.h which causes
compiler error because of missing reference to mvebu_mbus_add_window.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk> 
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com> 
Cc: devicetree-discuss at lists.ozlabs.org 
Cc: linux-kernel at vger.kernel.org 
Cc: linux-arm-kernel at lists.infradead.org 
---
 arch/arm/mach-orion5x/edmini_v2-setup.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-orion5x/edmini_v2-setup.c b/arch/arm/mach-orion5x/edmini_v2-setup.c
index 1476155..1cecedc 100644
--- a/arch/arm/mach-orion5x/edmini_v2-setup.c
+++ b/arch/arm/mach-orion5x/edmini_v2-setup.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/pci.h>
 #include <linux/irq.h>
+#include <linux/mbus.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/leds.h>
-- 
1.7.2.5
