From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Sep 2012 14:27:23 +0200
Subject: [PATCH v4 10/17] arm: plat-orion: use void __iomem pointers for UART
 registration functions
In-Reply-To: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1347366450-26644-11-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The registration functions for UARTs now take void __iomem pointers,
so we remove the temporary "unsigned long" casts from the
mach-*/common.c files.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-dove/common.c               |   12 ++++--------
 arch/arm/mach-kirkwood/common.c           |    6 ++----
 arch/arm/mach-mv78xx0/common.c            |   12 ++++--------
 arch/arm/mach-orion5x/common.c            |    6 ++----
 arch/arm/plat-orion/common.c              |   12 ++++++------
 arch/arm/plat-orion/include/plat/common.h |    8 ++++----
 6 files changed, 22 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 533fd81..ba55f63 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -128,8 +128,7 @@ void __init dove_sata_init(struct mv_sata_platform_data *sata_data)
  ****************************************************************************/
 void __init dove_uart0_init(void)
 {
-	orion_uart0_init((unsigned long) DOVE_UART0_VIRT_BASE,
-			 DOVE_UART0_PHYS_BASE,
+	orion_uart0_init(DOVE_UART0_VIRT_BASE, DOVE_UART0_PHYS_BASE,
 			 IRQ_DOVE_UART_0, tclk);
 }
 
@@ -138,8 +137,7 @@ void __init dove_uart0_init(void)
  ****************************************************************************/
 void __init dove_uart1_init(void)
 {
-	orion_uart1_init((unsigned long) DOVE_UART1_VIRT_BASE,
-			 DOVE_UART1_PHYS_BASE,
+	orion_uart1_init(DOVE_UART1_VIRT_BASE, DOVE_UART1_PHYS_BASE,
 			 IRQ_DOVE_UART_1, tclk);
 }
 
@@ -148,8 +146,7 @@ void __init dove_uart1_init(void)
  ****************************************************************************/
 void __init dove_uart2_init(void)
 {
-	orion_uart2_init((unsigned long) DOVE_UART2_VIRT_BASE,
-			 DOVE_UART2_PHYS_BASE,
+	orion_uart2_init(DOVE_UART2_VIRT_BASE, DOVE_UART2_PHYS_BASE,
 			 IRQ_DOVE_UART_2, tclk);
 }
 
@@ -158,8 +155,7 @@ void __init dove_uart2_init(void)
  ****************************************************************************/
 void __init dove_uart3_init(void)
 {
-	orion_uart3_init((unsigned long) DOVE_UART3_VIRT_BASE,
-			 DOVE_UART3_PHYS_BASE,
+	orion_uart3_init(DOVE_UART3_VIRT_BASE, DOVE_UART3_PHYS_BASE,
 			 IRQ_DOVE_UART_3, tclk);
 }
 
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 75bc04d..defceca 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -456,8 +456,7 @@ void __init kirkwood_i2c_init(void)
 
 void __init kirkwood_uart0_init(void)
 {
-	orion_uart0_init((unsigned long) UART0_VIRT_BASE,
-			 UART0_PHYS_BASE,
+	orion_uart0_init(UART0_VIRT_BASE, UART0_PHYS_BASE,
 			 IRQ_KIRKWOOD_UART_0, tclk);
 }
 
@@ -467,8 +466,7 @@ void __init kirkwood_uart0_init(void)
  ****************************************************************************/
 void __init kirkwood_uart1_init(void)
 {
-	orion_uart1_init((unsigned long) UART1_VIRT_BASE,
-			 UART1_PHYS_BASE,
+	orion_uart1_init(UART1_VIRT_BASE, UART1_PHYS_BASE,
 			 IRQ_KIRKWOOD_UART_1, tclk);
 }
 
diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
index c4e3458..fcda4a4 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-mv78xx0/common.c
@@ -300,8 +300,7 @@ void __init mv78xx0_sata_init(struct mv_sata_platform_data *sata_data)
  ****************************************************************************/
 void __init mv78xx0_uart0_init(void)
 {
-	orion_uart0_init((unsigned long) UART0_VIRT_BASE,
-			 UART0_PHYS_BASE,
+	orion_uart0_init(UART0_VIRT_BASE, UART0_PHYS_BASE,
 			 IRQ_MV78XX0_UART_0, tclk);
 }
 
@@ -311,8 +310,7 @@ void __init mv78xx0_uart0_init(void)
  ****************************************************************************/
 void __init mv78xx0_uart1_init(void)
 {
-	orion_uart1_init((unsigned long) UART1_VIRT_BASE,
-			 UART1_PHYS_BASE,
+	orion_uart1_init(UART1_VIRT_BASE, UART1_PHYS_BASE,
 			 IRQ_MV78XX0_UART_1, tclk);
 }
 
@@ -322,8 +320,7 @@ void __init mv78xx0_uart1_init(void)
  ****************************************************************************/
 void __init mv78xx0_uart2_init(void)
 {
-	orion_uart2_init((unsigned long) UART2_VIRT_BASE,
-			 UART2_PHYS_BASE,
+	orion_uart2_init(UART2_VIRT_BASE, UART2_PHYS_BASE,
 			 IRQ_MV78XX0_UART_2, tclk);
 }
 
@@ -332,8 +329,7 @@ void __init mv78xx0_uart2_init(void)
  ****************************************************************************/
 void __init mv78xx0_uart3_init(void)
 {
-	orion_uart3_init((unsigned long) UART3_VIRT_BASE,
-			 UART3_PHYS_BASE,
+	orion_uart3_init(UART3_VIRT_BASE, UART3_PHYS_BASE,
 			 IRQ_MV78XX0_UART_3, tclk);
 }
 
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index a890cb0..79f9ffb 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -156,8 +156,7 @@ void __init orion5x_spi_init()
  ****************************************************************************/
 void __init orion5x_uart0_init(void)
 {
-	orion_uart0_init((unsigned long) UART0_VIRT_BASE,
-			 UART0_PHYS_BASE,
+	orion_uart0_init(UART0_VIRT_BASE, UART0_PHYS_BASE,
 			 IRQ_ORION5X_UART0, tclk);
 }
 
@@ -166,8 +165,7 @@ void __init orion5x_uart0_init(void)
  ****************************************************************************/
 void __init orion5x_uart1_init(void)
 {
-	orion_uart1_init((unsigned long) UART1_VIRT_BASE,
-			 UART1_PHYS_BASE,
+	orion_uart1_init(UART1_VIRT_BASE, UART1_PHYS_BASE,
 			 IRQ_ORION5X_UART1, tclk);
 }
 
diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index b8b747a..5bed711 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -86,13 +86,13 @@ static void __init uart_complete(
 	struct platform_device *orion_uart,
 	struct plat_serial8250_port *data,
 	struct resource *resources,
-	unsigned int membase,
+	void __iomem *membase,
 	resource_size_t mapbase,
 	unsigned int irq,
 	struct clk *clk)
 {
 	data->mapbase = mapbase;
-	data->membase = (void __iomem *)membase;
+	data->membase = membase;
 	data->irq = irq;
 	data->uartclk = uart_get_clk_rate(clk);
 	orion_uart->dev.platform_data = data;
@@ -120,7 +120,7 @@ static struct platform_device orion_uart0 = {
 	.id			= PLAT8250_DEV_PLATFORM,
 };
 
-void __init orion_uart0_init(unsigned int membase,
+void __init orion_uart0_init(void __iomem *membase,
 			     resource_size_t mapbase,
 			     unsigned int irq,
 			     struct clk *clk)
@@ -148,7 +148,7 @@ static struct platform_device orion_uart1 = {
 	.id			= PLAT8250_DEV_PLATFORM1,
 };
 
-void __init orion_uart1_init(unsigned int membase,
+void __init orion_uart1_init(void __iomem *membase,
 			     resource_size_t mapbase,
 			     unsigned int irq,
 			     struct clk *clk)
@@ -176,7 +176,7 @@ static struct platform_device orion_uart2 = {
 	.id			= PLAT8250_DEV_PLATFORM2,
 };
 
-void __init orion_uart2_init(unsigned int membase,
+void __init orion_uart2_init(void __iomem *membase,
 			     resource_size_t mapbase,
 			     unsigned int irq,
 			     struct clk *clk)
@@ -204,7 +204,7 @@ static struct platform_device orion_uart3 = {
 	.id			= 3,
 };
 
-void __init orion_uart3_init(unsigned int membase,
+void __init orion_uart3_init(void __iomem *membase,
 			     resource_size_t mapbase,
 			     unsigned int irq,
 			     struct clk *clk)
diff --git a/arch/arm/plat-orion/include/plat/common.h b/arch/arm/plat-orion/include/plat/common.h
index ae2377e..6bbc3fe 100644
--- a/arch/arm/plat-orion/include/plat/common.h
+++ b/arch/arm/plat-orion/include/plat/common.h
@@ -13,22 +13,22 @@
 
 struct dsa_platform_data;
 
-void __init orion_uart0_init(unsigned int membase,
+void __init orion_uart0_init(void __iomem *membase,
 			     resource_size_t mapbase,
 			     unsigned int irq,
 			     struct clk *clk);
 
-void __init orion_uart1_init(unsigned int membase,
+void __init orion_uart1_init(void __iomem *membase,
 			     resource_size_t mapbase,
 			     unsigned int irq,
 			     struct clk *clk);
 
-void __init orion_uart2_init(unsigned int membase,
+void __init orion_uart2_init(void __iomem *membase,
 			     resource_size_t mapbase,
 			     unsigned int irq,
 			     struct clk *clk);
 
-void __init orion_uart3_init(unsigned int membase,
+void __init orion_uart3_init(void __iomem *membase,
 			     resource_size_t mapbase,
 			     unsigned int irq,
 			     struct clk *clk);
-- 
1.7.9.5
