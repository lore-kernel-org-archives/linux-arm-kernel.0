From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  1 Aug 2013 17:26:52 +0900
Subject: [PATCH 10/14] ARM: shmobile: Use pm-rmobile on sh7372 and r8a7740 only
In-Reply-To: <cover.1375344714.git.horms+renesas@verge.net.au>
References: <cover.1375344714.git.horms+renesas@verge.net.au>
Message-ID: <0173a741e19e072ae34fda4a32d004e52c9da8e7.1375344714.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The functions in pm-rmobile.c are only used on sh7372 and
r8a7740, so adjust the Makefile to only link in that file
in case those SoCs are selected.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Makefile | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 62574c1..3c56de8 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -28,11 +28,10 @@ obj-$(CONFIG_ARCH_R8A7740)	+= entry-intc.o
 # PM objects
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
-obj-$(CONFIG_ARCH_SHMOBILE)	+= pm-rmobile.o
-obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o sleep-sh7372.o
-obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o
-obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o
+obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o sleep-sh7372.o pm-rmobile.o
 obj-$(CONFIG_ARCH_SH73A0)	+= pm-sh73a0.o
+obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o pm-rmobile.o
+obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o
 
 # Board objects
 obj-$(CONFIG_MACH_APE6EVM)	+= board-ape6evm.o
-- 
1.8.3.2
