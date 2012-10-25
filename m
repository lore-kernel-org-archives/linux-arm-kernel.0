From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 25 Oct 2012 13:59:18 +0200
Subject: [PATCH] arm: bcm2835: remove useless variables from Makefile.boot
Message-ID: <1351166358-6134-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neither params_phys-y nor initrd_phys-y are needed when booting with a
Device Tree. Those values are passed through the Device Tree blob. So
get rid of those variable definitions from Makefile.boot.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-bcm2835/Makefile.boot |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-bcm2835/Makefile.boot b/arch/arm/mach-bcm2835/Makefile.boot
index 2d30e17..b327175 100644
--- a/arch/arm/mach-bcm2835/Makefile.boot
+++ b/arch/arm/mach-bcm2835/Makefile.boot
@@ -1,3 +1 @@
-   zreladdr-y := 0x00008000
-params_phys-y := 0x00000100
-initrd_phys-y := 0x00800000
+zreladdr-y := 0x00008000
-- 
1.7.9.5
