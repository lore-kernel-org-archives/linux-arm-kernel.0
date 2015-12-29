From: public_timo.s@silentcreek.de (Timo Sigurdsson)
Date: Tue, 29 Dec 2015 02:47:33 +0100
Subject: [PATCH 1/1 for 4.4-rc8] ARM: Fix broken USB support in sunxi_defconfig
In-Reply-To: <1451353653-17484-1-git-send-email-public_timo.s@silentcreek.de>
References: <1451353653-17484-1-git-send-email-public_timo.s@silentcreek.de>
Message-ID: <1451353653-17484-2-git-send-email-public_timo.s@silentcreek.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 69fb4dcada77 ("power: Add an axp20x-usb-power driver") introduced a new
driver for the USB power supply used on various Allwinner based SBCs. However,
the driver was not added to sunxi_defconfig which breaks USB support for some
boards (e.g. LeMaker BananaPi) as the kernel will now turn off the USB power
supply during boot by default if the driver isn't present. (This was not the
case in linux 4.3 or lower where the USB power was always left on.)

Hence, add the driver to sunxi_defconfig in order to keep USB support working
on those boards that require it.

Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
Reported-by: David Tulloh <david@tulloh.id.au>
Tested-by: David Tulloh <david@tulloh.id.au>
Tested-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
---
 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 3c36e16..b503a89 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -84,6 +84,7 @@ CONFIG_SPI_SUN4I=y
 CONFIG_SPI_SUN6I=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_SUPPLY=y
+CONFIG_AXP20X_POWER=y
 CONFIG_THERMAL=y
 CONFIG_CPU_THERMAL=y
 CONFIG_WATCHDOG=y
-- 
2.1.4
