From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed,  4 Jan 2017 17:55:26 +0900
Subject: [PATCH 2/3] linux/const.h: refactor _BITUL and _BITULL a bit
In-Reply-To: <1483520127-29316-1-git-send-email-yamada.masahiro@socionext.com>
References: <1483520127-29316-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1483520127-29316-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minor cleanups available by _UL and _ULL.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

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
