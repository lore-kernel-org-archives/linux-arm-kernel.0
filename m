From: aford173@gmail.com (Adam Ford)
Date: Thu, 17 May 2018 20:20:52 -0500
Subject: [PATCH] ARM: davinci: board-da850-evm: fix WP pin polarity for MMC/SD
Message-ID: <20180518012052.31345-1-aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting from MMC/SD in rw mode, the system crashes because
the write protect pin should be active high and not active low.
This patch fixes the polarity of the WP pin.

Fixes: 67c6b6ff221f ("ARM: davinci: board-da850-evm: fix GPIO
lookup for MMC/SD")

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index e22fb40e34bc..6d5beb11bd96 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -774,7 +774,7 @@ static struct gpiod_lookup_table mmc_gpios_table = {
 		GPIO_LOOKUP("davinci_gpio.0", DA850_MMCSD_CD_PIN, "cd",
 			    GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP("davinci_gpio.0", DA850_MMCSD_WP_PIN, "wp",
-			    GPIO_ACTIVE_LOW),
+			    GPIO_ACTIVE_HIGH),
 	},
 };
 
-- 
2.17.0
