From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 26 Sep 2009 13:07:39 +0530
Subject: [PATCH] ARM: OMAP4: Fix build break because of merge conflict
Message-ID: <mailman.40.1253952573.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the latest mainline head 2.6.31 (commit:6d7f18f6), OMAP4430 board
build is broken. This was mainly because of merge conflict which wasn't
resolved correctly.

The related patch and issue was discussed here.
http://article.gmane.org/gmane.linux.ports.arm.omap/23341

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/serial.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 3a529c7..54dfeb5 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -109,16 +109,6 @@ static struct plat_serial8250_port serial_platform_dat=
a2[] =3D {
 		.regshift	=3D 2,
 		.uartclk	=3D OMAP24XX_BASE_BAUD * 16,
 	}, {
-#ifdef CONFIG_ARCH_OMAP4
-		.membase	=3D IO_ADDRESS(OMAP_UART4_BASE),
-		.mapbase	=3D OMAP_UART4_BASE,
-		.irq		=3D 70,
-		.flags		=3D UPF_BOOT_AUTOCONF,
-		.iotype		=3D UPIO_MEM,
-		.regshift	=3D 2,
-		.uartclk	=3D OMAP24XX_BASE_BAUD * 16,
-	}, {
-#endif
 		.flags		=3D 0
 	}
 };
@@ -126,7 +116,7 @@ static struct plat_serial8250_port serial_platform_data=
2[] =3D {
 #ifdef CONFIG_ARCH_OMAP4
 static struct plat_serial8250_port serial_platform_data3[] =3D {
 	{
-		.membase	=3D IO_ADDRESS(OMAP_UART4_BASE),
+		.membase	=3D OMAP2_IO_ADDRESS(OMAP_UART4_BASE),
 		.mapbase	=3D OMAP_UART4_BASE,
 		.irq		=3D 70,
 		.flags		=3D UPF_BOOT_AUTOCONF,
@@ -579,7 +569,7 @@ static struct omap_uart_state omap_uart[OMAP_MAX_NR_POR=
TS] =3D {
 	{
 		.pdev =3D {
 			.name			=3D "serial8250",
-			.id			=3D 3
+			.id			=3D 3,
 			.dev			=3D {
 				.platform_data	=3D serial_platform_data3,
 			},
--=20
1.5.4.7

Thanks !!

Regards,
Santosh
