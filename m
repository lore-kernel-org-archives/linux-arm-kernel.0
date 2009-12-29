From: andy@warmcat.com (Andy Green)
Date: Tue, 29 Dec 2009 14:40:30 +0000
Subject: [PATCH 2/4] s3c64xx-add-srom-physical-virtual-mapping.patch
In-Reply-To: <20091229143756.15524.25160.stgit@hit-nxdomain.opendns.com>
References: <20091229143756.15524.25160.stgit@hit-nxdomain.opendns.com>
Message-ID: <20091229144030.15524.91370.stgit@hit-nxdomain.opendns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the physical address of the SROM unit, and
applies a virtual mapping for it to the S3C_VA_MEM
slot.

Signed-off-by: Andy Green <andy@warmcat.com>
---

 arch/arm/mach-s3c6400/include/mach/map.h |    2 ++
 arch/arm/plat-s3c64xx/cpu.c              |    5 +++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6400/include/mach/map.h b/arch/arm/mach-s3c6400/include/mach/map.h
index b0fb5c5..f211744 100644
--- a/arch/arm/mach-s3c6400/include/mach/map.h
+++ b/arch/arm/mach-s3c6400/include/mach/map.h
@@ -50,6 +50,8 @@
 #define S3C_VA_UART2		S3C_VA_UARTx(2)
 #define S3C_VA_UART3		S3C_VA_UARTx(3)
 
+#define S3C64XX_PA_SROM		(0x70000000)
+
 #define S3C64XX_PA_NAND		(0x70200000)
 #define S3C64XX_PA_FB		(0x77100000)
 #define S3C64XX_PA_USB_HSOTG	(0x7C000000)
diff --git a/arch/arm/plat-s3c64xx/cpu.c b/arch/arm/plat-s3c64xx/cpu.c
index 49796d2..2dba92a 100644
--- a/arch/arm/plat-s3c64xx/cpu.c
+++ b/arch/arm/plat-s3c64xx/cpu.c
@@ -73,6 +73,11 @@ static struct map_desc s3c_iodesc[] __initdata = {
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	}, {
+		.virtual	= (unsigned long)S3C_VA_MEM,
+		.pfn		= __phys_to_pfn(S3C64XX_PA_SROM),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
 		.virtual	= (unsigned long)(S3C_VA_UART + UART_OFFS),
 		.pfn		= __phys_to_pfn(S3C_PA_UART),
 		.length		= SZ_4K,
