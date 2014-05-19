From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Mon, 19 May 2014 13:25:55 +0300
Subject: [Patch v3 5/5] ARM: keystone: enable reset driver support
In-Reply-To: <1400495155-11136-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1400495155-11136-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <1400495155-11136-6-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable reset driver support in order to have opportunity
to reboot SoC by watchdog and by software.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 arch/arm/configs/keystone_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index ec9a41d..86f02cb 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -131,6 +131,9 @@ CONFIG_SPI=y
 CONFIG_SPI_DAVINCI=y
 CONFIG_SPI_SPIDEV=y
 # CONFIG_HWMON is not set
+CONFIG_POWER_SUPPLY=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_KEYSTONE=y
 CONFIG_WATCHDOG=y
 CONFIG_WATCHDOG_CORE=y
 CONFIG_DAVINCI_WATCHDOG=y
-- 
1.8.3.2
