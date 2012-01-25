From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:40:35 +0000
Subject: [PATCH 31/33] ARM: sa11x0: add assabet ucb1x00 platform data
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq41b-0000Zs-7h@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ucb1x00 platform data to enable GPIO support on the UCB1300 device.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/assabet.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 3a19145..c45402f 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -15,6 +15,7 @@
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/serial_core.h>
+#include <linux/mfd/ucb1x00.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/delay.h>
@@ -199,9 +200,14 @@ static struct irda_platform_data assabet_irda_data = {
 	.set_speed	= assabet_irda_set_speed,
 };
 
+static struct ucb1x00_plat_data assabet_ucb1x00_data = {
+	.gpio_base	= -1,
+};
+
 static struct mcp_plat_data assabet_mcp_data = {
 	.mccr0		= MCCR0_ADM,
 	.sclk_rate	= 11981000,
+	.codec_pdata	= &assabet_ucb1x00_data,
 };
 
 static void __init assabet_init(void)
-- 
1.7.4.4
