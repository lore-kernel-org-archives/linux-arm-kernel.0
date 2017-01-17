From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 17 Jan 2017 13:26:07 +0100
Subject: [PATCH v2 05/14] ARM: davinci: da850: add con_id for the SATA clock
In-Reply-To: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
References: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1484655976-25382-6-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ahci-da850 SATA driver is now capable of retrieving clocks by
con_id. Add the connector id for the sysclk2-derived SATA clock.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da850.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 1d873d1..dbf1daa 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -571,7 +571,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK("spi_davinci.0",	NULL,		&spi0_clk),
 	CLK("spi_davinci.1",	NULL,		&spi1_clk),
 	CLK("vpif",		NULL,		&vpif_clk),
-	CLK("ahci_da850",		NULL,		&sata_clk),
+	CLK("ahci_da850",	"sata",		&sata_clk),
 	CLK("davinci-rproc.0",	NULL,		&dsp_clk),
 	CLK(NULL,		NULL,		&ehrpwm_clk),
 	CLK("ehrpwm.0",		"fck",		&ehrpwm0_clk),
-- 
2.9.3
