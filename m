From: robertcnelson@gmail.com (Robert Nelson)
Date: Wed, 10 Apr 2013 12:05:32 -0500
Subject: [PATCH] ARM: at91/dts: at91sam9g20ek_2mmc: fix card detection
Message-ID: <1365613532-18919-1-git-send-email-robertcnelson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use cd-inverted to fix card detection on the at91sam9g20-ek Rev C Dev board.

With: v3.9-rc6:
atmel_mci fffa8000.mmc: version: 0x210
atmel_mci fffa8000.mmc: using PDC
atmel_mci fffa8000.mmc: Atmel MCI controller at 0xfffa8000 irq 30, 2 slots
Waiting for root device /dev/mmcblk0p2...

With: v3.9-rc6 + this patch, card is now detected.
atmel_mci fffa8000.mmc: version: 0x210
atmel_mci fffa8000.mmc: using PDC
mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new SD card at address 0007
atmel_mci fffa8000.mmc: Atmel MCI controller at 0xfffa8000 irq 30, 2 slots
mmcblk0: mmc0:0007 SD02G 1.89 GiB
mmcblk0: p1 p2

Although other issues still remain:
mmcblk0: retrying using single block read
mmcblk0: error -115 sending stop command, original cmd response 0xb00, card status 0x900
mmcblk0: error -110 transferring data, sector 834296, nr 8, cmd response 0xb00, card status 0x0
mmcblk0: retrying using single block read

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
---
 arch/arm/boot/dts/at91sam9g20ek_2mmc.dts |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts b/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts
index 66467b1..d1b1521 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts
+++ b/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts
@@ -24,6 +24,7 @@
 					reg = <0>;
 					bus-width = <4>;
 					cd-gpios = <&pioC 2 0>;
+					cd-inverted;
 				};
 			};
 
-- 
1.7.10.4
