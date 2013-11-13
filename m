From: olof@lixom.net (Olof Johansson)
Date: Tue, 12 Nov 2013 23:01:59 -0800
Subject: [PATCH] ARM: Fix warning for V7M builds
Message-ID: <1384326119-3491-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes a harmless warning when building for V7M (!MMU):
 arch/arm/kernel/traps.c:859:123: warning: 'kuser_init' defined but not used [-Wunused-function]

By making the stub static inline instead of just static.

Fixes: f6f91b0d9fd9 ('ARM: allow kuser helpers to be removed from the vector page')
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/kernel/traps.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 6125f25..dbf0923 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -856,7 +856,7 @@ static void __init kuser_init(void *vectors)
 		memcpy(vectors + 0xfe0, vectors + 0xfe8, 4);
 }
 #else
-static void __init kuser_init(void *vectors)
+static inline void __init kuser_init(void *vectors)
 {
 }
 #endif
-- 
1.7.10.4
