From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 20 Nov 2009 13:04:08 +0100
Subject: [PATCH 5/8] S3C64xx: fix USB OTG compilation
Message-ID: <b2e8f9f70911200404u61f42858h6651995113935528@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the S3C_VA_USB_HSPHY mapping.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/mach-s3c6400/include/mach/map.h |    4 ++++
 arch/arm/plat-s3c64xx/cpu.c              |    5 +++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6400/include/mach/map.h
b/arch/arm/mach-s3c6400/include/mach/map.h
index fc8b223..f3b48f8 100644
--- a/arch/arm/mach-s3c6400/include/mach/map.h
+++ b/arch/arm/mach-s3c6400/include/mach/map.h
@@ -64,6 +64,9 @@

 #define S3C64XX_PA_USBHOST	(0x74300000)

+#define S3C64XX_PA_USB_HSPHY	(0x7C100000)
+#define S3C64XX_VA_USB_HSPHY	S3C_ADDR_CPU(0x00200000)
+
 /* place VICs close together */
 #define S3C_VA_VIC0		(S3C_VA_IRQ + 0x00)
 #define S3C_VA_VIC1		(S3C_VA_IRQ + 0x10000)
@@ -79,5 +82,6 @@
 #define S3C_PA_FB		S3C64XX_PA_FB
 #define S3C_PA_USBHOST		S3C64XX_PA_USBHOST
 #define S3C_PA_USB_HSOTG	S3C64XX_PA_USB_HSOTG
+#define S3C_VA_USB_HSPHY	S3C64XX_VA_USB_HSPHY

 #endif /* __ASM_ARCH_6400_MAP_H */
diff --git a/arch/arm/plat-s3c64xx/cpu.c b/arch/arm/plat-s3c64xx/cpu.c
index b1fdd83..49796d2 100644
--- a/arch/arm/plat-s3c64xx/cpu.c
+++ b/arch/arm/plat-s3c64xx/cpu.c
@@ -107,6 +107,11 @@ static struct map_desc s3c_iodesc[] __initdata = {
 		.pfn		= __phys_to_pfn(S3C64XX_PA_WATCHDOG),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_USB_HSPHY,
+		.pfn		= __phys_to_pfn(S3C64XX_PA_USB_HSPHY),
+		.length		= SZ_1K,
+		.type		= MT_DEVICE,
 	},
 };

-- 
1.6.5.3
