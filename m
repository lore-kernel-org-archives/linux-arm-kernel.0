From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 29 Sep 2014 18:35:27 -0700
Subject: [PATCH 2/5] ARM: mvebu: drop unnecessary include
In-Reply-To: <1412040930-16864-1-git-send-email-computersforpeace@gmail.com>
References: <1412040930-16864-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1412040930-16864-3-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<asm/cp15.h> is only being included because of the implicit requirements
of v7_exit_coherency_flush(). Now that the implicit include is provided
for us, we can drop it from our explicit list.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/mach-mvebu/pmsu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 8a70a51533fd..2d283cbc5cc7 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -33,7 +33,6 @@
 #include <linux/slab.h>
 #include <linux/smp.h>
 #include <asm/cacheflush.h>
-#include <asm/cp15.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
-- 
1.9.1
