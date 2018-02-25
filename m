From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 25 Feb 2018 15:10:55 +0100
Subject: [PATCH 4/4] ARM: bcm2385_defconfig: Enable BT support for BCM43438
In-Reply-To: <1519567855-26105-1-git-send-email-stefan.wahren@i2se.com>
References: <1519567855-26105-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1519567855-26105-5-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Raspberry Pi Zero W has an onboard BT chip (BCM43438). So enable the
necessary HCI UART driver (requires serial device bus).

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/configs/bcm2835_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 43dab48..8682b15 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -49,6 +49,9 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_NETWORK_SECMARK=y
 CONFIG_NETFILTER=y
+CONFIG_BT=y
+CONFIG_BT_HCIUART=m
+CONFIG_BT_HCIUART_BCM=y
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_DEVTMPFS=y
@@ -74,6 +77,7 @@ CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_BCM2835AUX=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
+CONFIG_SERIAL_DEV_BUS=y
 CONFIG_TTY_PRINTK=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_BCM2835=y
-- 
2.7.4
