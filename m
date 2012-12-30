From: linux@prisktech.co.nz (Tony Prisk)
Date: Mon, 31 Dec 2012 09:29:34 +1300
Subject: [PATCH] gpio: vt8500: Export dedicated GPIO before multifunction pins.
Message-ID: <1356899374-9395-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vendor does not provide numbering for gpio pins. Vendor source
exports dedicated gpio pins first, followed by multifunction pins.
As this is what end users expect, this patch changes vt8500 and wm8505
to do the same.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/gpio/gpio-vt8500.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-vt8500.c b/drivers/gpio/gpio-vt8500.c
index b53320a..9a7c434 100644
--- a/drivers/gpio/gpio-vt8500.c
+++ b/drivers/gpio/gpio-vt8500.c
@@ -73,19 +73,20 @@ struct vt8500_gpio_data {
 static struct vt8500_gpio_data vt8500_data = {
 	.num_banks	= 7,
 	.banks	= {
+		VT8500_BANK(NO_REG, 0x3C, 0x5C, 0x7C, 9),
 		VT8500_BANK(0x00, 0x20, 0x40, 0x60, 26),
 		VT8500_BANK(0x04, 0x24, 0x44, 0x64, 28),
 		VT8500_BANK(0x08, 0x28, 0x48, 0x68, 31),
 		VT8500_BANK(0x0C, 0x2C, 0x4C, 0x6C, 19),
 		VT8500_BANK(0x10, 0x30, 0x50, 0x70, 19),
 		VT8500_BANK(0x14, 0x34, 0x54, 0x74, 23),
-		VT8500_BANK(NO_REG, 0x3C, 0x5C, 0x7C, 9),
 	},
 };
 
 static struct vt8500_gpio_data wm8505_data = {
 	.num_banks	= 10,
 	.banks	= {
+		VT8500_BANK(0x64, 0x8C, 0xB4, 0xDC, 22),
 		VT8500_BANK(0x40, 0x68, 0x90, 0xB8, 8),
 		VT8500_BANK(0x44, 0x6C, 0x94, 0xBC, 32),
 		VT8500_BANK(0x48, 0x70, 0x98, 0xC0, 6),
@@ -95,7 +96,6 @@ static struct vt8500_gpio_data wm8505_data = {
 		VT8500_BANK(0x58, 0x80, 0xA8, 0xD0, 5),
 		VT8500_BANK(0x5C, 0x84, 0xAC, 0xD4, 12),
 		VT8500_BANK(0x60, 0x88, 0xB0, 0xD8, 16),
-		VT8500_BANK(0x64, 0x8C, 0xB4, 0xDC, 22),
 		VT8500_BANK(0x500, 0x504, 0x508, 0x50C, 6),
 	},
 };
-- 
1.7.9.5
