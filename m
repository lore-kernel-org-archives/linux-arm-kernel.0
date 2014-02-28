From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Fri, 28 Feb 2014 20:07:45 +0200
Subject: [PATCH 5/5] ARM: keystone: enable reset driver support
In-Reply-To: <1393610865-23630-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1393610865-23630-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <1393610865-23630-6-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable reset driver support in order to have opportunity
to reboot SoC by watchdog and by software.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---

CC: Russell King <linux@arm.linux.org.uk>
CC: Santosh Shilimkar <santosh.shilimkar@ti.com>

 arch/arm/configs/keystone_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 4582e16..3f9c688 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -130,6 +130,9 @@ CONFIG_SPI=y
 CONFIG_SPI_DAVINCI=y
 CONFIG_SPI_SPIDEV=y
 # CONFIG_HWMON is not set
+CONFIG_POWER_SUPPLY=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_KEYSTONE=y
 CONFIG_WATCHDOG=y
 CONFIG_USB=y
 CONFIG_USB_DEBUG=y
-- 
1.8.3.2
