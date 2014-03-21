From: robherring2@gmail.com (Rob Herring)
Date: Fri, 21 Mar 2014 16:08:41 -0500
Subject: [PATCH 1/8] x86: move FIX_EARLYCON_MEM kconfig into x86
In-Reply-To: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
Message-ID: <1395436128-11244-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

In preparation to support FIX_EARLYCON_MEM on other arches, make the
option per arch.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86 at kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
---
 arch/x86/Kconfig                | 3 +++
 drivers/tty/serial/8250/Kconfig | 5 -----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9c0a657..600046c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -261,6 +261,9 @@ config ARCH_HWEIGHT_CFLAGS
 config ARCH_SUPPORTS_UPROBES
 	def_bool y
 
+config FIX_EARLYCON_MEM
+	def_bool y
+
 source "init/Kconfig"
 source "kernel/Kconfig.freezer"
 
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 2332991..91f1d83 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -90,11 +90,6 @@ config SERIAL_8250_CONSOLE
 
 	  If unsure, say N.
 
-config FIX_EARLYCON_MEM
-	bool
-	depends on X86
-	default y
-
 config SERIAL_8250_GSC
 	tristate
 	depends on SERIAL_8250 && GSC
-- 
1.8.3.2
