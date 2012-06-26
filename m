From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 26 Jun 2012 18:55:41 -0400
Subject: [PATCH] ARM: sa1100: fix build failure on missing IOMEM
Message-ID: <1340751341-5248-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduced by commit 6686732c8b8974fafbdd7886de0fcf77cf34ec07 [linux-next]

    "ARM: sa11x0/pxa: convert OS timer registers to IOMEM"

which causes:

arch/arm/mach-sa1100/cpu-sa1100.c:153:3: error: implicit declaration of function 'IOMEM'

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

Feel free to squash into original if rebasing.
Fixes http://kisskb.ellerman.id.au/kisskb/buildresult/6545966/

 arch/arm/mach-sa1100/cpu-sa1100.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-sa1100/cpu-sa1100.c b/arch/arm/mach-sa1100/cpu-sa1100.c
index 19b2053..829c6f1 100644
--- a/arch/arm/mach-sa1100/cpu-sa1100.c
+++ b/arch/arm/mach-sa1100/cpu-sa1100.c
@@ -86,6 +86,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/cpufreq.h>
 
 #include <asm/cputype.h>
-- 
1.7.9.1
