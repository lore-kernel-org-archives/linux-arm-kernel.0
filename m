From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jan 2016 13:31:59 +0000
Subject: [PATCH] kbuild: Demote 'sign-compare' warning to W=2
Message-ID: <1452605519-26797-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ideally, a kernel compile with W=1 enabled should complete cleanly;
however, when we run one currently we are presented with ~25k warnings.
'sign-compare' accounts for ~22k of those ~25k.

In this patch we're demoting 'sign-compare' warnings to W=2, with a view
to fixing the remaining 3k W=1 warnings required for a clean build.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 scripts/Makefile.extrawarn | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 4efedcb..f9e47a7 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -25,6 +25,7 @@ warning-1 += -Wold-style-definition
 warning-1 += $(call cc-option, -Wmissing-include-dirs)
 warning-1 += $(call cc-option, -Wunused-but-set-variable)
 warning-1 += $(call cc-disable-warning, missing-field-initializers)
+warning-1 += $(call cc-disable-warning, sign-compare)
 
 warning-2 := -Waggregate-return
 warning-2 += -Wcast-align
@@ -33,6 +34,7 @@ warning-2 += -Wnested-externs
 warning-2 += -Wshadow
 warning-2 += $(call cc-option, -Wlogical-op)
 warning-2 += $(call cc-option, -Wmissing-field-initializers)
+warning-2 += $(call cc-option, -Wsign-compare)
 
 warning-3 := -Wbad-function-cast
 warning-3 += -Wcast-qual
-- 
1.9.1
