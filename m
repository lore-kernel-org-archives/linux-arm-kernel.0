From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 09:26:48 +0000
Subject: [PATCH 13/31] ARM: amba: nomadik: get rid of NO_IRQ initializers
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoAkC-0005F9-GQ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-nomadik/board-nhk8815.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index 7c878bf..721e51c 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -191,13 +191,13 @@ static void __init nhk8815_onenand_init(void)
 static struct amba_device uart0_device = {
 	.dev = { .init_name = "uart0" },
 	__MEM_4K_RESOURCE(NOMADIK_UART0_BASE),
-	.irq = {IRQ_UART0, NO_IRQ},
+	.irq = {IRQ_UART0},
 };
 
 static struct amba_device uart1_device = {
 	.dev = { .init_name = "uart1" },
 	__MEM_4K_RESOURCE(NOMADIK_UART1_BASE),
-	.irq = {IRQ_UART1, NO_IRQ},
+	.irq = {IRQ_UART1},
 };
 
 static struct amba_device *amba_devs[] __initdata = {
-- 
1.7.4.4
