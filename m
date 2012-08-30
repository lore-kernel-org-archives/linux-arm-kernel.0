From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 30 Aug 2012 07:39:12 +0200
Subject: [PATCH] ARM: Kirkwood: Fix 'SZ_1M' undeclared here for
 db88f6281-bp-setup.c
Message-ID: <1346305152-14618-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linux-next has failed to compile for kirkwood since 23 August with:

arch/arm/mach-kirkwood/db88f6281-bp-setup.c:29: error: 'SZ_1M' undeclared here (not in a function)
arch/arm/mach-kirkwood/db88f6281-bp-setup.c:33: error: 'SZ_4M' undeclared here (not in a function)

Add missing <linux/sizes.h>

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-kirkwood/db88f6281-bp-setup.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
index d933593..be90b7d 100644
--- a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
+++ b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/sizes.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/partitions.h>
 #include <linux/ata_platform.h>
-- 
1.7.10.4
