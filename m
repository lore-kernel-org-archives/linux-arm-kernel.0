From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Thu, 24 Nov 2016 16:10:26 +0000
Subject: [kvm-unit-tests PATCH v7 04/11] libcflat: add PRI(dux)32 format types
In-Reply-To: <20161124161033.11456-1-alex.bennee@linaro.org>
References: <20161124161033.11456-1-alex.bennee@linaro.org>
Message-ID: <20161124161033.11456-5-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So we can have portable formatting of uint32_t types.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
---
 lib/libcflat.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/libcflat.h b/lib/libcflat.h
index bdcc561..6dab5be 100644
--- a/lib/libcflat.h
+++ b/lib/libcflat.h
@@ -55,12 +55,17 @@ typedef _Bool		bool;
 #define true  1
 
 #if __SIZEOF_LONG__ == 8
+#  define __PRI32_PREFIX
 #  define __PRI64_PREFIX	"l"
 #  define __PRIPTR_PREFIX	"l"
 #else
+#  define __PRI32_PREFIX        "l"
 #  define __PRI64_PREFIX	"ll"
 #  define __PRIPTR_PREFIX
 #endif
+#define PRId32  __PRI32_PREFIX	"d"
+#define PRIu32  __PRI32_PREFIX	"u"
+#define PRIx32  __PRI32_PREFIX	"x"
 #define PRId64  __PRI64_PREFIX	"d"
 #define PRIu64  __PRI64_PREFIX	"u"
 #define PRIx64  __PRI64_PREFIX	"x"
-- 
2.10.1
