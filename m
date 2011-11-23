From: axel.lin@gmail.com (Axel Lin)
Date: Wed, 23 Nov 2011 19:04:44 +0800
Subject: [PATCH] ARM: tegra: remove declaration of tegra_assert_system_reset
 in board.h
Message-ID: <1322046284.27165.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit b2f745 "ARM: restart: tegra: use new restart hook"
changed tegra_assert_system_reset to be static but forgot to
remove the declaration in arch/arm/mach-tegra/board.h.

Remove the declaration of tegra_assert_system_reset in
arch/arm/mach-tegra/board.h to fix below build error:

  CC      arch/arm/mach-tegra/common.o
arch/arm/mach-tegra/common.c:34: error: static declaration of 'tegra_assert_system_reset' follows non-static declaration
arch/arm/mach-tegra/board.h:26: note: previous declaration of 'tegra_assert_system_reset' was here
make[1]: *** [arch/arm/mach-tegra/common.o] Error 1
make: *** [arch/arm/mach-tegra] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
I got the build error on linux-next tree.
This patch is against linux-next 20111123.

 arch/arm/mach-tegra/board.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/board.h b/arch/arm/mach-tegra/board.h
index 1d14df7..f159577 100644
--- a/arch/arm/mach-tegra/board.h
+++ b/arch/arm/mach-tegra/board.h
@@ -23,8 +23,6 @@
 
 #include <linux/types.h>
 
-void tegra_assert_system_reset(char mode, const char *cmd);
-
 void __init tegra_init_early(void);
 void __init tegra_map_common_io(void);
 void __init tegra_init_irq(void);
-- 
1.7.5.4
