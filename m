From: tyler.baker@linaro.org (Tyler Baker)
Date: Mon, 20 Apr 2015 16:16:19 -0700
Subject: [PATCH v3 8/8] selftests/exec: do not install subdir as it is already
 created
Message-ID: <1429571779-28293-1-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove subdir from DEPS as it is already created at runtime. Without this,
make install fails.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
---
 tools/testing/selftests/exec/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 4edb7d0..6b76bfd 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -1,6 +1,6 @@
 CFLAGS = -Wall
 BINARIES = execveat
-DEPS = execveat.symlink execveat.denatured script subdir
+DEPS = execveat.symlink execveat.denatured script
 all: $(BINARIES) $(DEPS)
 
 subdir:
-- 
2.1.4
