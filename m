From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  1 Aug 2013 17:26:53 +0900
Subject: [PATCH 11/14] ARM: shmobile: No need to use INTC demux on r8a7740
In-Reply-To: <cover.1375344714.git.horms+renesas@verge.net.au>
References: <cover.1375344714.git.horms+renesas@verge.net.au>
Message-ID: <d76c626d31d5632aa0ee02fc3e99087070cd556e.1375344714.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Now when the r8a7740 code has been converted to make use of
GIC instead of INTC for root interrupt controller it is
possible to exclude the low level INTC demux function
shmobile_handle_irq_intc from linking.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 3c56de8..e3f8592 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -23,7 +23,6 @@ smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o
 
 # IRQ objects
 obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o
-obj-$(CONFIG_ARCH_R8A7740)	+= entry-intc.o
 
 # PM objects
 obj-$(CONFIG_SUSPEND)		+= suspend.o
-- 
1.8.3.2
