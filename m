From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Jun 2016 12:50:00 +0200
Subject: [PATCH 5/6] ARM: imx: remove last call to cpu_is_mx5*
In-Reply-To: <20160624105001.3166287-1-arnd@arndb.de>
References: <20160624105001.3166287-1-arnd@arndb.de>
Message-ID: <20160624105001.3166287-6-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The check for cpu_is_mx51/cpu_is_mx53() in mx51_revision()/mx53_revision()
is just a safety precaution, but there are only two callers of this
are using it only on the correct CPUs, and none of the other respective
functions have this extra check.

Removing these lets us kill off the cpu_is_* functions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/cpu-imx5.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-imx/cpu-imx5.c b/arch/arm/mach-imx/cpu-imx5.c
index 3403bac94a31..4f2d1c772f85 100644
--- a/arch/arm/mach-imx/cpu-imx5.c
+++ b/arch/arm/mach-imx/cpu-imx5.c
@@ -60,13 +60,9 @@ static int get_mx51_srev(void)
 /*
  * Returns:
  *	the silicon revision of the cpu
- *	-EINVAL - not a mx51
  */
 int mx51_revision(void)
 {
-	if (!cpu_is_mx51())
-		return -EINVAL;
-
 	if (mx5_cpu_rev == -1)
 		mx5_cpu_rev = get_mx51_srev();
 
@@ -112,13 +108,9 @@ static int get_mx53_srev(void)
 /*
  * Returns:
  *	the silicon revision of the cpu
- *	-EINVAL - not a mx53
  */
 int mx53_revision(void)
 {
-	if (!cpu_is_mx53())
-		return -EINVAL;
-
 	if (mx5_cpu_rev == -1)
 		mx5_cpu_rev = get_mx53_srev();
 
-- 
2.9.0
