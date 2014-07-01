From: tklauser@distanz.ch (Tobias Klauser)
Date: Tue,  1 Jul 2014 10:47:48 +0200
Subject: [PATCH] ARM: ux500: storage class should be before const qualifier
Message-ID: <1404204468-8715-1-git-send-email-tklauser@distanz.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The C99 specification states in section 6.11.5:

The placement of a storage-class specifier other than at the beginning
of the declaration specifiers in a declaration is an obsolescent
feature.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/arm/mach-ux500/timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index 87efda0..ff28d8a 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -16,7 +16,7 @@
 #include "db8500-regs.h"
 #include "id.h"
 
-const static struct of_device_id prcmu_timer_of_match[] __initconst = {
+static const struct of_device_id prcmu_timer_of_match[] __initconst = {
 	{ .compatible = "stericsson,db8500-prcmu-timer-4", },
 	{ },
 };
-- 
1.7.9.5
