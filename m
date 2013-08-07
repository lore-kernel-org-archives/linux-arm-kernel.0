From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:38:34 +0900
Subject: [GIT PULL 17/26] ARM: shmobile: Use clocksource_of_init() on r8a7790
In-Reply-To: <cover.1375840527.git.horms+renesas@verge.net.au>
References: <cover.1375840527.git.horms+renesas@verge.net.au>
Message-ID: <c4a62a5f79f515056d9293ee0e9ce0869a326021.1375840527.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Replace the call to shmobile_timer_init() with
clocksource_of_init(). This will allow us to
get rid of shmobile_timer_init().

Signed-off-by: Magnus Damm <damm@opensource.se>
[horms+renesas at verge.net.au: include linux/clocksource.h]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7790.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 86cf507..6d4aa04 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -18,6 +18,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/clocksource.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
@@ -263,7 +264,7 @@ void __init r8a7790_timer_init(void)
 	iounmap(base);
 #endif /* CONFIG_ARM_ARCH_TIMER */
 
-	shmobile_timer_init();
+	clocksource_of_init();
 }
 
 void __init r8a7790_init_delay(void)
-- 
1.8.3.2
