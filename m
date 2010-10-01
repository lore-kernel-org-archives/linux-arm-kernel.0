From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:50 -0700
Subject: [PATCH 26/47] davinci: Add machine checks to DA8XX serial console
	init routines
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-27-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Williamson <michael.williamson@criticallink.com>

This patch adds machine checks in the serial console init routines
for the DA8XX EVM boards.  This is needed because there are other
DA8XX based machines that use a different UART/tty as the console
and may be included in a common kernel build.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da830-evm.c |    3 +++
 arch/arm/mach-davinci/board-da850-evm.c |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index de82739..ef1ab0b 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -598,6 +598,9 @@ static __init void da830_evm_init(void)
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 static int __init da830_evm_console_init(void)
 {
+	if (!machine_is_davinci_da830_evm())
+		return 0;
+
 	return add_preferred_console("ttyS", 2, "115200");
 }
 console_initcall(da830_evm_console_init);
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index c1d45d7..ac2297c 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -859,6 +859,9 @@ static __init void da850_evm_init(void)
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 static int __init da850_evm_console_init(void)
 {
+	if (!machine_is_davinci_da850_evm())
+		return 0;
+
 	return add_preferred_console("ttyS", 2, "115200");
 }
 console_initcall(da850_evm_console_init);
-- 
1.7.2.1
