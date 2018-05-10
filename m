From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Thu, 10 May 2018 12:37:17 +0200
Subject: [PATCH] CNS3xxx: Cosmetic: Fix misc register usage
Message-ID: <m336yzu78i.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>

--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -395,7 +395,7 @@ static void __init cns3xxx_init(void)
 
 	dn = of_find_compatible_node(NULL, NULL, "cavium,cns3420-sdhci");
 	if (of_device_is_available(dn)) {
-		u32 __iomem *gpioa = IOMEM(CNS3XXX_MISC_BASE_VIRT + 0x0014);
+		u32 __iomem *gpioa = IOMEM(MISC_GPIOA_PIN_ENABLE_REG);
 		u32 gpioa_pins = __raw_readl(gpioa);
 	
 		/* MMC/SD pins share with GPIOA */
diff --git a/arch/arm/mach-cns3xxx/devices.c b/arch/arm/mach-cns3xxx/devices.c
index 7da78a2451f1..daafbe764a96 100644
--- a/arch/arm/mach-cns3xxx/devices.c
+++ b/arch/arm/mach-cns3xxx/devices.c
@@ -97,7 +97,7 @@ static struct platform_device cns3xxx_sdhci_pdev = {
 
 void __init cns3xxx_sdhci_init(void)
 {
-	u32 __iomem *gpioa = IOMEM(CNS3XXX_MISC_BASE_VIRT + 0x0014);
+	u32 __iomem *gpioa = IOMEM(MISC_GPIOA_PIN_ENABLE_REG);
 	u32 gpioa_pins = __raw_readl(gpioa);
 
 	/* MMC/SD pins share with GPIOA */

-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
