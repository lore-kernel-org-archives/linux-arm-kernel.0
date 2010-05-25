From: daniel@caiaq.de (Daniel Mack)
Date: Tue, 25 May 2010 16:46:56 +0200
Subject: [PATCH 4/5] ARM: mx3: mx31lilly: pass mc13783 SPI IRQ pin
In-Reply-To: <1274798817-21805-1-git-send-email-daniel@caiaq.de>
References: <1274798817-21805-1-git-send-email-daniel@caiaq.de>
Message-ID: <1274798817-21805-5-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes the resistive touch interface work.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/mach-mx31lilly.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31lilly.c b/arch/arm/mach-mx3/mach-mx31lilly.c
index b2c7f51..4b33084 100644
--- a/arch/arm/mach-mx3/mach-mx31lilly.c
+++ b/arch/arm/mach-mx3/mach-mx31lilly.c
@@ -289,6 +289,7 @@ static struct spi_board_info mc13783_dev __initdata = {
 	.bus_num	= 1,
 	.chip_select	= 0,
 	.platform_data	= &mc13783_pdata,
+	.irq		= IOMUX_TO_IRQ(MX31_PIN_GPIO1_3),
 };
 
 static struct platform_device *devices[] __initdata = {
-- 
1.7.1
