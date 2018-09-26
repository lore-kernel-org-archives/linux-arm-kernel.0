From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Sep 2018 15:04:39 +0200
Subject: [PATCH 2/2] ARM: ixp4xx: include linux/mtd/platnand.h
In-Reply-To: <20180926130458.2406549-1-arnd@arndb.de>
References: <20180926130458.2406549-1-arnd@arndb.de>
Message-ID: <20180926130458.2406549-2-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_nand_data structure definition is required for ixdp425
but has now moved to a new header file:

arch/arm/mach-ixp4xx/ixdp425-setup.c:98:15: error: variable 'ixdp425_flash_nand_data' has initializer but incomplete type
 static struct platform_nand_data ixdp425_flash_nand_data = {
               ^~~~~~~~~~~~~~~~~~
arch/arm/mach-ixp4xx/ixdp425-setup.c:99:3: error: 'struct platform_nand_data' has no member named 'chip'

Fixes: 19cf5dfa3a31 ("mtd: rawnand: Move platform_nand_xxx definitions out of rawnand.h")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ixp4xx/ixdp425-setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index 797e7edc7124..57d7df79d838 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -20,6 +20,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/mtd/platnand.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <asm/types.h>
-- 
2.18.0
