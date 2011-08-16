From: axel.lin@gmail.com (Axel Lin)
Date: Tue, 16 Aug 2011 13:25:05 +0800
Subject: [PATCH RESEND] ARM: tegra: Add missing include of linux/errno.h
	and linux/types.h
Message-ID: <1313472305.15815.2.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include linux/errno.h to fix below build error.

  CC      arch/arm/mach-tegra/board-harmony-pinmux.o
In file included from /home/axel/repos/git/linux-2.6/arch/arm/include/asm/gpio.h:5,
                 from include/linux/gpio.h:18,
                 from arch/arm/mach-tegra/board-harmony-pinmux.c:18:
arch/arm/mach-tegra/include/mach/gpio.h: In function 'gpio_to_irq':
arch/arm/mach-tegra/include/mach/gpio.h:35: error: 'EINVAL' undeclared (first use in this function)
arch/arm/mach-tegra/include/mach/gpio.h:35: error: (Each undeclared identifier is reported only once
arch/arm/mach-tegra/include/mach/gpio.h:35: error: for each function it appears in.)
arch/arm/mach-tegra/include/mach/gpio.h: In function 'irq_to_gpio':
arch/arm/mach-tegra/include/mach/gpio.h:43: error: 'EINVAL' undeclared (first use in this function)
make[1]: *** [arch/arm/mach-tegra/board-harmony-pinmux.o] Error 1
make: *** [arch/arm/mach-tegra] Error 2

Include linux/types.h to fix below build error.

  CC      arch/arm/mach-tegra/board-trimslice-pinmux.o
In file included from /home/axel/repos/git/linux-2.6/arch/arm/include/asm/gpio.h:5,
                 from include/linux/gpio.h:18,
                 from arch/arm/mach-tegra/board-trimslice-pinmux.c:16:
arch/arm/mach-tegra/include/mach/gpio.h:49: error: expected specifier-qualifier-list before 'bool'
arch/arm/mach-tegra/board-trimslice-pinmux.c:145: error: unknown field 'enable' specified in initializer
arch/arm/mach-tegra/board-trimslice-pinmux.c:145: warning: excess elements in struct initializer
arch/arm/mach-tegra/board-trimslice-pinmux.c:145: warning: (near initialization for 'gpio_table[0]')
arch/arm/mach-tegra/board-trimslice-pinmux.c:146: error: unknown field 'enable' specified in initializer
arch/arm/mach-tegra/board-trimslice-pinmux.c:146: warning: excess elements in struct initializer
arch/arm/mach-tegra/board-trimslice-pinmux.c:146: warning: (near initialization for 'gpio_table[1]')
arch/arm/mach-tegra/board-trimslice-pinmux.c:148: error: unknown field 'enable' specified in initializer
arch/arm/mach-tegra/board-trimslice-pinmux.c:148: warning: excess elements in struct initializer
arch/arm/mach-tegra/board-trimslice-pinmux.c:148: warning: (near initialization for 'gpio_table[2]')
arch/arm/mach-tegra/board-trimslice-pinmux.c:149: error: unknown field 'enable' specified in initializer
arch/arm/mach-tegra/board-trimslice-pinmux.c:149: warning: excess elements in struct initializer
arch/arm/mach-tegra/board-trimslice-pinmux.c:149: warning: (near initialization for 'gpio_table[3]')
make[1]: *** [arch/arm/mach-tegra/board-trimslice-pinmux.o] Error 1
make: *** [arch/arm/mach-tegra] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
This patch is against linux-next (next-20110815), it fixes the build error with "make tegra_defconfig".
This RESEND fixes the typo in subject line and commit log pointed out by Baruch.
Axel

 arch/arm/mach-tegra/include/mach/gpio.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/gpio.h b/arch/arm/mach-tegra/include/mach/gpio.h
index e353805..42f3f08 100644
--- a/arch/arm/mach-tegra/include/mach/gpio.h
+++ b/arch/arm/mach-tegra/include/mach/gpio.h
@@ -21,6 +21,8 @@
 #define __MACH_TEGRA_GPIO_H
 
 #include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/types.h>
 #include <mach/irqs.h>
 
 #define TEGRA_NR_GPIOS		INT_GPIO_NR
-- 
1.7.4.1
