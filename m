From: tyler.baker@linaro.org (Tyler Baker)
Date: Wed,  1 Apr 2015 16:20:18 -0700
Subject: [PATCH 4/6] selftest/memfd: include default header install path
In-Reply-To: <1427930420-4762-1-git-send-email-tyler.baker@linaro.org>
References: <1427930420-4762-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <1427930420-4762-5-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include the default path for INSTALL_HDR_PATH to make it less intrusive when
cross building.

Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
---
 tools/testing/selftests/memfd/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selftests/memfd/Makefile
index 69f08ab..3e7eb79 100644
--- a/tools/testing/selftests/memfd/Makefile
+++ b/tools/testing/selftests/memfd/Makefile
@@ -2,6 +2,7 @@ CC = $(CROSS_COMPILE)gcc
 CFLAGS += -D_FILE_OFFSET_BITS=64
 CFLAGS += -I../../../../include/uapi/
 CFLAGS += -I../../../../include/
+CFLAGS += -I../../../../usr/include/
 
 all:
 	$(CC) $(CFLAGS) memfd_test.c -o memfd_test
-- 
2.1.4
