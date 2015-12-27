From: geliangtang@163.com (Geliang Tang)
Date: Sun, 27 Dec 2015 21:17:36 +0800
Subject: [PATCH 10/10] ARM: plat-samsung: use to_platform_device()
In-Reply-To: <a554e6af3a3528c2206c94dab62b7800f96caa4b.1451221174.git.geliangtang@163.com>
References: <a554e6af3a3528c2206c94dab62b7800f96caa4b.1451221174.git.geliangtang@163.com>
Message-ID: <ad91078d5cbe93341709b249a83ae81c00eaa3d4.1451221174.git.geliangtang@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use to_platform_device() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 arch/arm/plat-samsung/adc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index efa6e85..daf3db9 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -422,8 +422,7 @@ static int s3c_adc_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int s3c_adc_suspend(struct device *dev)
 {
-	struct platform_device *pdev = container_of(dev,
-			struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct adc_device *adc = platform_get_drvdata(pdev);
 	unsigned long flags;
 	u32 con;
@@ -444,8 +443,7 @@ static int s3c_adc_suspend(struct device *dev)
 
 static int s3c_adc_resume(struct device *dev)
 {
-	struct platform_device *pdev = container_of(dev,
-			struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct adc_device *adc = platform_get_drvdata(pdev);
 	enum s3c_cpu_type cpu = platform_get_device_id(pdev)->driver_data;
 	int ret;
-- 
2.5.0
