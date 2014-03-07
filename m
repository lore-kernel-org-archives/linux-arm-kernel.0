From: dave.long@linaro.org (David Long)
Date: Fri,  7 Mar 2014 15:10:26 -0500
Subject: [PATCH v7 01/15] uprobes: Kconfig dependency fix
In-Reply-To: <1394223040-17129-1-git-send-email-dave.long@linaro.org>
References: <1394223040-17129-1-git-send-email-dave.long@linaro.org>
Message-ID: <1394223040-17129-2-git-send-email-dave.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "David A. Long" <dave.long@linaro.org>

Suggested change from Oleg Nesterov. Fixes incomplete dependencies
for uprobes feature.

Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/Kconfig         | 6 +-----
 kernel/trace/Kconfig | 1 +
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 80bbb8c..97ff872 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -86,9 +86,7 @@ config KPROBES_ON_FTRACE
 	 optimize on top of function tracing.
 
 config UPROBES
-	bool "Transparent user-space probes (EXPERIMENTAL)"
-	depends on UPROBE_EVENT && PERF_EVENTS
-	default n
+	def_bool n
 	select PERCPU_RWSEM
 	help
 	  Uprobes is the user-space counterpart to kprobes: they
@@ -101,8 +99,6 @@ config UPROBES
 	    managed by the kernel and kept transparent to the probed
 	    application. )
 
-	  If in doubt, say "N".
-
 config HAVE_64BIT_ALIGNED_ACCESS
 	def_bool 64BIT && !HAVE_EFFICIENT_UNALIGNED_ACCESS
 	help
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 015f85a..8639819 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -424,6 +424,7 @@ config UPROBE_EVENT
 	bool "Enable uprobes-based dynamic events"
 	depends on ARCH_SUPPORTS_UPROBES
 	depends on MMU
+	depends on PERF_EVENTS
 	select UPROBES
 	select PROBE_EVENTS
 	select TRACING
-- 
1.8.1.2
