From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 24 Sep 2009 13:13:35 -0400
Subject: [PATCH] ep93xx: define EP93XX_*_PHYS_BASE with macros
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901D42421@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901CBF431@mi8nycmail19.Mi8.com><4AB17678.2030905@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901D42421@mi8nycmail19.Mi8.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901D42577@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ryan,
Are you still ok with this patch?

Regards,
Hartley
 

-----Original Message-----
From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of H Hartley Sweeten
Sent: Wednesday, September 23, 2009 1:20 PM
To: linux-arm-kernel
Cc: Ryan Mallon
Subject: RE: [PATCH] ep93xx: define EP93XX_*_PHYS_BASE with macros

Change the #define's for the EP93XX_*_PHYS_BASE addresses to use
macros for easier readability.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Acked-by: Ryan Mallon <ryan@bluewatersys.com>

--- 

Rebased to 2.6.31-gitcurr now that the ep93xx branch is stable.

diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
index 0fbf87b..7c31a44 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
@@ -52,25 +52,27 @@
 #define EP93XX_AHB_VIRT_BASE		0xfef00000
 #define EP93XX_AHB_SIZE			0x00100000
 
+#define EP93XX_AHB_PHYS(x)		(EP93XX_AHB_PHYS_BASE + (x))
 #define EP93XX_AHB_IOMEM(x)		IOMEM(EP93XX_AHB_VIRT_BASE + (x))
 
 #define EP93XX_APB_PHYS_BASE		0x80800000
 #define EP93XX_APB_VIRT_BASE		0xfed00000
 #define EP93XX_APB_SIZE			0x00200000
 
+#define EP93XX_APB_PHYS(x)		(EP93XX_APB_PHYS_BASE + (x))
 #define EP93XX_APB_IOMEM(x)		IOMEM(EP93XX_APB_VIRT_BASE + (x))
 
 
 /* AHB peripherals */
 #define EP93XX_DMA_BASE			EP93XX_AHB_IOMEM(0x00000000)
 
-#define EP93XX_ETHERNET_PHYS_BASE	(EP93XX_AHB_PHYS_BASE + 0x00010000)
+#define EP93XX_ETHERNET_PHYS_BASE	EP93XX_AHB_PHYS(0x00010000)
 #define EP93XX_ETHERNET_BASE		EP93XX_AHB_IOMEM(0x00010000)
 
-#define EP93XX_USB_PHYS_BASE		(EP93XX_AHB_PHYS_BASE + 0x00020000)
+#define EP93XX_USB_PHYS_BASE		EP93XX_AHB_PHYS(0x00020000)
 #define EP93XX_USB_BASE			EP93XX_AHB_IOMEM(0x00020000)
 
-#define EP93XX_RASTER_PHYS_BASE		(EP93XX_AHB_PHYS_BASE + 0x00030000)
+#define EP93XX_RASTER_PHYS_BASE		EP93XX_AHB_PHYS(0x00030000)
 #define EP93XX_RASTER_BASE		EP93XX_AHB_IOMEM(0x00030000)
 
 #define EP93XX_GRAPHICS_ACCEL_BASE	EP93XX_AHB_IOMEM(0x00040000)
@@ -134,13 +136,13 @@
 
 #define EP93XX_IRDA_BASE		EP93XX_APB_IOMEM(0x000b0000)
 
-#define EP93XX_UART1_PHYS_BASE		(EP93XX_APB_PHYS_BASE + 0x000c0000)
+#define EP93XX_UART1_PHYS_BASE		EP93XX_APB_PHYS(0x000c0000)
 #define EP93XX_UART1_BASE		EP93XX_APB_IOMEM(0x000c0000)
 
-#define EP93XX_UART2_PHYS_BASE		(EP93XX_APB_PHYS_BASE + 0x000d0000)
+#define EP93XX_UART2_PHYS_BASE		EP93XX_APB_PHYS(0x000d0000)
 #define EP93XX_UART2_BASE		EP93XX_APB_IOMEM(0x000d0000)
 
-#define EP93XX_UART3_PHYS_BASE		(EP93XX_APB_PHYS_BASE + 0x000e0000)
+#define EP93XX_UART3_PHYS_BASE		EP93XX_APB_PHYS(0x000e0000)
 #define EP93XX_UART3_BASE		EP93XX_APB_IOMEM(0x000e0000)
 
 #define EP93XX_KEY_MATRIX_BASE		EP93XX_APB_IOMEM(0x000f0000)
@@ -148,10 +150,10 @@
 #define EP93XX_ADC_BASE			EP93XX_APB_IOMEM(0x00100000)
 #define EP93XX_TOUCHSCREEN_BASE		EP93XX_APB_IOMEM(0x00100000)
 
-#define EP93XX_PWM_PHYS_BASE		(EP93XX_APB_PHYS_BASE + 0x00110000)
+#define EP93XX_PWM_PHYS_BASE		EP93XX_APB_PHYS(0x00110000)
 #define EP93XX_PWM_BASE			EP93XX_APB_IOMEM(0x00110000)
 
-#define EP93XX_RTC_PHYS_BASE		(EP93XX_APB_PHYS_BASE + 0x00120000)
+#define EP93XX_RTC_PHYS_BASE		EP93XX_APB_PHYS(0x00120000)
 #define EP93XX_RTC_BASE			EP93XX_APB_IOMEM(0x00120000)
 
 #define EP93XX_SYSCON_BASE		EP93XX_APB_IOMEM(0x00130000) 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
