From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed,  8 Jun 2016 21:26:23 +0900
Subject: [PATCH] arm64: defconfig: enable CONFIG_LOCALVERSION_AUTO
Message-ID: <1465388783-18541-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_LOCALVERSION_AUTO is disabled, the version string is
just a tag name (or with a '+' appended if HEAD is not a tagged
commit).

During the development (and especially when git-bisecting), longer
version string would be helpful to identify the commit we are running.

This is a default y option, so drop the unset to enable it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c8f287f..1e76fc2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1,4 +1,3 @@
-# CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_AUDIT=y
-- 
1.9.1
