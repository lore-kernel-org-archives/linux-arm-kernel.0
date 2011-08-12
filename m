From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Fri, 12 Aug 2011 15:56:13 +0530
Subject: [PATCH 1/2] ARM: S5PV210: Fix build warning
In-Reply-To: <1313144774-30607-1-git-send-email-a.kesavan@samsung.com>
References: <1313144774-30607-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1313144774-30607-2-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed the following warning for S5PV210.

arch/arm/mach-s5pv210/pm.c: In function 's5pv210_pm_add':
arch/arm/mach-s5pv210/pm.c:139: warning: assignment from incompatible
pointer type

Also, staticized the function.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/mach-s5pv210/pm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pv210/pm.c b/arch/arm/mach-s5pv210/pm.c
index 309e388..f149d27 100644
--- a/arch/arm/mach-s5pv210/pm.c
+++ b/arch/arm/mach-s5pv210/pm.c
@@ -88,7 +88,7 @@ static struct sleep_save s5pv210_core_save[] = {
 	SAVE_ITEM(S3C2410_TCNTO(0)),
 };
 
-void s5pv210_cpu_suspend(unsigned long arg)
+static int s5pv210_cpu_suspend(unsigned long arg)
 {
 	unsigned long tmp;
 
-- 
1.7.4.1
