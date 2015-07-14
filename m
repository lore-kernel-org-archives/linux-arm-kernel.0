From: rogershimizu@gmail.com (Roger Shimizu)
Date: Tue, 14 Jul 2015 22:00:02 +0900
Subject: [PATCH 2/2] ARM: defconfig: add DT support for orion5x_defconfig
In-Reply-To: <1436878802-25712-1-git-send-email-rogershimizu@gmail.com>
References: <1436878802-25712-1-git-send-email-rogershimizu@gmail.com>
Message-ID: <1436878802-25712-3-git-send-email-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- add two DT-device entries into orion5x_defconfig
- enable EARLY_PRINTK because it's set in most "bootargs" setting for
  orion5x dts files. e.g.: 'bootargs = "console=ttyS0,115200n8
earlyprintk";'
- enable NETCONSOLE as module because it's helpful to check boot log
  when there's no serial connection

Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
---
 arch/arm/configs/orion5x_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/orion5x_defconfig b/arch/arm/configs/orion5x_defconfig
index 855143f..d1f533e 100644
--- a/arch/arm/configs/orion5x_defconfig
+++ b/arch/arm/configs/orion5x_defconfig
@@ -14,8 +14,10 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_BSD_DISKLABEL=y
 CONFIG_ARCH_ORION5X=y
+CONFIG_ARCH_ORION5X_DT=y
 CONFIG_MACH_DB88F5281=y
 CONFIG_MACH_RD88F5182=y
+CONFIG_MACH_RD88F5182_DT=y
 CONFIG_MACH_KUROBOX_PRO=y
 CONFIG_MACH_DNS323=y
 CONFIG_MACH_TS209=y
@@ -81,6 +83,7 @@ CONFIG_NETDEVICES=y
 CONFIG_MII=y
 CONFIG_NET_DSA_MV88E6131=y
 CONFIG_NET_DSA_MV88E6123_61_65=y
+CONFIG_NETCONSOLE=m
 CONFIG_MV643XX_ETH=y
 CONFIG_MARVELL_PHY=y
 # CONFIG_INPUT_MOUSEDEV is not set
@@ -157,6 +160,7 @@ CONFIG_LATENCYTOP=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
 CONFIG_DEBUG_LL_UART_8250=y
+CONFIG_EARLY_PRINTK=y
 CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
-- 
1.9.1
