From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 01 Jul 2013 15:01:21 +0900
Subject: [PATCH 02/04] ARM: shmobile: Use default ->init_irq() on r8a73a4
In-Reply-To: <20130701060103.21728.83833.sendpatchset@w520>
References: <20130701060103.21728.83833.sendpatchset@w520>
Message-ID: <20130701060121.21728.18844.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove redundant irqchip_init() callback. The default case
of NULL will result in invoking irqchip_init() anyway.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-ape6evm.c |    2 --
 arch/arm/mach-shmobile/setup-r8a73a4.c |    2 --
 2 files changed, 4 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-ape6evm.c
+++ work/arch/arm/mach-shmobile/board-ape6evm.c	2013-07-01 13:29:37.000000000 +0900
@@ -20,7 +20,6 @@
 
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
-#include <linux/irqchip.h>
 #include <linux/kernel.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
@@ -103,7 +102,6 @@ static const char *ape6evm_boards_compat
 
 DT_MACHINE_START(APE6EVM_DT, "ape6evm")
 	.init_early	= r8a73a4_init_delay,
-	.init_irq	= irqchip_init,
 	.init_time	= shmobile_timer_init,
 	.init_machine	= ape6evm_add_standard_devices,
 	.dt_compat	= ape6evm_boards_compat_dt,
--- 0001/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ work/arch/arm/mach-shmobile/setup-r8a73a4.c	2013-07-01 13:29:53.000000000 +0900
@@ -18,7 +18,6 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 #include <linux/irq.h>
-#include <linux/irqchip.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/irq-renesas-irqc.h>
@@ -224,7 +223,6 @@ static const char *r8a73a4_boards_compat
 
 DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
 	.init_early	= r8a73a4_init_delay,
-	.init_irq	= irqchip_init,
 	.init_machine	= r8a73a4_add_standard_devices_dt,
 	.init_time	= shmobile_timer_init,
 	.dt_compat	= r8a73a4_boards_compat_dt,
