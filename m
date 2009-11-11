From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Wed, 11 Nov 2009 18:27:14 +0100
Subject: [PATCH] s3c64xx: Fix USB HSOTG compilation
In-Reply-To: <b2e8f9f70911110923u7b350be5p153297453f8cb2dd@mail.gmail.com>
References: <b2e8f9f70911110923u7b350be5p153297453f8cb2dd@mail.gmail.com>
Message-ID: <b2e8f9f70911110927p2e918847w962aadfd345d955b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, forgot Signed-off-by.

--

This adds the missing S3C_VA_USB_HSPHY define and maps it to the correct
physical address.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>

---
 arch/arm/mach-s3c6400/include/mach/map.h           |    4 ++++
 arch/arm/plat-s3c64xx/cpu.c                        |    5 +++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6400/include/mach/map.h
b/arch/arm/mach-s3c6400/include/mach/map.h
index ae7704c..5a94e20 100644
--- a/arch/arm/mach-s3c6400/include/mach/map.h
+++ b/arch/arm/mach-s3c6400/include/mach/map.h
@@ -66,6 +66,9 @@

 #define S3C64XX_PA_USBHOST	(0x74300000)

+#define S3C64XX_PA_USB_HSPHY	(0x7C100000)
+#define S3C64XX_VA_USB_HSPHY	S3C_ADDR_CPU(0x00200000)
+
 /* place VICs close together */
 #define S3C_VA_VIC0		(S3C_VA_IRQ + 0x00)
 #define S3C_VA_VIC1		(S3C_VA_IRQ + 0x10000)
@@ -82,5 +85,6 @@
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
1.6.3.3
