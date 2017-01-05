From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu,  5 Jan 2017 11:20:08 +0900
Subject: [PATCH v2 3/4] linux/const.h: refactor _BITUL and _BITULL a bit
In-Reply-To: <1483582810-7046-1-git-send-email-yamada.masahiro@socionext.com>
References: <1483582810-7046-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1483582810-7046-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minor cleanups available by _UL and _ULL.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 include/uapi/linux/const.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
index 76fb0f9..13e5165 100644
--- a/include/uapi/linux/const.h
+++ b/include/uapi/linux/const.h
@@ -24,7 +24,7 @@
 #define _UL(x)		(_AC(x, UL))
 #define _ULL(x)		(_AC(x, ULL))
 
-#define _BITUL(x)	(_AC(1,UL) << (x))
-#define _BITULL(x)	(_AC(1,ULL) << (x))
+#define _BITUL(x)	(_UL(1) << (x))
+#define _BITULL(x)	(_ULL(1) << (x))
 
 #endif /* _UAPI_LINUX_CONST_H */
-- 
2.7.4
