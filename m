From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 11 Feb 2011 16:44:04 +1300
Subject: [PATCH 2/2] Add Snapper9260 rtc wakeup interrupt pin
In-Reply-To: <1297395844-21162-1-git-send-email-ryan@bluewatersys.com>
References: <1297395844-21162-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1297395844-21162-2-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/board-snapper9260.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/board-snapper9260.c b/arch/arm/mach-at91/board-snapper9260.c
index 0a99b3c..17f7d9b 100644
--- a/arch/arm/mach-at91/board-snapper9260.c
+++ b/arch/arm/mach-at91/board-snapper9260.c
@@ -153,6 +153,7 @@ static struct i2c_board_info __initdata snapper9260_i2c_devices[] = {
 	{
 		/* RTC */
 		I2C_BOARD_INFO("isl1208", 0x6f),
+		.irq = gpio_to_irq(AT91_PIN_PA31),
 	},
 };
 
-- 
1.7.0.4
