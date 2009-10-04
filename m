From: cgagneraud@techworks.ie (Christian Gagneraud)
Date: Sun, 04 Oct 2009 02:14:29 +0100
Subject: [PATCH v1.0 3/4] EP93XX: Add more register definition
In-Reply-To: <20091004011413.12578.89897.stgit@localhost.localdomain>
References: <20091004011413.12578.89897.stgit@localhost.localdomain>
Message-ID: <20091004011429.12578.27177.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add register definition for GPIO A,B,C and D data and data direction,
Security, Chip ID, ...

Signed-off-by: Matthieu Crapet <mcrapet@gmail.com>
Signed-off-by: Christian Gagneraud <cgagneraud@techworks.ie>
---

 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
index c5216fc..a5f721e 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
@@ -111,28 +111,42 @@
 #define EP93XX_I2S_BASE			EP93XX_APB_IOMEM(0x00020000)
 
 #define EP93XX_SECURITY_BASE		EP93XX_APB_IOMEM(0x00030000)
+#define EP93XX_SECURITY_REG(x)		(EP93XX_SECURITY_BASE + (x))
+#define EP93XX_SECURITY_UNIQID		EP93XX_SECURITY_REG(0x2440)
 
 #define EP93XX_GPIO_BASE		EP93XX_APB_IOMEM(0x00040000)
 #define EP93XX_GPIO_REG(x)		(EP93XX_GPIO_BASE + (x))
+#define EP93XX_GPIO_A_DATA		EP93XX_GPIO_REG(0x00)
+#define EP93XX_GPIO_B_DATA		EP93XX_GPIO_REG(0x04)
+#define EP93XX_GPIO_C_DATA		EP93XX_GPIO_REG(0x08)
+#define EP93XX_GPIO_D_DATA		EP93XX_GPIO_REG(0x0C)
+#define EP93XX_GPIO_A_DIR		EP93XX_GPIO_REG(0x10)
+#define EP93XX_GPIO_B_DIR		EP93XX_GPIO_REG(0x14)
+#define EP93XX_GPIO_C_DIR		EP93XX_GPIO_REG(0x18)
+#define EP93XX_GPIO_D_DIR		EP93XX_GPIO_REG(0x1C)
 #define EP93XX_GPIO_F_INT_TYPE1		EP93XX_GPIO_REG(0x4c)
 #define EP93XX_GPIO_F_INT_TYPE2		EP93XX_GPIO_REG(0x50)
 #define EP93XX_GPIO_F_INT_ACK		EP93XX_GPIO_REG(0x54)
 #define EP93XX_GPIO_F_INT_ENABLE	EP93XX_GPIO_REG(0x58)
 #define EP93XX_GPIO_F_INT_STATUS	EP93XX_GPIO_REG(0x5c)
+#define EP93XX_GPIO_F_INT_DEBOUNCE	EP93XX_GPIO_REG(0x64)
 #define EP93XX_GPIO_A_INT_TYPE1		EP93XX_GPIO_REG(0x90)
 #define EP93XX_GPIO_A_INT_TYPE2		EP93XX_GPIO_REG(0x94)
 #define EP93XX_GPIO_A_INT_ACK		EP93XX_GPIO_REG(0x98)
 #define EP93XX_GPIO_A_INT_ENABLE	EP93XX_GPIO_REG(0x9c)
+#define EP93XX_GPIO_A_INT_DEBOUNCE	EP93XX_GPIO_REG(0xa8)
 #define EP93XX_GPIO_A_INT_STATUS	EP93XX_GPIO_REG(0xa0)
 #define EP93XX_GPIO_B_INT_TYPE1		EP93XX_GPIO_REG(0xac)
 #define EP93XX_GPIO_B_INT_TYPE2		EP93XX_GPIO_REG(0xb0)
 #define EP93XX_GPIO_B_INT_ACK		EP93XX_GPIO_REG(0xb4)
 #define EP93XX_GPIO_B_INT_ENABLE	EP93XX_GPIO_REG(0xb8)
 #define EP93XX_GPIO_B_INT_STATUS	EP93XX_GPIO_REG(0xbc)
+#define EP93XX_GPIO_B_INT_DEBOUNCE	EP93XX_GPIO_REG(0xc4)
 #define EP93XX_GPIO_EEDRIVE		EP93XX_GPIO_REG(0xc8)
 
 #define EP93XX_AAC_BASE			EP93XX_APB_IOMEM(0x00080000)
 
+#define EP93XX_SPI_PHYS_BASE		EP93XX_APB_PHYS(0x000a0000)
 #define EP93XX_SPI_BASE			EP93XX_APB_IOMEM(0x000a0000)
 
 #define EP93XX_IRDA_BASE		EP93XX_APB_IOMEM(0x000b0000)
@@ -221,6 +235,7 @@
 #define EP93XX_SYSCON_KEYTCHCLKDIV_ADIV	(1<<16)
 #define EP93XX_SYSCON_KEYTCHCLKDIV_KEN	(1<<15)
 #define EP93XX_SYSCON_KEYTCHCLKDIV_KDIV	(1<<0)
+#define EP93XX_SYSCON_CHIPID		EP93XX_SYSCON_REG(0x94)
 #define EP93XX_SYSCON_SWLOCK		EP93XX_SYSCON_REG(0xc0)
 
 #define EP93XX_WATCHDOG_BASE		EP93XX_APB_IOMEM(0x00140000)
