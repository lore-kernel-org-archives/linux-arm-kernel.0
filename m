From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 17 Jun 2013 10:29:14 -0700
Subject: [PATCHv2 3/3] arm: add DEBUG_SET_MODULE_RONX option to Kconfig
In-Reply-To: <1371490154-11041-1-git-send-email-lauraa@codeaurora.org>
References: <1371490154-11041-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1371490154-11041-4-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all the page setting infrastructure is in place,
Add the DEBUG_SET_MODULE_RONX to the ARM debugging Kconfig.
When turned on, data sections for modules will be marked as NX
and read only sections will be marked as such.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/Kconfig.debug |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 1d41908..12bca63 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -692,4 +692,15 @@ config PID_IN_CONTEXTIDR
 	  additional instructions during context switch. Say Y here only if you
 	  are planning to use hardware trace tools with this kernel.
 
+config DEBUG_SET_MODULE_RONX
+	bool "Set loadable kernel module data as NX and text as RO"
+	depends on MODULES
+	---help---
+	  This option helps catch unintended modifications to loadable
+	  kernel module's text and read-only data. It also prevents execution
+	  of module data. Such protection may interfere with run-time code
+	  patching and dynamic kernel tracing - and they might also protect
+	  against certain classes of kernel exploits.
+	  If in doubt, say "N".
+
 endmenu
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
