From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri,  7 Sep 2012 17:26:59 +0100
Subject: [PATCH v3 24/31] arm64: Add support for
 /proc/sys/debug/exception-trace
In-Reply-To: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1347035226-18649-25-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows setting of the show_unhandled_signals variable via
/proc/sys/debug/exception-trace. The default value is currently 1
showing unhandled user faults (undefined instructions, data aborts) and
invalid signal stack frames.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/sysctl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 87174ef..79dcb00 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1544,7 +1544,7 @@ static struct ctl_table fs_table[] = {
 
 static struct ctl_table debug_table[] = {
 #if defined(CONFIG_X86) || defined(CONFIG_PPC) || defined(CONFIG_SPARC) || \
-    defined(CONFIG_S390) || defined(CONFIG_TILE)
+    defined(CONFIG_S390) || defined(CONFIG_TILE) || defined(CONFIG_ARM64)
 	{
 		.procname	= "exception-trace",
 		.data		= &show_unhandled_signals,
