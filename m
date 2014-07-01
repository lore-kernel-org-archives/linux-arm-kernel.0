From: tklauser@distanz.ch (Tobias Klauser)
Date: Tue,  1 Jul 2014 10:47:17 +0200
Subject: [PATCH] ARM: spear: storage class should be before const qualifier
Message-ID: <1404204437-8657-1-git-send-email-tklauser@distanz.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The C99 specification states in section 6.11.5:

The placement of a storage-class specifier other than at the beginning
of the declaration specifiers in a declaration is an obsolescent
feature.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/arm/mach-spear/time.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
index 26fda4e..a92b1aa 100644
--- a/arch/arm/mach-spear/time.c
+++ b/arch/arm/mach-spear/time.c
@@ -193,7 +193,7 @@ static void __init spear_clockevent_init(int irq)
 	setup_irq(irq, &spear_timer_irq);
 }
 
-const static struct of_device_id timer_of_match[] __initconst = {
+static const struct of_device_id timer_of_match[] __initconst = {
 	{ .compatible = "st,spear-timer", },
 	{ },
 };
-- 
1.7.9.5
