From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 11 Jun 2014 11:44:21 +0200
Subject: [PATCH] [linux-next] arm64: ftrace: Fix comment typo
 'CONFIG_FUNCTION_GRAPH_FP_TEST'
Message-ID: <1402479861.3798.63.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

This typo was added in next-20140603. I've had this patch queued for
over a week because I wanted to understand the comment I'm touching
here. I still don't. But I figured that making sure that this comment
uses the Kconfig macro that apparently was intended, ought to be enough
to submit this.

 arch/arm64/kernel/entry-ftrace.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index b051871f2965..aa5f9fcbf9ee 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -205,7 +205,7 @@ ENDPROC(ftrace_graph_caller)
  *
  * Run ftrace_return_to_handler() before going back to parent.
  * @fp is checked against the value passed by ftrace_graph_caller()
- * only when CONFIG_FUNCTION_GRAPH_FP_TEST is enabled.
+ * only when CONFIG_HAVE_FUNCTION_GRAPH_FP_TEST is enabled.
  */
 ENTRY(return_to_handler)
 	str	x0, [sp, #-16]!
-- 
1.9.3
