From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 14 May 2013 17:38:52 +0200
Subject: [PATCH 19/20] ARM: virt: Remove init_irq declaration in machine
 description
In-Reply-To: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1368545933-7430-20-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
specified") removed the need to explictly setup the init_irq field in
the machine description when using only irqchip_init. Remove that
declaration for virt as well.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-virt/virt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-virt/virt.c b/arch/arm/mach-virt/virt.c
index 061f283..bdf05f4 100644
--- a/arch/arm/mach-virt/virt.c
+++ b/arch/arm/mach-virt/virt.c
@@ -18,7 +18,6 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include <linux/irqchip.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/smp.h>
@@ -39,7 +38,6 @@ static const char *virt_dt_match[] = {
 extern struct smp_operations virt_smp_ops;
 
 DT_MACHINE_START(VIRT, "Dummy Virtual Machine")
-	.init_irq	= irqchip_init,
 	.init_machine	= virt_init,
 	.smp		= smp_ops(virt_smp_ops),
 	.dt_compat	= virt_dt_match,
-- 
1.8.1.2
