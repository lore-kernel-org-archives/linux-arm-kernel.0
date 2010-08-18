From: olof@lixom.net (Olof Johansson)
Date: Wed, 18 Aug 2010 18:26:47 -0500
Subject: [PATCH] arm: tegra: VMALLOC_END should be unsigned long
Message-ID: <20100818232647.GA23694@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Silences following build warning:

arch/arm/mm/init.c: In function 'mem_init':
arch/arm/mm/init.c:644: warning: format '%08lx' expects type 'long
unsigned int', but argument 12 has type 'unsigned int'

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/include/mach/vmalloc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/vmalloc.h b/arch/arm/mach-tegra/include/mach/vmalloc.h
index 267a141..fd6aa65 100644
--- a/arch/arm/mach-tegra/include/mach/vmalloc.h
+++ b/arch/arm/mach-tegra/include/mach/vmalloc.h
@@ -23,6 +23,6 @@
 
 #include <asm/sizes.h>
 
-#define VMALLOC_END        0xFE000000
+#define VMALLOC_END        0xFE000000UL
 
 #endif
-- 
1.5.6.5
