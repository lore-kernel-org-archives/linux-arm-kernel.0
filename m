From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Wed, 16 Sep 2009 17:19:25 +0900
Subject: [PATCH 2/3] ARM: SMDKC100: add dma platform devices
Message-ID: <4AB09F8D.5070005@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds three dma platform devices for s5pc1xx dma on smdkc100
board file.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 arch/arm/mach-s5pc100/mach-smdkc100.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index 214093c..7771a6f 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -76,6 +76,9 @@ static struct s3c2410_uartcfg smdkc100_uartcfgs[] __initdata = {
 static struct map_desc smdkc100_iodesc[] = {};
 
 static struct platform_device *smdkc100_devices[] __initdata = {
+	&s5pc1xx_device_mdma,
+	&s5pc1xx_device_pdma0,
+	&s5pc1xx_device_pdma1,
 };
 
 static void __init smdkc100_map_io(void)
-- 
1.6.0.4
