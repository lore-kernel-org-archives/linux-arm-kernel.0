From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Nov 2014 20:29:55 +0000
Subject: [PATCH 3/8] ARM: drop nwfpe initialisation message from warning to
 info level
In-Reply-To: <20141117202911.GZ4042@n2100.arm.linux.org.uk>
References: <20141117202911.GZ4042@n2100.arm.linux.org.uk>
Message-ID: <E1XqSvr-0002EN-Ac@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

nwfpe's initialisation message is not a warning, it is purely
informational.  Print it at the appropriate message level.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/nwfpe/fpmodule.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/nwfpe/fpmodule.c b/arch/arm/nwfpe/fpmodule.c
index b2a9182acf14..ec717c190e2c 100644
--- a/arch/arm/nwfpe/fpmodule.c
+++ b/arch/arm/nwfpe/fpmodule.c
@@ -98,8 +98,8 @@ static int __init fpe_init(void)
 		return 0;
 
 	/* Display title, version and copyright information. */
-	printk(KERN_WARNING "NetWinder Floating Point Emulator V0.97 ("
-	       NWFPE_BITS " precision)\n");
+	pr_info("NetWinder Floating Point Emulator V0.97 ("
+	        NWFPE_BITS " precision)\n");
 
 	thread_register_notifier(&nwfpe_notifier_block);
 
-- 
1.8.3.1
