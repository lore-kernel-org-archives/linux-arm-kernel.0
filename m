From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 05 Apr 2013 12:16:32 +0200
Subject: [PATCH] omap2+: Remove useless Makefile line
Message-ID: <1365156992.1830.63.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Merge commit 952414505f55afe5cd6dc004765076aa22b3ed7e ("Merge branch
'next/cleanup' of git://git.linaro.org/people/arnd/arm-soc") added
references to CONFIG_MACH_PCM049 and board-omap4pcm049.o to this
Makefile. But there's no Kconfig symbol MACH_PCM049 and there's no file
board-omap4pcm049.c. This line can safely be removed.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Note that MACH_PCM049 was removed from mach-types in v3.5.

 arch/arm/mach-omap2/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 3d0697c..62bb352 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -254,8 +254,6 @@ obj-$(CONFIG_MACH_TOUCHBOOK)		+= board-omap3touchbook.o
 obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o
 obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board-omap4panda.o
 
-obj-$(CONFIG_MACH_PCM049)		+= board-omap4pcm049.o
-
 obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o
 
 obj-$(CONFIG_MACH_CRANEBOARD)		+= board-am3517crane.o
-- 
1.7.11.7
