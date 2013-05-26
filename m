From: horms+renesas@verge.net.au (Simon Horman)
Date: Sun, 26 May 2013 22:05:56 +0900
Subject: [PATCH 5/6] ARM: shmobile: r8a73a4: Remove init_irq declaration in
 machine description
In-Reply-To: <1369573557-11071-1-git-send-email-horms+renesas@verge.net.au>
References: <1369573557-11071-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369573557-11071-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
specified") removed the need to explictly setup the init_irq field in
the machine description when using only irqchip_init. Remove that
declaration for shmobile as well.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a73a4.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index c5a75a7..0b78896 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -18,7 +18,6 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 #include <linux/irq.h>
-#include <linux/irqchip.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/irq-renesas-irqc.h>
@@ -194,7 +193,6 @@ static const char *r8a73a4_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
-	.init_irq	= irqchip_init,
 	.init_machine	= r8a73a4_add_standard_devices_dt,
 	.init_time	= shmobile_timer_init,
 	.dt_compat	= r8a73a4_boards_compat_dt,
-- 
1.7.10.4
