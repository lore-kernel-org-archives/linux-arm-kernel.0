From: petr.cvek@tul.cz (Petr Cvek)
Date: Mon, 17 Aug 2015 23:59:44 +0200
Subject: [PATCH v2 07/21] ARM: pxa: magician: Fix IrDA pdata and redundant
 GPIO request
In-Reply-To: <cover.1439843482.git.petr.cvek@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz>
Message-ID: <55D25950.6010601@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix PXA FICP (IrDA) pdata and redundant GPIO request.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 702e8e0..7519238 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -256,7 +256,8 @@ static unsigned long magician_pin_config[] __initdata = {
 static struct pxaficp_platform_data magician_ficp_info = {
 	.gpio_pwdown		= GPIO83_MAGICIAN_nIR_EN,
 	/* TODO test with FIR dongle */
-	.transceiver_cap	= IR_SIRMODE | IR_OFF,
+	.transceiver_cap	= IR_SIRMODE | IR_FIRMODE | IR_OFF,
+	.gpio_pwdown_inverted = 0,
 };
 
 /*
@@ -987,7 +988,6 @@ static struct gpio magician_global_gpios[] = {
 		"LCD VOFF enable" },
 	{ GPIO105_MAGICIAN_LCD_VON_EN, GPIOF_OUT_INIT_HIGH,
 		"LCD VON enable" },
-	{ GPIO83_MAGICIAN_nIR_EN, GPIOF_OUT_INIT_HIGH,	"nIR_EN" },
 };
 
 static void __init magician_init(void)
-- 
1.7.12.1
