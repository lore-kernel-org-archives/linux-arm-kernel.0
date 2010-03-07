From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Sun, 07 Mar 2010 21:59:16 +0000
Subject: [PATCH] stargate 2, imote 2: remove spi cs gpio direction to avoid
	clash with driver
Message-ID: <4B9421B4.6000200@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---

 Fix for an issue seen as a failure in gpio allocation within
 pxa2xx_spi.  Not sure when this problem first occured.
 Looks like a bug that has been there a while and for some
 reason has recently gained unfortunate symptoms.

 Patch is against Linus' tree. 

 arch/arm/mach-pxa/imote2.c    |    4 ----
 arch/arm/mach-pxa/stargate2.c |    5 -----
 2 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-pxa/imote2.c b/arch/arm/mach-pxa/imote2.c
index f7f3ba8..f940de0 100644
--- a/arch/arm/mach-pxa/imote2.c
+++ b/arch/arm/mach-pxa/imote2.c
@@ -574,10 +574,6 @@ static void __init imote2_init(void)
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
-	/* SPI chip select directions - all other directions should
-	 * be handled by drivers.*/
-	gpio_direction_output(37, 0);
-
 	platform_add_devices(imote2_devices, ARRAY_SIZE(imote2_devices));
 
 	pxa2xx_set_spi_info(1, &pxa_ssp_master_0_info);
diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index 0c4ec35..f6931a1 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -779,11 +779,6 @@ static void __init stargate2_init(void)
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
-	/* spi chip selects */
-	gpio_direction_output(37, 0);
-	gpio_direction_output(24, 0);
-	gpio_direction_output(39, 0);
-
 	platform_add_devices(ARRAY_AND_SIZE(stargate2_devices));
 
 	pxa2xx_set_spi_info(1, &pxa_ssp_master_0_info);
-- 
1.6.3.3
