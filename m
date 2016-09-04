From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun,  4 Sep 2016 20:59:46 +0200
Subject: [PATCH 2/3] ARM: pxa: lubbock: add pcmcia clock
In-Reply-To: <1473015587-15589-1-git-send-email-robert.jarzmik@free.fr>
References: <1473015587-15589-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1473015587-15589-2-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the clock provided to the PCMCIA block so that sa1111_pcmcia_add()
doesn't end up on error while probing "1800" device.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/lubbock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index cd401546cea8..0bcb107d69b4 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -491,6 +491,7 @@ static void __init lubbock_init(void)
 	gpiod_add_lookup_table(&sa1111_pcmcia_gpio_table);
 
 	clk_add_alias("SA1111_CLK", NULL, "GPIO11_CLK", NULL);
+	clk_add_alias(NULL, "1800", "SA1111_CLK", NULL);
 	pxa_set_udc_info(&udc_info);
 	pxa_set_fb_info(NULL, &sharp_lm8v31);
 	pxa_set_mci_info(&lubbock_mci_platform_data);
-- 
2.1.4
