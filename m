From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue,  8 May 2012 09:20:25 +0200
Subject: [PATCH 10/12] ARM: imx: eukrea_mbimxsd25: don't free twice
 GPIO_SWITCH1
In-Reply-To: <1336461627-30315-1-git-send-email-eric@eukrea.com>
References: <1336461627-30315-1-git-send-email-eric@eukrea.com>
Message-ID: <1336461627-30315-10-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
---
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
index cafa109..fcc366a 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
@@ -292,7 +292,6 @@ void __init eukrea_mbimxsd25_baseboard_init(void)
 
 	gpio_request(GPIO_LCDPWR, "LCDPWR");
 	gpio_direction_output(GPIO_LCDPWR, 1);
-	gpio_free(GPIO_SWITCH1);
 
 	i2c_register_board_info(0, eukrea_mbimxsd_i2c_devices,
 				ARRAY_SIZE(eukrea_mbimxsd_i2c_devices));
-- 
1.7.7.6
