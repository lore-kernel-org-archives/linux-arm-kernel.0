From: mike@compulab.co.il (Mike Rapoport)
Date: Mon, 15 Nov 2010 11:48:32 +0200
Subject: [PATCH v4 1/2] [ARM] Dove: add support for GPIOs 64-71
In-Reply-To: <cover.1289814287.git.mike@compulab.co.il>
References: <cover.1289814287.git.mike@compulab.co.il>
Message-ID: <64e20c2e70aa663a4efc9b864a13aa8c7451c6f0.1289814288.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-dove/include/mach/dove.h |    1 +
 arch/arm/mach-dove/include/mach/gpio.h |    6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-dove/include/mach/dove.h b/arch/arm/mach-dove/include/mach/dove.h
index f6a0839..148f4f0 100644
--- a/arch/arm/mach-dove/include/mach/dove.h
+++ b/arch/arm/mach-dove/include/mach/dove.h
@@ -131,6 +131,7 @@
 #define DOVE_RESET_SAMPLE_LO	(DOVE_MPP_VIRT_BASE | 0x014)
 #define DOVE_RESET_SAMPLE_HI	(DOVE_MPP_VIRT_BASE | 0x018)
 #define DOVE_GPIO_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0xd0400)
+#define DOVE_GPIO2_VIRT_BASE    (DOVE_SB_REGS_VIRT_BASE | 0xe8400)
 #define DOVE_MPP_GENERAL_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0xe803c)
 #define  DOVE_AU1_SPDIFO_GPIO_EN	(1 << 1)
 #define  DOVE_NAND_GPIO_EN		(1 << 0)
diff --git a/arch/arm/mach-dove/include/mach/gpio.h b/arch/arm/mach-dove/include/mach/gpio.h
index 0ee70ff..340bb7a 100644
--- a/arch/arm/mach-dove/include/mach/gpio.h
+++ b/arch/arm/mach-dove/include/mach/gpio.h
@@ -14,12 +14,14 @@
 #include <plat/gpio.h>
 #include <asm-generic/gpio.h>		/* cansleep wrappers */
 
-#define GPIO_MAX	64
+#define GPIO_MAX	72
 
 #define GPIO_BASE_LO		(DOVE_GPIO_VIRT_BASE + 0x00)
 #define GPIO_BASE_HI		(DOVE_GPIO_VIRT_BASE + 0x20)
 
-#define GPIO_BASE(pin)		((pin < 32) ? GPIO_BASE_LO : GPIO_BASE_HI)
+#define GPIO_BASE(pin)		((pin < 32) ? GPIO_BASE_LO :		\
+				 ((pin < 64) ? GPIO_BASE_HI :		\
+				  DOVE_GPIO2_VIRT_BASE))
 
 #define GPIO_OUT(pin)		(GPIO_BASE(pin) + 0x00)
 #define GPIO_IO_CONF(pin)	(GPIO_BASE(pin) + 0x04)
-- 
1.7.3.1
