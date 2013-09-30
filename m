From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Sep 2013 18:53:45 +0200
Subject: [PATCH v2] ARM: sunxi: Add a defconfig for the Allwinner SoCs
Message-ID: <1380560025-5946-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far, the Allwinner SoCs were only supported using the
multi_v7_defconfig. Add a defconfig of our own to have one a bit more
tailor-made.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
Changes from v1:
  - Disabled the ARM errata 754322, that is Cortex-A9 specific
  - Disable CONFIG_SERIAL_OF_PLATFORM, that we don't need
  - Enabled the sun4i watchdog

 arch/arm/configs/sunxi_defconfig | 61 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 arch/arm/configs/sunxi_defconfig

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
new file mode 100644
index 0000000..d57a85b
--- /dev/null
+++ b/arch/arm/configs/sunxi_defconfig
@@ -0,0 +1,61 @@
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_SMP=y
+CONFIG_AEABI=y
+CONFIG_HIGHMEM=y
+CONFIG_HIGHPTE=y
+CONFIG_VFP=y
+CONFIG_NEON=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_WIRELESS is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_NETDEVICES=y
+CONFIG_SUN4I_EMAC=y
+# CONFIG_NET_CADENCE is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_CIRRUS is not set
+# CONFIG_NET_VENDOR_FARADAY is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+# CONFIG_WLAN is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=8
+CONFIG_SERIAL_8250_RUNTIME_UARTS=8
+CONFIG_SERIAL_8250_DW=y
+CONFIG_I2C=y
+# CONFIG_I2C_COMPAT is not set
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MV64XXX=y
+CONFIG_GPIO_SYSFS=y
+# CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+CONFIG_SUNXI_WATCHDOG=y
+# CONFIG_USB_SUPPORT is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
+CONFIG_COMMON_CLK_DEBUG=y
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_NLS=y
-- 
1.8.4
