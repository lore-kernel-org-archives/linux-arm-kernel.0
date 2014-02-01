From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Sat, 1 Feb 2014 14:25:04 +0200
Subject: [PATCH v2] arm: keystone: enable watchdog support
Message-ID: <1391257504-6502-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keystone SoC uses the same watchdog driver as Davinci, so
enable WDT and core used by it.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>

Conflicts:
	arch/arm/configs/keystone_defconfig
---
Rebased on
git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
keystone/master

 arch/arm/configs/keystone_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index a018244..061ec999 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -131,6 +131,8 @@ CONFIG_SPI_DAVINCI=y
 CONFIG_SPI_SPIDEV=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
+CONFIG_WATCHDOG_CORE=y
+CONFIG_DAVINCI_WATCHDOG=y
 CONFIG_USB=y
 CONFIG_USB_DEBUG=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
-- 
1.8.3.2
