From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Tue, 21 Jun 2011 10:58:47 +0900
Subject: [PATCH v2 5/5] Samsung SoC: header file revised to prevent declaring
	duplicated.
In-Reply-To: <1308621527-2457-1-git-send-email-myungjoo.ham@samsung.com>
References: <20110620101737.GA31864@opensource.wolfsonmicro.com>
	<1308621527-2457-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1308621527-2457-6-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There has been no #ifndef - #define - #endif protection for this header
file.

To compile EXYNOS4 with adc support without compiler errors, this patch is essential.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
--
v2: No changes from v1. Resubmitted as a series of patches
---
 arch/arm/plat-samsung/include/plat/devs.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 4af108f..3c87779 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -12,6 +12,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
 */
+#ifndef __PLAT_DEVS_H
+#define __PLAT_DEVS_H __FILE__
+
 #include <linux/platform_device.h>
 
 struct s3c24xx_uart_resources {
@@ -159,3 +162,5 @@ extern struct platform_device s3c_device_ac97;
  */
 extern void *s3c_set_platdata(void *pd, size_t pdsize,
 			      struct platform_device *pdev);
+
+#endif /* __PLAT_DEVS_H */
-- 
1.7.4.1
