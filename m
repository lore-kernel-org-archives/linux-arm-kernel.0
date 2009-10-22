From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Oct 2009 15:13:14 -0700
Subject: [PATCH 10/10] omap4: Fix UART4 platform data on omap4
In-Reply-To: <20091022221013.27408.443.stgit@localhost>
References: <20091022221013.27408.443.stgit@localhost>
Message-ID: <20091022221314.27408.99866.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch removes the unnecessary UART4 platform which is under
data is wrong because of this

There is a separate platform structure for UART4

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-By: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/serial.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index ae21868..54dfeb5 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -109,16 +109,6 @@ static struct plat_serial8250_port serial_platform_data2[] = {
 		.regshift	= 2,
 		.uartclk	= OMAP24XX_BASE_BAUD * 16,
 	}, {
-#ifdef CONFIG_ARCH_OMAP4
-		.membase	= OMAP2_IO_ADDRESS(OMAP_UART4_BASE),
-		.mapbase	= OMAP_UART4_BASE,
-		.irq		= 70,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.iotype		= UPIO_MEM,
-		.regshift	= 2,
-		.uartclk	= OMAP24XX_BASE_BAUD * 16,
-	}, {
-#endif
 		.flags		= 0
 	}
 };
