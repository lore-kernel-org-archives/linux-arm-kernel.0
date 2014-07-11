From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 11 Jul 2014 14:16:00 +0200
Subject: [PATCH 01/12] ARM: tegra: Sort includes alphabetically
In-Reply-To: <1405080971-7609-1-git-send-email-thierry.reding@gmail.com>
References: <1405080971-7609-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1405080971-7609-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

If these aren't sorted alphabetically, then the logical choice is to
append new ones, however that creates a lot of potential for conflicts
because every change will then add new includes in the same location.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/mach-tegra/apbio.c            | 12 ++++++------
 arch/arm/mach-tegra/board-paz00.c      |  3 ++-
 arch/arm/mach-tegra/cpuidle-tegra114.c | 10 +++++-----
 arch/arm/mach-tegra/cpuidle-tegra20.c  | 16 ++++++++--------
 arch/arm/mach-tegra/cpuidle-tegra30.c  | 10 +++++-----
 arch/arm/mach-tegra/flowctrl.c         |  4 ++--
 arch/arm/mach-tegra/fuse.c             |  8 ++++----
 arch/arm/mach-tegra/hotplug.c          |  3 ++-
 arch/arm/mach-tegra/io.c               |  8 ++++----
 arch/arm/mach-tegra/irq.c              |  8 ++++----
 arch/arm/mach-tegra/platsmp.c          | 20 ++++++++++----------
 arch/arm/mach-tegra/pm-tegra20.c       |  1 +
 arch/arm/mach-tegra/pm-tegra30.c       |  1 +
 arch/arm/mach-tegra/pm.c               | 22 +++++++++++-----------
 arch/arm/mach-tegra/pmc.c              |  2 +-
 arch/arm/mach-tegra/powergate.c        |  4 ++--
 arch/arm/mach-tegra/reset-handler.S    |  4 ++--
 arch/arm/mach-tegra/reset.c            |  8 ++++----
 arch/arm/mach-tegra/sleep-tegra30.S    |  6 +++---
 arch/arm/mach-tegra/tegra.c            | 18 +++++++++---------
 arch/arm/mach-tegra/tegra114_speedo.c  |  2 +-
 arch/arm/mach-tegra/tegra20_speedo.c   |  2 +-
 arch/arm/mach-tegra/tegra30_speedo.c   |  2 +-
 23 files changed, 89 insertions(+), 85 deletions(-)

diff --git a/arch/arm/mach-tegra/apbio.c b/arch/arm/mach-tegra/apbio.c
index bc471973cf04..5f9647b3f81d 100644
--- a/arch/arm/mach-tegra/apbio.c
+++ b/arch/arm/mach-tegra/apbio.c
@@ -13,15 +13,15 @@
  *
  */
 
-#include <linux/kernel.h>
-#include <linux/io.h>
-#include <linux/of.h>
+#include <linux/completion.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
-#include <linux/spinlock.h>
-#include <linux/completion.h>
-#include <linux/sched.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
 
 #include "apbio.h"
 #include "iomap.h"
diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 9c6029ba526f..bb4782a32713 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -17,9 +17,10 @@
  *
  */
 
-#include <linux/platform_device.h>
 #include <linux/gpio/driver.h>
+#include <linux/platform_device.h>
 #include <linux/rfkill-gpio.h>
+
 #include "board.h"
 
 static struct rfkill_gpio_platform_data wifi_rfkill_platform_data = {
diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
index b5fb7c110c64..e3ebdce3e71f 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra114.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
@@ -14,16 +14,16 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
+#include <asm/firmware.h>
+#include <linux/clockchips.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
-#include <linux/clockchips.h>
-#include <asm/firmware.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 
 #include <asm/cpuidle.h>
-#include <asm/suspend.h>
 #include <asm/smp_plat.h>
+#include <asm/suspend.h>
 
 #include "pm.h"
 #include "sleep.h"
diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index b82dcaee2ef4..b30bf5cba65b 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -19,23 +19,23 @@
  * more details.
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/clk/tegra.h>
+#include <linux/clockchips.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
-#include <linux/clockchips.h>
-#include <linux/clk/tegra.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 
 #include <asm/cpuidle.h>
 #include <asm/proc-fns.h>
-#include <asm/suspend.h>
 #include <asm/smp_plat.h>
+#include <asm/suspend.h>
 
-#include "pm.h"
-#include "sleep.h"
+#include "flowctrl.h"
 #include "iomap.h"
 #include "irq.h"
-#include "flowctrl.h"
+#include "pm.h"
+#include "sleep.h"
 
 #ifdef CONFIG_PM_SLEEP
 static bool abort_flag;
diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
index ed2a2a7bae4d..35561274f6cf 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -19,17 +19,17 @@
  * more details.
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/clk/tegra.h>
+#include <linux/clockchips.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
-#include <linux/clockchips.h>
-#include <linux/clk/tegra.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 
 #include <asm/cpuidle.h>
 #include <asm/proc-fns.h>
-#include <asm/suspend.h>
 #include <asm/smp_plat.h>
+#include <asm/suspend.h>
 
 #include "pm.h"
 #include "sleep.h"
diff --git a/arch/arm/mach-tegra/flowctrl.c b/arch/arm/mach-tegra/flowctrl.c
index ce8ab8abf061..fde581d78398 100644
--- a/arch/arm/mach-tegra/flowctrl.c
+++ b/arch/arm/mach-tegra/flowctrl.c
@@ -18,10 +18,10 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/cpumask.h>
 #include <linux/init.h>
-#include <linux/kernel.h>
 #include <linux/io.h>
-#include <linux/cpumask.h>
+#include <linux/kernel.h>
 
 #include "flowctrl.h"
 #include "iomap.h"
diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c
index c9ac23b385be..573414eaf7ae 100644
--- a/arch/arm/mach-tegra/fuse.c
+++ b/arch/arm/mach-tegra/fuse.c
@@ -18,16 +18,16 @@
  *
  */
 
-#include <linux/kernel.h>
-#include <linux/io.h>
+#include <linux/clk.h>
 #include <linux/export.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
 #include <linux/random.h>
-#include <linux/clk.h>
 #include <linux/tegra-soc.h>
 
+#include "apbio.h"
 #include "fuse.h"
 #include "iomap.h"
-#include "apbio.h"
 
 /* Tegra20 only */
 #define FUSE_UID_LOW		0x108
diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
index ff26af26bd0c..7842b252dda5 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -7,9 +7,10 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+
+#include <linux/clk/tegra.h>
 #include <linux/kernel.h>
 #include <linux/smp.h>
-#include <linux/clk/tegra.h>
 
 #include <asm/smp_plat.h>
 
diff --git a/arch/arm/mach-tegra/io.c b/arch/arm/mach-tegra/io.c
index bb9c9c29d181..352de159d2c5 100644
--- a/arch/arm/mach-tegra/io.c
+++ b/arch/arm/mach-tegra/io.c
@@ -18,14 +18,14 @@
  *
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/init.h>
-#include <linux/mm.h>
 #include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/module.h>
 
-#include <asm/page.h>
 #include <asm/mach/map.h>
+#include <asm/page.h>
 
 #include "board.h"
 #include "iomap.h"
diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index 1a74d562dca1..da7be13aecce 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -17,14 +17,14 @@
  *
  */
 
-#include <linux/kernel.h>
 #include <linux/cpu_pm.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/irqchip/arm-gic.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/of_address.h>
+#include <linux/of.h>
 #include <linux/syscore_ops.h>
 
 #include "board.h"
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 929d1046e2b4..c403edd0fcc7 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -11,27 +11,27 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/init.h>
-#include <linux/errno.h>
+
+#include <linux/clk/tegra.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/io.h>
 #include <linux/jiffies.h>
 #include <linux/smp.h>
-#include <linux/io.h>
-#include <linux/clk/tegra.h>
 
 #include <asm/cacheflush.h>
 #include <asm/mach-types.h>
-#include <asm/smp_scu.h>
 #include <asm/smp_plat.h>
-
-#include "fuse.h"
-#include "flowctrl.h"
-#include "reset.h"
-#include "pmc.h"
+#include <asm/smp_scu.h>
 
 #include "common.h"
+#include "flowctrl.h"
+#include "fuse.h"
 #include "iomap.h"
+#include "pmc.h"
+#include "reset.h"
 
 static cpumask_t tegra_cpu_init_mask;
 
diff --git a/arch/arm/mach-tegra/pm-tegra20.c b/arch/arm/mach-tegra/pm-tegra20.c
index d65e1d786400..39ac2b723f2e 100644
--- a/arch/arm/mach-tegra/pm-tegra20.c
+++ b/arch/arm/mach-tegra/pm-tegra20.c
@@ -13,6 +13,7 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+
 #include <linux/kernel.h>
 
 #include "pm.h"
diff --git a/arch/arm/mach-tegra/pm-tegra30.c b/arch/arm/mach-tegra/pm-tegra30.c
index 8fa326d6ff1a..46cc19de9916 100644
--- a/arch/arm/mach-tegra/pm-tegra30.c
+++ b/arch/arm/mach-tegra/pm-tegra30.c
@@ -13,6 +13,7 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+
 #include <linux/kernel.h>
 
 #include "pm.h"
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index f55b05a29b55..ae4826e43171 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -16,30 +16,30 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include <linux/kernel.h>
-#include <linux/spinlock.h>
-#include <linux/io.h>
+#include <linux/clk/tegra.h>
 #include <linux/cpumask.h>
-#include <linux/delay.h>
 #include <linux/cpu_pm.h>
-#include <linux/suspend.h>
+#include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
 #include <linux/slab.h>
-#include <linux/clk/tegra.h>
+#include <linux/spinlock.h>
+#include <linux/suspend.h>
 
-#include <asm/smp_plat.h>
 #include <asm/cacheflush.h>
-#include <asm/suspend.h>
 #include <asm/idmap.h>
 #include <asm/proc-fns.h>
+#include <asm/smp_plat.h>
+#include <asm/suspend.h>
 #include <asm/tlbflush.h>
 
-#include "iomap.h"
-#include "reset.h"
 #include "flowctrl.h"
 #include "fuse.h"
-#include "pm.h"
+#include "iomap.h"
 #include "pmc.h"
+#include "pm.h"
+#include "reset.h"
 #include "sleep.h"
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index 7c7123e7557b..cff318c17f2c 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -15,9 +15,9 @@
  *
  */
 
-#include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/tegra-powergate.h>
diff --git a/arch/arm/mach-tegra/powergate.c b/arch/arm/mach-tegra/powergate.c
index 4cefc5cd6bed..bbffc9e6d498 100644
--- a/arch/arm/mach-tegra/powergate.c
+++ b/arch/arm/mach-tegra/powergate.c
@@ -17,18 +17,18 @@
  *
  */
 
-#include <linux/kernel.h>
 #include <linux/clk.h>
+#include <linux/clk/tegra.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/kernel.h>
 #include <linux/reset.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
-#include <linux/clk/tegra.h>
 #include <linux/tegra-powergate.h>
 
 #include "fuse.h"
diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 578d4d1ad648..d916c84487ae 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -14,11 +14,11 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include <linux/linkage.h>
 #include <linux/init.h>
+#include <linux/linkage.h>
 
-#include <asm/cache.h>
 #include <asm/asm-offsets.h>
+#include <asm/cache.h>
 
 #include "flowctrl.h"
 #include "fuse.h"
diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
index 146fe8e0ae7c..b90507922a8c 100644
--- a/arch/arm/mach-tegra/reset.c
+++ b/arch/arm/mach-tegra/reset.c
@@ -14,20 +14,20 @@
  *
  */
 
+#include <linux/bitops.h>
+#include <linux/cpumask.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/cpumask.h>
-#include <linux/bitops.h>
 
 #include <asm/cacheflush.h>
-#include <asm/hardware/cache-l2x0.h>
 #include <asm/firmware.h>
+#include <asm/hardware/cache-l2x0.h>
 
+#include "fuse.h"
 #include "iomap.h"
 #include "irammap.h"
 #include "reset.h"
 #include "sleep.h"
-#include "fuse.h"
 
 #define TEGRA_IRAM_RESET_BASE (TEGRA_IRAM_BASE + \
 				TEGRA_IRAM_RESET_HANDLER_OFFSET)
diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index b16d4a57fa59..e240b875183b 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -16,14 +16,14 @@
 
 #include <linux/linkage.h>
 
-#include <asm/assembler.h>
 #include <asm/asm-offsets.h>
+#include <asm/assembler.h>
 #include <asm/cache.h>
 
-#include "irammap.h"
+#include "flowctrl.h"
 #include "fuse.h"
+#include "irammap.h"
 #include "sleep.h"
-#include "flowctrl.h"
 
 #define EMC_CFG				0xc
 #define EMC_ADR_CFG			0x10
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 15ac9fcc96b1..7a9f30289049 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -16,29 +16,29 @@
  *
  */
 
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/serial_8250.h>
 #include <linux/clk.h>
+#include <linux/clk/tegra.h>
 #include <linux/dma-mapping.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/irqchip.h>
 #include <linux/irqdomain.h>
-#include <linux/of.h>
+#include <linux/kernel.h>
 #include <linux/of_address.h>
 #include <linux/of_fdt.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/pda_power.h>
-#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/serial_8250.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 #include <linux/usb/tegra_usb_phy.h>
-#include <linux/clk/tegra.h>
-#include <linux/irqchip.h>
 
 #include <asm/hardware/cache-l2x0.h>
-#include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
+#include <asm/mach-types.h>
 #include <asm/setup.h>
 #include <asm/trusted_foundations.h>
 
diff --git a/arch/arm/mach-tegra/tegra114_speedo.c b/arch/arm/mach-tegra/tegra114_speedo.c
index 5218d4853cd3..86eca17e5286 100644
--- a/arch/arm/mach-tegra/tegra114_speedo.c
+++ b/arch/arm/mach-tegra/tegra114_speedo.c
@@ -14,8 +14,8 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include <linux/kernel.h>
 #include <linux/bug.h>
+#include <linux/kernel.h>
 
 #include "fuse.h"
 
diff --git a/arch/arm/mach-tegra/tegra20_speedo.c b/arch/arm/mach-tegra/tegra20_speedo.c
index fa6eb570623f..dcd29a0b0187 100644
--- a/arch/arm/mach-tegra/tegra20_speedo.c
+++ b/arch/arm/mach-tegra/tegra20_speedo.c
@@ -14,8 +14,8 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include <linux/kernel.h>
 #include <linux/bug.h>
+#include <linux/kernel.h>
 
 #include "fuse.h"
 
diff --git a/arch/arm/mach-tegra/tegra30_speedo.c b/arch/arm/mach-tegra/tegra30_speedo.c
index 125cb16424a6..7c0038326cf5 100644
--- a/arch/arm/mach-tegra/tegra30_speedo.c
+++ b/arch/arm/mach-tegra/tegra30_speedo.c
@@ -14,8 +14,8 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include <linux/kernel.h>
 #include <linux/bug.h>
+#include <linux/kernel.h>
 
 #include "fuse.h"
 
-- 
2.0.1
