From: tyler.baker@linaro.org (Tyler Baker)
Date: Tue, 14 Apr 2015 15:51:09 -0700
Subject: [PATCH 1/7] selftests: copy TEST_DIRS to INSTALL_PATH
Message-ID: <1429051869-14599-1-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Loop over all TEST_DIRS and recursively copy them to the INSTALL_PATH. Tests
such as ftrace require a directory and all of it's contents to execute the
test properly, thus these directories and files need to be copied when we
perform an install.

Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
---
 tools/testing/selftests/lib.mk | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 2194155..ee412ba 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -13,6 +13,9 @@ run_tests: all
 
 define INSTALL_RULE
 	mkdir -p $(INSTALL_PATH)
+	@for TEST_DIR in $(TEST_DIRS); do\
+		cp -r $$TEST_DIR $(INSTALL_PATH); \
+	done;
 	install -t $(INSTALL_PATH) $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)
 endef
 
-- 
2.1.0
