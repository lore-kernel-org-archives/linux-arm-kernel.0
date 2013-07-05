From: shuah.kh@samsung.com (Shuah Khan)
Date: Fri,  5 Jul 2013 16:44:57 -0600
Subject: [PATCH] arm: Convert sa1111 platform and bus legacy pm_ops to
 dev_pm_ops
Message-ID: <1373064297-13582-1-git-send-email-shuah.kh@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert arch/arm/common/sa1111 platform and bus legacy pm_ops to dev_pm_ops.
This change also updates the use of COMFIG_PM to CONFIG_PM_SLEEP as this
platform and bus code implements PM_SLEEP ops and not the PM_RUNTIME ops.
Compile tested.

Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
---
 arch/arm/common/sa1111.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 2a64c12..95594f0 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -1321,7 +1321,7 @@ static int sa1111_bus_resume(struct device *dev)
 }
 static SIMPLE_DEV_PM_OPS(sa1111_bus_dev_pm_ops, sa1111_bus_suspend,
 			 sa1111_bus_resume);
-#endif 
+#endif
 
 static void sa1111_bus_shutdown(struct device *dev)
 {
-- 
1.7.10.4
