From: jochen@scram.de (Jochen Friedrich)
Date: Fri, 29 Apr 2011 17:16:52 +0200
Subject: [PATCHv4 2.6.40 1/4] ARM:simpad: Add ucb1x00 GPIO definitions and
	register GPIO
In-Reply-To: <1304090215-7457-1-git-send-email-jochen@scram.de>
References: <1304090215-7457-1-git-send-email-jochen@scram.de>
Message-ID: <1304090215-7457-2-git-send-email-jochen@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ucb1x00 GPIO definitions to simpad.h and add gpio_base
to ucb1x00 platform device so the pins are available using
the GPIO API.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/arm/mach-sa1100/include/mach/simpad.h |   13 +++++++++++++
 arch/arm/mach-sa1100/simpad.c              |    1 +
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/simpad.h b/arch/arm/mach-sa1100/include/mach/simpad.h
index 9296c45..231550d 100644
--- a/arch/arm/mach-sa1100/include/mach/simpad.h
+++ b/arch/arm/mach-sa1100/include/mach/simpad.h
@@ -48,6 +48,19 @@
 #define GPIO_SMART_CARD		GPIO_GPIO10
 #define IRQ_GPIO_SMARD_CARD	IRQ_GPIO10
 
+/*--- ucb1x00 GPIO ---*/
+#define SIMPAD_UCB1X00_GPIO_BASE	(GPIO_MAX + 1)
+#define SIMPAD_UCB1X00_GPIO_PROG1	(SIMPAD_UCB1X00_GPIO_BASE)
+#define SIMPAD_UCB1X00_GPIO_PROG2	(SIMPAD_UCB1X00_GPIO_BASE + 1)
+#define SIMPAD_UCB1X00_GPIO_UP		(SIMPAD_UCB1X00_GPIO_BASE + 2)
+#define SIMPAD_UCB1X00_GPIO_DOWN	(SIMPAD_UCB1X00_GPIO_BASE + 3)
+#define SIMPAD_UCB1X00_GPIO_LEFT	(SIMPAD_UCB1X00_GPIO_BASE + 4)
+#define SIMPAD_UCB1X00_GPIO_RIGHT	(SIMPAD_UCB1X00_GPIO_BASE + 5)
+#define SIMPAD_UCB1X00_GPIO_6		(SIMPAD_UCB1X00_GPIO_BASE + 6)
+#define SIMPAD_UCB1X00_GPIO_7		(SIMPAD_UCB1X00_GPIO_BASE + 7)
+#define SIMPAD_UCB1X00_GPIO_HEADSET	(SIMPAD_UCB1X00_GPIO_BASE + 8)
+#define SIMPAD_UCB1X00_GPIO_SPEAKER	(SIMPAD_UCB1X00_GPIO_BASE + 9)
+
 // CS3 Latch is write only, a shadow is necessary
 
 #define CS3BUSTYPE unsigned volatile long
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index cfb7607..718b802 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -132,6 +132,7 @@ static struct resource simpad_flash_resources [] = {
 static struct mcp_plat_data simpad_mcp_data = {
 	.mccr0		= MCCR0_ADM,
 	.sclk_rate	= 11981000,
+	.gpio_base	= SIMPAD_UCB1X00_GPIO_BASE,
 };
 
 
-- 
1.7.4.1
