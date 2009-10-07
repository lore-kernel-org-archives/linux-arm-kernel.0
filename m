From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 7 Oct 2009 16:21:24 -0400
Subject: [PATCH] ep93xx: remove old EP93XX_GPIO_* defines
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB7AFF@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the EP93XX_GPIO_*_INT_* register defines in ep93xx-regs.h
not required due to how the ep93xx core and gpiolib support handle
gpio interrupts.  Remove the defines to prevent future confusion.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
index b07338c..aae72b8 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
@@ -114,20 +114,8 @@
 
 #define EP93XX_GPIO_BASE		EP93XX_APB_IOMEM(0x00040000)
 #define EP93XX_GPIO_REG(x)		(EP93XX_GPIO_BASE + (x))
-#define EP93XX_GPIO_F_INT_TYPE1		EP93XX_GPIO_REG(0x4c)
-#define EP93XX_GPIO_F_INT_TYPE2		EP93XX_GPIO_REG(0x50)
-#define EP93XX_GPIO_F_INT_ACK		EP93XX_GPIO_REG(0x54)
-#define EP93XX_GPIO_F_INT_ENABLE	EP93XX_GPIO_REG(0x58)
 #define EP93XX_GPIO_F_INT_STATUS	EP93XX_GPIO_REG(0x5c)
-#define EP93XX_GPIO_A_INT_TYPE1		EP93XX_GPIO_REG(0x90)
-#define EP93XX_GPIO_A_INT_TYPE2		EP93XX_GPIO_REG(0x94)
-#define EP93XX_GPIO_A_INT_ACK		EP93XX_GPIO_REG(0x98)
-#define EP93XX_GPIO_A_INT_ENABLE	EP93XX_GPIO_REG(0x9c)
 #define EP93XX_GPIO_A_INT_STATUS	EP93XX_GPIO_REG(0xa0)
-#define EP93XX_GPIO_B_INT_TYPE1		EP93XX_GPIO_REG(0xac)
-#define EP93XX_GPIO_B_INT_TYPE2		EP93XX_GPIO_REG(0xb0)
-#define EP93XX_GPIO_B_INT_ACK		EP93XX_GPIO_REG(0xb4)
-#define EP93XX_GPIO_B_INT_ENABLE	EP93XX_GPIO_REG(0xb8)
 #define EP93XX_GPIO_B_INT_STATUS	EP93XX_GPIO_REG(0xbc)
 
 #define EP93XX_AAC_BASE			EP93XX_APB_IOMEM(0x00080000) 
