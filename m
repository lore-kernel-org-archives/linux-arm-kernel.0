From: stefan.xk.nilsson@stericsson.com (Stefan Nilsson9)
Date: Thu, 23 Sep 2010 19:49:57 +0200
Subject: [PATCH 4/4] Build configuration for U5500 mbox and modem irq handler
In-Reply-To: <1285264197-9316-1-git-send-email-stefan.xk.nilsson@stericsson.com>
References: <1285264197-9316-1-git-send-email-stefan.xk.nilsson@stericsson.com>
Message-ID: <1285264197-9316-5-git-send-email-stefan.xk.nilsson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
---
 arch/arm/mach-ux500/Kconfig  |   14 ++++++++++++++
 arch/arm/mach-ux500/Makefile |    2 ++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 6625e5b..23fe018 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -39,4 +39,18 @@ config UX500_DEBUG_UART
 	  Choose the UART on which kernel low-level debug messages should be
 	  output.
 
+config U5500_MODEM_IRQ
+	bool "Modem IRQ support"
+	depends on MACH_U5500
+	default y
+	help
+	  Add support for handling IRQ:s from modem side
+
+config U5500_MBOX
+	bool "Mailbox support"
+	depends on MACH_U5500 && U5500_MODEM_IRQ
+	default y
+	help
+	  Add support for U5500 mailbox communication with modem side
+
 endif
diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index ed180b8..d28599f 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -10,3 +10,5 @@ obj-$(CONFIG_MACH_U5500)	+= board-u5500.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 obj-$(CONFIG_REGULATOR_AB8500)	+= board-mop500-regulators.o
+obj-$(CONFIG_U5500_MODEM_IRQ)	+= modem_irq.o
+obj-$(CONFIG_U5500_MBOX)	+= mbox.o
-- 
1.7.2.2
