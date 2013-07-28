From: robherring2@gmail.com (Rob Herring)
Date: Sun, 28 Jul 2013 16:56:33 -0500
Subject: [PATCH 2/7] ARM: PSCI: remove unnecessary include of arm-gic.h
In-Reply-To: <1375048598-15637-1-git-send-email-robherring2@gmail.com>
References: <1375048598-15637-1-git-send-email-robherring2@gmail.com>
Message-ID: <1375048598-15637-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Now that gic_secondary_init is no longer needed to be called by SMP init
functions, the header is not needed.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/kernel/psci_smp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci_smp.c
index 70ded3f..570a48c 100644
--- a/arch/arm/kernel/psci_smp.c
+++ b/arch/arm/kernel/psci_smp.c
@@ -14,7 +14,6 @@
  */
 
 #include <linux/init.h>
-#include <linux/irqchip/arm-gic.h>
 #include <linux/smp.h>
 #include <linux/of.h>
 
-- 
1.8.1.2
