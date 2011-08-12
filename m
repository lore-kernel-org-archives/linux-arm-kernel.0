From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 12 Aug 2011 15:54:56 +0800
Subject: [PATCH 1/6] arm/cpuimx51: gpio_to_irq() should be used to get irq
	from gpio number
In-Reply-To: <1313135701-22456-1-git-send-email-shawn.guo@linaro.org>
References: <1313135701-22456-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1313135701-22456-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of irq_to_gpio(), gpio_to_irq() should be used to get irq
from gpio number.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx5/board-cpuimx51.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
index 7c893fa..68934ea 100644
--- a/arch/arm/mach-mx5/board-cpuimx51.c
+++ b/arch/arm/mach-mx5/board-cpuimx51.c
@@ -81,7 +81,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
 	}, {
 		.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x2000000),
-		.irq = irq_to_gpio(CPUIMX51_QUARTD_GPIO),
+		.irq = gpio_to_irq(CPUIMX51_QUARTD_GPIO),
 		.irqflags = IRQF_TRIGGER_HIGH,
 		.uartclk = CPUIMX51_QUART_XTAL,
 		.regshift = CPUIMX51_QUART_REGSHIFT,
-- 
1.7.4.1
