From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu,  2 Apr 2015 18:41:46 +0300
Subject: [PATCH 2/3] ARM: sa1100: populate codec platform data with irq
In-Reply-To: <1427989307-1805-1-git-send-email-dbaryshkov@gmail.com>
References: <1427989307-1805-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1427989307-1805-2-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the sa11x0 boards that provide ucb1x00 codec platform data, provide
the irq data.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/assabet.c | 1 +
 arch/arm/mach-sa1100/collie.c  | 1 +
 arch/arm/mach-sa1100/simpad.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index d28ecb9..28bb7ca 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -309,6 +309,7 @@ static struct ucb1x00_plat_data assabet_ucb1x00_data = {
 	.reset		= assabet_ucb1x00_reset,
 	.gpio_base	= -1,
 	.can_wakeup	= 1,
+	.irq		= IRQ_GPIO23,
 };
 
 static struct mcp_plat_data assabet_mcp_data = {
diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index 98710ea..cb1e7d7 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -97,6 +97,7 @@ static struct scoop_pcmcia_config collie_pcmcia_config = {
 
 static struct ucb1x00_plat_data collie_ucb1x00_data = {
 	.gpio_base	= COLLIE_TC35143_GPIO_BASE,
+	.irq		= COLLIE_IRQ_GPIO_UCB1x00_IRQ,
 };
 
 static struct mcp_plat_data collie_mcp_data = {
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index 41e476e..117281c 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -184,6 +184,7 @@ static struct resource simpad_flash_resources [] = {
 
 static struct ucb1x00_plat_data simpad_ucb1x00_data = {
 	.gpio_base	= SIMPAD_UCB1X00_GPIO_BASE,
+	.irq		= IRQ_GPIO_UCB1300_IRQ,
 };
 
 static struct mcp_plat_data simpad_mcp_data = {
-- 
2.1.4
