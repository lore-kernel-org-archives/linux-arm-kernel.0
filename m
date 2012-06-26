From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 26 Jun 2012 19:13:29 -0400
Subject: [PATCH] ARM: sa1100: fix jornada720 build failure on missing IOMEM
Message-ID: <1340752409-11413-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduced by commit 6686732c8b8974fafbdd7886de0fcf77cf34ec07 [linux-next]

    "ARM: sa11x0/pxa: convert OS timer registers to IOMEM"

which causes:

arch/arm/mach-sa1100/jornada720_ssp.c:63:2: error: implicit declaration of function 'IOMEM'

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

Feel free to squash into original if rebasing.
Fixes http://kisskb.ellerman.id.au/kisskb/buildresult/6592200/

 arch/arm/mach-sa1100/jornada720_ssp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-sa1100/jornada720_ssp.c b/arch/arm/mach-sa1100/jornada720_ssp.c
index b412fc0..ee13507 100644
--- a/arch/arm/mach-sa1100/jornada720_ssp.c
+++ b/arch/arm/mach-sa1100/jornada720_ssp.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-- 
1.7.9.1
