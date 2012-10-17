From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 18 Oct 2012 07:18:13 +1300
Subject: [PATCH] GPIO: vt8500: Add extended gpio bank for WM8505/WM8650
Message-ID: <1350497893-25106-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These SoC's have an extended bank of GPIO's seperate to the main
GPIO block. This patch adds the additional 5 GPIO's located in this
block which control I2C and PWMOUT.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/gpio/gpio-vt8500.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-vt8500.c b/drivers/gpio/gpio-vt8500.c
index bcd8e4a..9ed2a2b 100644
--- a/drivers/gpio/gpio-vt8500.c
+++ b/drivers/gpio/gpio-vt8500.c
@@ -96,6 +96,7 @@ static struct vt8500_gpio_data wm8505_data = {
 		VT8500_BANK(0x5C, 0x84, 0xAC, 0xD4, 12),
 		VT8500_BANK(0x60, 0x88, 0xB0, 0xD8, 16),
 		VT8500_BANK(0x64, 0x8C, 0xB4, 0xDC, 22),
+		VT8500_BANK(0x500, 0x504, 0x508, 0x50C, 6),
 	},
 };
 
@@ -115,6 +116,7 @@ static struct vt8500_gpio_data wm8650_data = {
 		VT8500_BANK(0x58, 0x98, 0xD8, 0x18, 32),
 		VT8500_BANK(0x5C, 0x9C, 0xDC, 0x1C, 32),
 		VT8500_BANK(0x7C, 0xBC, 0xFC, 0x3C, 32),
+		VT8500_BANK(0x500, 0x504, 0x508, 0x50C, 6),
 	},
 };
 
-- 
1.7.9.5
