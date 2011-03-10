From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 10 Mar 2011 19:08:57 +0100
Subject: [PATCH 6/6] AT91: at91sam9x5: add chip and board file
In-Reply-To: <20110310180628.GH9351@game.jcrosoft.org>
References: <20110310180628.GH9351@game.jcrosoft.org>
Message-ID: <1299780537-16481-6-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>

On-chip and board related peripherals definitions.
Basic implementation for VB board.

Signed-off-by: Dan Liang <dan.liang@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/configs/at91sam9x5ek_defconfig    |  180 +++++
 arch/arm/mach-at91/Kconfig                 |   19 +
 arch/arm/mach-at91/Makefile                |    4 +
 arch/arm/mach-at91/at91sam9x5_devices.c    | 1083 ++++++++++++++++++++++++++++
 arch/arm/mach-at91/board-sam9x5ek.c        |  243 +++++++
 arch/arm/mach-at91/clock.c                 |    2 +
 arch/arm/mach-at91/generic.h               |    2 +
 arch/arm/mach-at91/include/mach/board.h    |    2 +-
 arch/arm/mach-at91/include/mach/hardware.h |    2 +
 arch/arm/mach-at91/include/mach/timex.h    |    5 +
 arch/arm/mach-at91/pm.h                    |   19 +
 arch/arm/mach-at91/pm_slowclock.S          |   11 +-
 drivers/dma/Kconfig                        |    2 +-
 13 files changed, 1568 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/configs/at91sam9x5ek_defconfig
 create mode 100644 arch/arm/mach-at91/at91sam9x5_devices.c
 create mode 100644 arch/arm/mach-at91/board-sam9x5ek.c

diff --git a/arch/arm/configs/at91sam9x5ek_defconfig b/arch/arm/configs/at91sam9x5ek_defconfig
new file mode 100644
index 0000000..1c76278
--- /dev/null
+++ b/arch/arm/configs/at91sam9x5ek_defconfig
@@ -0,0 +1,180 @@
+CONFIG_EXPERIMENTAL=y
+# CONFIG_LOCALVERSION_AUTO is not set
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_UTS_NS is not set
+# CONFIG_IPC_NS is not set
+# CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
+# CONFIG_NET_NS is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_SLAB=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+CONFIG_ARCH_AT91=y
+CONFIG_ARCH_AT91SAM9X5=y
+CONFIG_CHIP_SAM9X25=y
+CONFIG_MACH_AT91SAM9X5EK=y
+CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
+CONFIG_AT91_SLOW_CLOCK=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_AEABI=y
+CONFIG_LEDS=y
+CONFIG_LEDS_CPU=y
+CONFIG_UACCESS_WITH_MEMCPY=y
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_CMDLINE="mem=128M console=ttyS0,115200 initrd=0x21100000,8000000 root=/dev/ram0 rw mtdparts=atmel_nand:4M(bootstrap/uboot/kernel)ro,60M(rootfs),-(data)"
+CONFIG_FPE_NWFPE=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_PM=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_IPV6 is not set
+CONFIG_NETFILTER=y
+CONFIG_NETFILTER_NETLINK_QUEUE=m
+CONFIG_NETFILTER_NETLINK_LOG=m
+CONFIG_NF_CONNTRACK=y
+CONFIG_NF_CONNTRACK_MARK=y
+CONFIG_NF_CONNTRACK_FTP=m
+CONFIG_NF_CT_NETLINK=m
+CONFIG_NF_CONNTRACK_IPV4=y
+CONFIG_IP_NF_IPTABLES=y
+CONFIG_IP_NF_MATCH_ADDRTYPE=y
+CONFIG_IP_NF_FILTER=y
+CONFIG_IP_NF_TARGET_REJECT=m
+CONFIG_IP_NF_TARGET_LOG=m
+CONFIG_IP_NF_TARGET_ULOG=m
+CONFIG_NF_NAT=y
+CONFIG_IP_NF_TARGET_MASQUERADE=y
+CONFIG_IP_NF_TARGET_NETMAP=y
+CONFIG_IP_NF_TARGET_REDIRECT=y
+CONFIG_IP_NF_RAW=m
+CONFIG_IP_NF_ARPTABLES=m
+CONFIG_BRIDGE=y
+CONFIG_VLAN_8021Q=m
+CONFIG_NET_SCHED=y
+CONFIG_NET_SCH_CBQ=m
+CONFIG_NET_SCH_HTB=m
+CONFIG_NET_SCH_HFSC=m
+CONFIG_NET_SCH_TBF=m
+CONFIG_NET_CLS_FW=m
+# CONFIG_WIRELESS is not set
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+CONFIG_MTD=y
+CONFIG_MTD_TESTS=m
+CONFIG_MTD_CONCAT=y
+CONFIG_MTD_PARTITIONS=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_M25P80=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_ATMEL=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=4
+CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_MISC_DEVICES=y
+CONFIG_ATMEL_TCLIB=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_SCSI_MULTI_LUN=y
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_NETDEVICES=y
+CONFIG_MII=y
+CONFIG_PHYLIB=y
+CONFIG_DAVICOM_PHY=y
+CONFIG_NET_ETHERNET=y
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
+# CONFIG_WLAN is not set
+# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=800
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=480
+CONFIG_INPUT_EVDEV=y
+# CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_GPIO=y
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_SERIAL_ATMEL=y
+CONFIG_SERIAL_ATMEL_CONSOLE=y
+CONFIG_LEGACY_PTY_COUNT=8
+CONFIG_HW_RANDOM=y
+CONFIG_SPI=y
+CONFIG_SPI_ATMEL=y
+CONFIG_GPIO_SYSFS=y
+# CONFIG_HWMON is not set
+# CONFIG_MFD_SUPPORT is not set
+CONFIG_USB=y
+# CONFIG_USB_DEVICE_CLASS is not set
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_LIBUSUAL=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_ZERO=m
+CONFIG_USB_ETH=m
+CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_G_SERIAL=m
+CONFIG_USB_CDC_COMPOSITE=m
+CONFIG_USB_G_MULTI=m
+CONFIG_USB_G_MULTI_CDC=y
+CONFIG_MMC=y
+# CONFIG_MMC_BLOCK_BOUNCE is not set
+CONFIG_MMC_ATMELMCI=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_GPIO=y
+CONFIG_RTC_CLASS=y
+CONFIG_DMADEVICES=y
+CONFIG_AT_HDMAC=y
+CONFIG_DMATEST=m
+CONFIG_UIO=y
+CONFIG_UIO_PDRV=m
+CONFIG_UIO_PDRV_GENIRQ=y
+CONFIG_EXT2_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_TMPFS=y
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_SUMMARY=y
+CONFIG_LOGFS=m
+CONFIG_CRAMFS=y
+CONFIG_SQUASHFS=m
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_NFS_V4=y
+CONFIG_ROOT_NFS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_CODEPAGE_850=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_ISO8859_15=y
+CONFIG_NLS_UTF8=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_USER=y
+CONFIG_CRYPTO=y
+# CONFIG_CRYPTO_HW is not set
diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 1939023..8f581c1 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -78,6 +78,11 @@ config ARCH_AT91SAM9G45
 	select HAVE_FB_ATMEL
 	select HAVE_NET_MACB
 
+config ARCH_AT91SAM9X5
+	bool "AT91SAM9X5"
+	select CPU_ARM926T
+	select GENERIC_CLOCKEVENTS
+
 config ARCH_AT91CAP9
 	bool "AT91CAP9"
 	select CPU_ARM926T
@@ -425,6 +430,20 @@ endif
 
 # ----------------------------------------------------------
 
+if ARCH_AT91SAM9X5
+
+comment "AT91SAM9x5 Series Board Type"
+
+config MACH_AT91SAM9X5EK
+	bool "Atmel AT91SAM9x5 Series Evaluation Kit"
+	help
+	  Select this if you re using Atmel's AT91SAM9x5-EK Evaluation Kit.
+	  Supported chips are sam9g15, sam9g25, sam9x25, sam9g35 and sam9x35.
+endif
+# ----------------------------------------------------------
+
+# ----------------------------------------------------------
+
 if ARCH_AT91CAP9
 
 comment "AT91CAP9 Board Type"
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index a83835e..9489d77 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_ARCH_AT91SAM9263)	+= at91sam9263.o at91sam926x_time.o at91sam9263_d
 obj-$(CONFIG_ARCH_AT91SAM9RL)	+= at91sam9rl.o at91sam926x_time.o at91sam9rl_devices.o sam9_smc.o at91sam9_alt_reset.o
 obj-$(CONFIG_ARCH_AT91SAM9G20)	+= at91sam9260.o at91sam926x_time.o at91sam9260_devices.o sam9_smc.o at91sam9_alt_reset.o
 obj-$(CONFIG_ARCH_AT91SAM9G45)	+= at91sam9g45.o at91sam926x_time.o at91sam9g45_devices.o sam9_smc.o
+obj-$(CONFIG_ARCH_AT91SAM9X5)	+= at91sam9x5.o at91sam926x_time.o at91sam9x5_devices.o sam9_smc.o
 obj-$(CONFIG_ARCH_AT91CAP9)	+= at91cap9.o at91sam926x_time.o at91cap9_devices.o sam9_smc.o
 obj-$(CONFIG_ARCH_AT572D940HF)  += at572d940hf.o at91sam926x_time.o at572d940hf_devices.o sam9_smc.o
 obj-$(CONFIG_ARCH_AT91X40)	+= at91x40.o at91x40_time.o
@@ -75,6 +76,9 @@ obj-$(CONFIG_MACH_SNAPPER_9260)	+= board-snapper9260.o
 # AT91SAM9G45 board-specific support
 obj-$(CONFIG_MACH_AT91SAM9M10G45EK) += board-sam9m10g45ek.o
 
+# AT91SAM9X5 board-specific support
+obj-$(CONFIG_MACH_AT91SAM9X5EK) += board-sam9x5ek.o
+
 # AT91CAP9 board-specific support
 obj-$(CONFIG_MACH_AT91CAP9ADK)	+= board-cap9adk.o
 
diff --git a/arch/arm/mach-at91/at91sam9x5_devices.c b/arch/arm/mach-at91/at91sam9x5_devices.c
new file mode 100644
index 0000000..869f8fd
--- /dev/null
+++ b/arch/arm/mach-at91/at91sam9x5_devices.c
@@ -0,0 +1,1083 @@
+/*
+ *  On-Chip devices setup code for the AT91SAM9x5 family
+ *
+ *  Copyright (C) 2010 Atmel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <linux/i2c-gpio.h>
+
+#include <linux/fb.h>
+#include <video/atmel_lcdc.h>
+
+#include <mach/board.h>
+#include <mach/gpio.h>
+#include <mach/at91sam9x5.h>
+#include <mach/at91sam9x5_matrix.h>
+#include <mach/at91sam9_smc.h>
+#include <mach/at_hdmac.h>
+
+#include "generic.h"
+
+/* --------------------------------------------------------------------
+ *  HDMAC - AHB DMA Controller
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_AT_HDMAC) || defined(CONFIG_AT_HDMAC_MODULE)
+static u64 hdmac_dmamask = DMA_BIT_MASK(32);
+
+/* a single platform data for both DMA controllers as they share
+ * the same characteristics */
+static struct at_dma_platform_data atdma_pdata = {
+	.nr_channels	= 8,
+};
+
+static struct resource hdmac0_resources[] = {
+	[0] = {
+		.start	= AT91_BASE_SYS + AT91_DMA0,
+		.end	= AT91_BASE_SYS + AT91_DMA0 + SZ_512 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9X5_ID_DMA0,
+		.end	= AT91SAM9X5_ID_DMA0,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device at_hdmac0_device = {
+	.name		= "at_hdmac",
+	.id		= 0,
+	.dev		= {
+				.dma_mask		= &hdmac_dmamask,
+				.coherent_dma_mask	= DMA_BIT_MASK(32),
+				.platform_data		= &atdma_pdata,
+	},
+	.resource	= hdmac0_resources,
+	.num_resources	= ARRAY_SIZE(hdmac0_resources),
+};
+
+static struct resource hdmac1_resources[] = {
+	[0] = {
+		.start	= AT91_BASE_SYS + AT91_DMA1,
+		.end	= AT91_BASE_SYS + AT91_DMA1 + SZ_512 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9X5_ID_DMA1,
+		.end	= AT91SAM9X5_ID_DMA1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device at_hdmac1_device = {
+	.name	= "at_hdmac",
+	.id	= 1,
+	.dev	= {
+			.dma_mask			= &hdmac_dmamask,
+			.coherent_dma_mask		= DMA_BIT_MASK(32),
+			.platform_data			= &atdma_pdata,
+	},
+	.resource	= hdmac1_resources,
+	.num_resources	= ARRAY_SIZE(hdmac1_resources),
+};
+
+void __init at91_add_device_hdmac(void)
+{
+	dma_cap_set(DMA_MEMCPY, atdma_pdata.cap_mask);
+	dma_cap_set(DMA_SLAVE, atdma_pdata.cap_mask);
+	at91_clock_associate("dma0_clk", &at_hdmac0_device.dev, "dma_clk");
+	platform_device_register(&at_hdmac0_device);
+	at91_clock_associate("dma1_clk", &at_hdmac1_device.dev, "dma_clk");
+	platform_device_register(&at_hdmac1_device);
+}
+#else
+void __init at91_add_device_hdmac(void) {}
+#endif
+
+
+/* --------------------------------------------------------------------
+ *  USB Host (OHCI)
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+static u64 ohci_dmamask = DMA_BIT_MASK(32);
+static struct at91_usbh_data usbh_ohci_data;
+
+static struct resource usbh_ohci_resources[] = {
+	[0] = {
+		.start	= AT91SAM9X5_OHCI_BASE,
+		.end	= AT91SAM9X5_OHCI_BASE + SZ_1M - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9X5_ID_UHPHS,
+		.end	= AT91SAM9X5_ID_UHPHS,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device at91_usbh_ohci_device = {
+	.name		= "at91_ohci",
+	.id		= -1,
+	.dev		= {
+				.dma_mask		= &ohci_dmamask,
+				.coherent_dma_mask	= DMA_BIT_MASK(32),
+				.platform_data		= &usbh_ohci_data,
+	},
+	.resource	= usbh_ohci_resources,
+	.num_resources	= ARRAY_SIZE(usbh_ohci_resources),
+};
+
+void __init at91_add_device_usbh_ohci(struct at91_usbh_data *data)
+{
+	int i;
+
+	if (!data)
+		return;
+
+	/* Enable VBus control for UHP ports */
+	for (i = 0; i < data->ports; i++) {
+		if (data->vbus_pin[i])
+			at91_set_gpio_output(data->vbus_pin[i], 0);
+	}
+
+	usbh_ohci_data = *data;
+	platform_device_register(&at91_usbh_ohci_device);
+}
+#else
+void __init at91_add_device_usbh_ohci(struct at91_usbh_data *data) {}
+#endif
+
+
+/* --------------------------------------------------------------------
+ *  USB Host HS (EHCI)
+ *  Needs an OHCI host for low and full speed management
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_EHCI_HCD_MODULE)
+static u64 ehci_dmamask = DMA_BIT_MASK(32);
+static struct at91_usbh_data usbh_ehci_data;
+
+static struct resource usbh_ehci_resources[] = {
+	[0] = {
+		.start	= AT91SAM9X5_EHCI_BASE,
+		.end	= AT91SAM9X5_EHCI_BASE + SZ_1M - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9X5_ID_UHPHS,
+		.end	= AT91SAM9X5_ID_UHPHS,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device at91_usbh_ehci_device = {
+	.name		= "atmel-ehci",
+	.id		= -1,
+	.dev		= {
+				.dma_mask		= &ehci_dmamask,
+				.coherent_dma_mask	= DMA_BIT_MASK(32),
+				.platform_data		= &usbh_ehci_data,
+	},
+	.resource	= usbh_ehci_resources,
+	.num_resources	= ARRAY_SIZE(usbh_ehci_resources),
+};
+
+void __init at91_add_device_usbh_ehci(struct at91_usbh_data *data)
+{
+	int i;
+
+	if (!data)
+		return;
+
+	/* Enable VBus control for UHP ports */
+	for (i = 0; i < data->ports; i++) {
+		if (data->vbus_pin[i])
+			at91_set_gpio_output(data->vbus_pin[i], 0);
+	}
+
+	usbh_ehci_data = *data;
+	at91_clock_associate("uhphs_clk", &at91_usbh_ehci_device.dev, "ehci_clk");
+	platform_device_register(&at91_usbh_ehci_device);
+}
+#else
+void __init at91_add_device_usbh_ehci(struct at91_usbh_data *data) {}
+#endif
+
+
+/* --------------------------------------------------------------------
+ *  USB HS Device (Gadget)
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_USB_GADGET_ATMEL_USBA) || defined(CONFIG_USB_GADGET_ATMEL_USBA_MODULE)
+static struct resource usba_udc_resources[] = {
+	[0] = {
+		.start	= AT91SAM9X5_UDPHS_FIFO,
+		.end	= AT91SAM9X5_UDPHS_FIFO + SZ_512K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9X5_BASE_UDPHS,
+		.end	= AT91SAM9X5_BASE_UDPHS + SZ_1K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[2] = {
+		.start	= AT91SAM9X5_ID_UDPHS,
+		.end	= AT91SAM9X5_ID_UDPHS,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+#define EP(nam, idx, maxpkt, maxbk, dma, isoc)			\
+	[idx] = {						\
+		.name		= nam,				\
+		.index		= idx,				\
+		.fifo_size	= maxpkt,			\
+		.nr_banks	= maxbk,			\
+		.can_dma	= dma,				\
+		.can_isoc	= isoc,				\
+	}
+
+static struct usba_ep_data usba_udc_ep[] __initdata = {
+	EP("ep0", 0, 64, 1, 0, 0),
+	EP("ep1", 1, 1024, 2, 1, 1),
+	EP("ep2", 2, 1024, 2, 1, 1),
+	EP("ep3", 3, 1024, 3, 1, 0),
+	EP("ep4", 4, 1024, 3, 1, 0),
+	EP("ep5", 5, 1024, 3, 1, 1),
+	EP("ep6", 6, 1024, 3, 1, 1),
+};
+
+#undef EP
+
+/*
+ * pdata doesn't have room for any endpoints, so we need to
+ * append room for the ones we need right after it.
+ */
+static struct {
+	struct usba_platform_data pdata;
+	struct usba_ep_data ep[7];
+} usba_udc_data;
+
+static struct platform_device at91_usba_udc_device = {
+	.name		= "atmel_usba_udc",
+	.id		= -1,
+	.dev		= {
+				.platform_data	= &usba_udc_data.pdata,
+	},
+	.resource	= usba_udc_resources,
+	.num_resources	= ARRAY_SIZE(usba_udc_resources),
+};
+
+void __init at91_add_device_usba(struct usba_platform_data *data)
+{
+	usba_udc_data.pdata.vbus_pin = -EINVAL;
+	usba_udc_data.pdata.num_ep = ARRAY_SIZE(usba_udc_ep);
+	memcpy(usba_udc_data.ep, usba_udc_ep, sizeof(usba_udc_ep));
+
+	if (data && data->vbus_pin > 0) {
+		at91_set_gpio_input(data->vbus_pin, 0);
+		at91_set_deglitch(data->vbus_pin, 1);
+		usba_udc_data.pdata.vbus_pin = data->vbus_pin;
+	}
+
+	/* Pullup pin is handled internally by USB device peripheral */
+
+	/* Clocks */
+	at91_clock_associate("utmi_clk", &at91_usba_udc_device.dev, "hclk");
+	at91_clock_associate("udphs_clk", &at91_usba_udc_device.dev, "pclk");
+
+	platform_device_register(&at91_usba_udc_device);
+}
+#else
+void __init at91_add_device_usba(struct usba_platform_data *data) {}
+#endif
+
+
+/* --------------------------------------------------------------------
+ *  NAND / SmartMedia
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_MTD_NAND_ATMEL) || defined(CONFIG_MTD_NAND_ATMEL_MODULE)
+static struct atmel_nand_data nand_data;
+
+#define NAND_BASE	AT91_CHIPSELECT_3
+
+static struct resource nand_resources[] = {
+	[0] = {
+		.start	= NAND_BASE,
+		.end	= NAND_BASE + SZ_256M - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91_BASE_SYS + AT91_PMECC,
+		.end	= AT91_BASE_SYS + AT91_PMECC + SZ_512 - 1,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
+static struct platform_device at91sam9x5_nand_device = {
+	.name		= "atmel_nand",
+	.id		= -1,
+	.dev		= {
+				.platform_data	= &nand_data,
+	},
+	.resource	= nand_resources,
+	.num_resources	= ARRAY_SIZE(nand_resources),
+};
+
+void __init at91_add_device_nand(struct atmel_nand_data *data)
+{
+	unsigned long csa;
+
+	if (!data)
+		return;
+
+	csa = at91_sys_read(AT91_MATRIX_EBICSA);
+	at91_sys_write(AT91_MATRIX_EBICSA, csa | AT91_MATRIX_EBI_CS3A_SMC_NANDFLASH);
+
+	/* enable pin */
+	if (data->enable_pin)
+		at91_set_gpio_output(data->enable_pin, 1);
+
+	/* ready/busy pin */
+	if (data->rdy_pin)
+		at91_set_gpio_input(data->rdy_pin, 1);
+
+	/* card detect pin */
+	if (data->det_pin)
+		at91_set_gpio_input(data->det_pin, 1);
+
+	nand_data = *data;
+	platform_device_register(&at91sam9x5_nand_device);
+}
+#else
+void __init at91_add_device_nand(struct atmel_nand_data *data) {}
+#endif
+
+/* --------------------------------------------------------------------
+ *  TWI (i2c)
+ * -------------------------------------------------------------------- */
+
+/*
+ * Prefer the GPIO code since the TWI controller isn't robust
+ * (gets overruns and underruns under load) and can only issue
+ * repeated STARTs in one scenario (the driver doesn't yet handle them).
+ */
+#if defined(CONFIG_I2C_GPIO) || defined(CONFIG_I2C_GPIO_MODULE)
+static struct i2c_gpio_platform_data pdata_i2c0 = {
+	.sda_pin		= AT91_PIN_PA30,
+	.sda_is_open_drain	= 1,
+	.scl_pin		= AT91_PIN_PA31,
+	.scl_is_open_drain	= 1,
+	.udelay			= 2,		/* ~100 kHz */
+};
+
+static struct platform_device at91sam9x5_twi0_device = {
+	.name			= "i2c-gpio",
+	.id			= 0,
+	.dev.platform_data	= &pdata_i2c0,
+};
+
+void __init at91_add_device_i2c(short i2c_id, struct i2c_board_info *devices, int nr_devices)
+{
+	i2c_register_board_info(i2c_id, devices, nr_devices);
+
+	if (i2c_id == 0) {
+		at91_set_GPIO_periph(AT91_PIN_PA30, 1);		/* TWD (SDA) */
+		at91_set_multi_drive(AT91_PIN_PA30, 1);
+
+		at91_set_GPIO_periph(AT91_PIN_PA31, 1);		/* TWCK (SCL) */
+		at91_set_multi_drive(AT91_PIN_PA31, 1);
+
+		platform_device_register(&at91sam9x5_twi0_device);
+	}
+}
+
+#elif defined(CONFIG_I2C_AT91) || defined(CONFIG_I2C_AT91_MODULE)
+static struct resource twi0_resources[] = {
+	[0] = {
+		.start	= AT91SAM9X5_BASE_TWI0,
+		.end	= AT91SAM9X5_BASE_TWI0 + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9X5_ID_TWI0,
+		.end	= AT91SAM9X5_ID_TWI0,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device at91sam9x5_twi0_device = {
+	.name		= "at91_i2c",
+	.id		= 0,
+	.resource	= twi0_resources,
+	.num_resources	= ARRAY_SIZE(twi0_resources),
+};
+
+void __init at91_add_device_i2c(short i2c_id, struct i2c_board_info *devices, int nr_devices)
+{
+	i2c_register_board_info(i2c_id, devices, nr_devices);
+
+	/* pins used for TWI interface */
+	if (i2c_id == 0) {
+		at91_set_A_periph(AT91_PIN_PA30, 0);		/* TWD */
+		at91_set_multi_drive(AT91_PIN_PA30, 1);
+
+		at91_set_A_periph(AT91_PIN_PA31, 0);		/* TWCK */
+		at91_set_multi_drive(AT91_PIN_PA31, 1);
+
+		platform_device_register(&at91sam9x5_twi0_device);
+	}
+}
+#else
+void __init at91_add_device_i2c(short i2c_id, struct i2c_board_info *devices, int nr_devices) {}
+#endif
+
+/* --------------------------------------------------------------------
+ *  SPI
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_SPI_ATMEL) || defined(CONFIG_SPI_ATMEL_MODULE)
+static u64 spi_dmamask = DMA_BIT_MASK(32);
+
+static struct resource spi0_resources[] = {
+	[0] = {
+		.start	= AT91SAM9X5_BASE_SPI0,
+		.end	= AT91SAM9X5_BASE_SPI0 + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9X5_ID_SPI0,
+		.end	= AT91SAM9X5_ID_SPI0,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device at91sam9x5_spi0_device = {
+	.name		= "atmel_spi",
+	.id		= 0,
+	.dev		= {
+				.dma_mask		= &spi_dmamask,
+				.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+	.resource	= spi0_resources,
+	.num_resources	= ARRAY_SIZE(spi0_resources),
+};
+
+static const unsigned spi0_standard_cs[4] = { AT91_PIN_PA14, AT91_PIN_PA7, AT91_PIN_PA1, AT91_PIN_PB3 };
+
+static struct resource spi1_resources[] = {
+	[0] = {
+		.start	= AT91SAM9X5_BASE_SPI1,
+		.end	= AT91SAM9X5_BASE_SPI1 + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9X5_ID_SPI1,
+		.end	= AT91SAM9X5_ID_SPI1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device at91sam9x5_spi1_device = {
+	.name		= "atmel_spi",
+	.id		= 1,
+	.dev		= {
+				.dma_mask		= &spi_dmamask,
+				.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+	.resource	= spi1_resources,
+	.num_resources	= ARRAY_SIZE(spi1_resources),
+};
+
+static const unsigned spi1_standard_cs[4] = { AT91_PIN_PA8, AT91_PIN_PA0, AT91_PIN_PA31, AT91_PIN_PA30 };
+
+void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
+{
+	int i;
+	unsigned long cs_pin;
+	short enable_spi0 = 0;
+	short enable_spi1 = 0;
+
+	/* Choose SPI chip-selects */
+	for (i = 0; i < nr_devices; i++) {
+		if (devices[i].controller_data)
+			cs_pin = (unsigned long) devices[i].controller_data;
+		else if (devices[i].bus_num == 0)
+			cs_pin = spi0_standard_cs[devices[i].chip_select];
+		else
+			cs_pin = spi1_standard_cs[devices[i].chip_select];
+
+		if (devices[i].bus_num == 0)
+			enable_spi0 = 1;
+		else
+			enable_spi1 = 1;
+
+		/* enable chip-select pin */
+		at91_set_gpio_output(cs_pin, 1);
+
+		/* pass chip-select pin to driver */
+		devices[i].controller_data = (void *) cs_pin;
+	}
+
+	spi_register_board_info(devices, nr_devices);
+
+	/* Configure SPI bus(es) */
+	if (enable_spi0) {
+		at91_set_A_periph(AT91_PIN_PA11, 0);	/* SPI0_MISO */
+		at91_set_A_periph(AT91_PIN_PA12, 0);	/* SPI0_MOSI */
+		at91_set_A_periph(AT91_PIN_PA13, 0);	/* SPI0_SPCK */
+
+		at91_clock_associate("spi0_clk", &at91sam9x5_spi0_device.dev, "spi_clk");
+		platform_device_register(&at91sam9x5_spi0_device);
+	}
+	if (enable_spi1) {
+		at91_set_B_periph(AT91_PIN_PA21, 0);	/* SPI1_MISO */
+		at91_set_B_periph(AT91_PIN_PA22, 0);	/* SPI1_MOSI */
+		at91_set_B_periph(AT91_PIN_PA23, 0);	/* SPI1_SPCK */
+
+		at91_clock_associate("spi1_clk", &at91sam9x5_spi1_device.dev, "spi_clk");
+		platform_device_register(&at91sam9x5_spi1_device);
+	}
+}
+#else
+void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices) {}
+#endif
+
+/* --------------------------------------------------------------------
+ *  Timer/Counter block
+ * -------------------------------------------------------------------- */
+
+#ifdef CONFIG_ATMEL_TCLIB
+static struct resource tcb0_resources[] = {
+	[0] = {
+		.start	= AT91SAM9X5_BASE_TCB0,
+		.end	= AT91SAM9X5_BASE_TCB0 + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9X5_ID_TCB,
+		.end	= AT91SAM9X5_ID_TCB,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device at91sam9x5_tcb0_device = {
+	.name		= "atmel_tcb",
+	.id		= 0,
+	.resource	= tcb0_resources,
+	.num_resources	= ARRAY_SIZE(tcb0_resources),
+};
+
+/* TCB1 begins with TC3 */
+static struct resource tcb1_resources[] = {
+	[0] = {
+		.start	= AT91SAM9X5_BASE_TCB1,
+		.end	= AT91SAM9X5_BASE_TCB1 + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9X5_ID_TCB,
+		.end	= AT91SAM9X5_ID_TCB,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device at91sam9x5_tcb1_device = {
+	.name		= "atmel_tcb",
+	.id		= 1,
+	.resource	= tcb1_resources,
+	.num_resources	= ARRAY_SIZE(tcb1_resources),
+};
+
+static void __init at91_add_device_tc(void)
+{
+	/* this chip has one clock and irq for all six TC channels */
+	at91_clock_associate("tcb0_clk", &at91sam9x5_tcb0_device.dev, "t0_clk");
+	platform_device_register(&at91sam9x5_tcb0_device);
+	at91_clock_associate("tcb1_clk", &at91sam9x5_tcb1_device.dev, "t0_clk");
+	platform_device_register(&at91sam9x5_tcb1_device);
+}
+#else
+static void __init at91_add_device_tc(void) { }
+#endif
+
+/* --------------------------------------------------------------------
+ *  RTC
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_RTC_DRV_AT91RM9200) || defined(CONFIG_RTC_DRV_AT91RM9200_MODULE)
+static struct platform_device at91sam9x5_rtc_device = {
+	.name		= "at91_rtc",
+	.id		= -1,
+	.num_resources	= 0,
+};
+
+static void __init at91_add_device_rtc(void)
+{
+	platform_device_register(&at91sam9x5_rtc_device);
+}
+#else
+static void __init at91_add_device_rtc(void) {}
+#endif
+
+/* --------------------------------------------------------------------
+ *  Watchdog
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
+static struct platform_device at91sam9x5_wdt_device = {
+	.name		= "at91_wdt",
+	.id		= -1,
+	.num_resources	= 0,
+};
+
+static void __init at91_add_device_watchdog(void)
+{
+	platform_device_register(&at91sam9x5_wdt_device);
+}
+#else
+static void __init at91_add_device_watchdog(void) {}
+#endif
+
+
+/* --------------------------------------------------------------------
+ *  PWM
+ * --------------------------------------------------------------------*/
+
+#if defined(CONFIG_ATMEL_PWM) || defined(CONFIG_ATMEL_PWM_MODULE)
+static u32 pwm_mask;
+
+static struct resource pwm_resources[] = {
+	[0] = {
+		.start	= AT91SAM9X5_BASE_PWMC,
+		.end	= AT91SAM9X5_BASE_PWMC + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9X5_ID_PWMC,
+		.end	= AT91SAM9X5_ID_PWMC,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device at91sam9x5_pwm_device = {
+	.name	= "atmel_pwm",
+	.id	= -1,
+	.dev	= {
+		.platform_data		= &pwm_mask,
+	},
+	.resource	= pwm_resources,
+	.num_resources	= ARRAY_SIZE(pwm_resources),
+};
+
+void __init at91_add_device_pwm(u32 mask)
+{
+	if (mask & (1 << AT91_PWM0))
+		at91_set_B_periph(AT91_PIN_PB11, 1);	/* enable PWM0 */
+
+	if (mask & (1 << AT91_PWM1))
+		at91_set_B_periph(AT91_PIN_PB12, 1);	/* enable PWM1 */
+
+	if (mask & (1 << AT91_PWM2))
+		at91_set_B_periph(AT91_PIN_PB13, 1);	/* enable PWM2 */
+
+	if (mask & (1 << AT91_PWM3))
+		at91_set_B_periph(AT91_PIN_PB14, 1);	/* enable PWM3 */
+
+	pwm_mask = mask;
+
+	platform_device_register(&at91sam9x5_pwm_device);
+}
+#else
+void __init at91_add_device_pwm(u32 mask) {}
+#endif
+
+
+/* --------------------------------------------------------------------
+ *  SSC -- Synchronous Serial Controller
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_ATMEL_SSC) || defined(CONFIG_ATMEL_SSC_MODULE)
+static u64 ssc_dmamask = DMA_BIT_MASK(32);
+
+static struct resource ssc_resources[] = {
+	[0] = {
+		.start	= AT91SAM9X5_BASE_SSC,
+		.end	= AT91SAM9X5_BASE_SSC + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9X5_ID_SSC,
+		.end	= AT91SAM9X5_ID_SSC,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device at91sam9x5_ssc_device = {
+	.name	= "ssc",
+	.id	= 0,
+	.dev	= {
+		.dma_mask		= &ssc_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+	.resource	= ssc_resources,
+	.num_resources	= ARRAY_SIZE(ssc_resources),
+};
+
+static inline void configure_ssc_pins(unsigned pins)
+{
+	if (pins & ATMEL_SSC_TF)
+		at91_set_B_periph(AT91_PIN_PA25, 1);
+	if (pins & ATMEL_SSC_TK)
+		at91_set_B_periph(AT91_PIN_PA24, 1);
+	if (pins & ATMEL_SSC_TD)
+		at91_set_B_periph(AT91_PIN_PA26, 1);
+	if (pins & ATMEL_SSC_RD)
+		at91_set_B_periph(AT91_PIN_PA27, 1);
+	if (pins & ATMEL_SSC_RK)
+		at91_set_B_periph(AT91_PIN_PA28, 1);
+	if (pins & ATMEL_SSC_RF)
+		at91_set_B_periph(AT91_PIN_PA29, 1);
+}
+
+/*
+ * SSC controllers are accessed through library code, instead of any
+ * kind of all-singing/all-dancing driver.  For example one could be
+ * used by a particular I2S audio codec's driver, while another one
+ * on the same system might be used by a custom data capture driver.
+ */
+void __init at91_add_device_ssc(unsigned id, unsigned pins)
+{
+	struct platform_device *pdev;
+
+	/*
+	 * NOTE: caller is responsible for passing information matching
+	 * "pins" to whatever will be using each particular controller.
+	 */
+	if (id == AT91SAM9X5_ID_SSC) {
+		pdev = &at91sam9x5_ssc_device;
+		configure_ssc_pins(pins);
+		at91_clock_associate("ssc_clk", &pdev->dev, "pclk");
+	}
+	else
+		return;
+
+	platform_device_register(pdev);
+}
+
+#else
+void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
+#endif
+
+
+/* --------------------------------------------------------------------
+ *  UART
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_SERIAL_ATMEL)
+static struct resource dbgu_resources[] = {
+	[0] = {
+		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
+		.end	= AT91_VA_BASE_SYS + AT91_DBGU + SZ_512 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91_ID_SYS,
+		.end	= AT91_ID_SYS,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct atmel_uart_data dbgu_data = {
+	.use_dma_tx	= 0,
+	.use_dma_rx	= 0,
+	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
+};
+
+static u64 dbgu_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device at91sam9x5_dbgu_device = {
+	.name		= "atmel_usart",
+	.id		= 0,
+	.dev		= {
+				.dma_mask		= &dbgu_dmamask,
+				.coherent_dma_mask	= DMA_BIT_MASK(32),
+				.platform_data		= &dbgu_data,
+	},
+	.resource	= dbgu_resources,
+	.num_resources	= ARRAY_SIZE(dbgu_resources),
+};
+
+static inline void configure_dbgu_pins(void)
+{
+	at91_set_A_periph(AT91_PIN_PA9, 0);		/* DRXD */
+	at91_set_A_periph(AT91_PIN_PA10, 1);		/* DTXD */
+}
+
+static struct resource usart0_resources[] = {
+	[0] = {
+		.start	= AT91SAM9X5_BASE_USART0,
+		.end	= AT91SAM9X5_BASE_USART0 + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9X5_ID_USART0,
+		.end	= AT91SAM9X5_ID_USART0,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct atmel_uart_data usart0_data = {
+	.use_dma_tx	= 1,
+	.use_dma_rx	= 1,
+};
+
+static u64 usart0_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device at91sam9x5_usart0_device = {
+	.name		= "atmel_usart",
+	.id		= 1,
+	.dev		= {
+				.dma_mask		= &usart0_dmamask,
+				.coherent_dma_mask	= DMA_BIT_MASK(32),
+				.platform_data		= &usart0_data,
+	},
+	.resource	= usart0_resources,
+	.num_resources	= ARRAY_SIZE(usart0_resources),
+};
+
+static inline void configure_usart0_pins(unsigned pins)
+{
+	at91_set_A_periph(AT91_PIN_PA0, 1);		/* TXD0 */
+	at91_set_A_periph(AT91_PIN_PA1, 0);		/* RXD0 */
+
+	if (pins & ATMEL_UART_RTS)
+		at91_set_A_periph(AT91_PIN_PA2, 0);	/* RTS0 */
+	if (pins & ATMEL_UART_CTS)
+		at91_set_A_periph(AT91_PIN_PA3, 0);	/* CTS0 */
+}
+
+
+static struct resource usart1_resources[] = {
+	[0] = {
+		.start	= AT91SAM9X5_BASE_USART1,
+		.end	= AT91SAM9X5_BASE_USART1 + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9X5_ID_USART1,
+		.end	= AT91SAM9X5_ID_USART1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct atmel_uart_data usart1_data = {
+	.use_dma_tx	= 1,
+	.use_dma_rx	= 1,
+};
+
+static u64 usart1_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device at91sam9x5_usart1_device = {
+	.name		= "atmel_usart",
+	.id		= 2,
+	.dev		= {
+				.dma_mask		= &usart1_dmamask,
+				.coherent_dma_mask	= DMA_BIT_MASK(32),
+				.platform_data		= &usart1_data,
+	},
+	.resource	= usart1_resources,
+	.num_resources	= ARRAY_SIZE(usart1_resources),
+};
+
+static inline void configure_usart1_pins(unsigned pins)
+{
+	at91_set_A_periph(AT91_PIN_PA5, 1);		/* TXD1 */
+	at91_set_A_periph(AT91_PIN_PA6, 0);		/* RXD1 */
+
+	if (pins & ATMEL_UART_RTS)
+		at91_set_C_periph(AT91_PIN_PC27, 0);	/* RTS1 */
+	if (pins & ATMEL_UART_CTS)
+		at91_set_C_periph(AT91_PIN_PC28, 0);	/* CTS1 */
+}
+
+static struct resource usart2_resources[] = {
+	[0] = {
+		.start	= AT91SAM9X5_BASE_USART2,
+		.end	= AT91SAM9X5_BASE_USART2 + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9X5_ID_USART2,
+		.end	= AT91SAM9X5_ID_USART2,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct atmel_uart_data usart2_data = {
+	.use_dma_tx	= 1,
+	.use_dma_rx	= 1,
+};
+
+static u64 usart2_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device at91sam9x5_usart2_device = {
+	.name		= "atmel_usart",
+	.id		= 3,
+	.dev		= {
+				.dma_mask		= &usart2_dmamask,
+				.coherent_dma_mask	= DMA_BIT_MASK(32),
+				.platform_data		= &usart2_data,
+	},
+	.resource	= usart2_resources,
+	.num_resources	= ARRAY_SIZE(usart2_resources),
+};
+
+static inline void configure_usart2_pins(unsigned pins)
+{
+	at91_set_A_periph(AT91_PIN_PA7, 1);		/* TXD2 */
+	at91_set_A_periph(AT91_PIN_PA8, 0);		/* RXD2 */
+
+	if (pins & ATMEL_UART_RTS)
+		at91_set_B_periph(AT91_PIN_PB0, 0);	/* RTS2 */
+	if (pins & ATMEL_UART_CTS)
+		at91_set_B_periph(AT91_PIN_PB1, 0);	/* CTS2 */
+}
+
+static struct resource usart3_resources[] = {
+	[0] = {
+		.start	= AT91SAM9X5_BASE_USART3,
+		.end	= AT91SAM9X5_BASE_USART3 + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9X5_ID_USART3,
+		.end	= AT91SAM9X5_ID_USART3,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct atmel_uart_data usart3_data = {
+	.use_dma_tx	= 1,
+	.use_dma_rx	= 1,
+};
+
+static u64 usart3_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device at91sam9x5_usart3_device = {
+	.name		= "atmel_usart",
+	.id		= 4,
+	.dev		= {
+				.dma_mask		= &usart3_dmamask,
+				.coherent_dma_mask	= DMA_BIT_MASK(32),
+				.platform_data		= &usart3_data,
+	},
+	.resource	= usart3_resources,
+	.num_resources	= ARRAY_SIZE(usart3_resources),
+};
+
+static inline void configure_usart3_pins(unsigned pins)
+{
+	at91_set_B_periph(AT91_PIN_PC22, 1);		/* TXD3 */
+	at91_set_B_periph(AT91_PIN_PC23, 0);		/* RXD3 */
+
+	if (pins & ATMEL_UART_RTS)
+		at91_set_B_periph(AT91_PIN_PC24, 0);	/* RTS3 */
+	if (pins & ATMEL_UART_CTS)
+		at91_set_B_periph(AT91_PIN_PC25, 0);	/* CTS3 */
+}
+
+static struct platform_device *__initdata at91_usarts[ATMEL_MAX_UART];	/* the USARTs to use */
+struct platform_device *atmel_default_console_device;	/* the serial console device */
+
+void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
+{
+	struct platform_device *pdev;
+
+	switch (id) {
+		case 0:		/* DBGU */
+			pdev = &at91sam9x5_dbgu_device;
+			configure_dbgu_pins();
+			at91_clock_associate("mck", &pdev->dev, "usart");
+			break;
+		case AT91SAM9X5_ID_USART0:
+			pdev = &at91sam9x5_usart0_device;
+			configure_usart0_pins(pins);
+			at91_clock_associate("usart0_clk", &pdev->dev, "usart");
+			break;
+		case AT91SAM9X5_ID_USART1:
+			pdev = &at91sam9x5_usart1_device;
+			configure_usart1_pins(pins);
+			at91_clock_associate("usart1_clk", &pdev->dev, "usart");
+			break;
+		case AT91SAM9X5_ID_USART2:
+			pdev = &at91sam9x5_usart2_device;
+			configure_usart2_pins(pins);
+			at91_clock_associate("usart2_clk", &pdev->dev, "usart");
+			break;
+		case AT91SAM9X5_ID_USART3:
+			pdev = &at91sam9x5_usart3_device;
+			configure_usart3_pins(pins);
+			at91_clock_associate("usart3_clk", &pdev->dev, "usart");
+			break;
+		default:
+			return;
+	}
+	pdev->id = portnr;		/* update to mapped ID */
+
+	if (portnr < ATMEL_MAX_UART)
+		at91_usarts[portnr] = pdev;
+}
+
+void __init at91_set_serial_console(unsigned portnr)
+{
+	if (portnr < ATMEL_MAX_UART)
+		atmel_default_console_device = at91_usarts[portnr];
+}
+
+void __init at91_add_device_serial(void)
+{
+	int i;
+
+	for (i = 0; i < ATMEL_MAX_UART; i++) {
+		if (at91_usarts[i])
+			platform_device_register(at91_usarts[i]);
+	}
+
+	if (!atmel_default_console_device)
+		printk(KERN_INFO "AT91: No default serial console defined.\n");
+}
+#else
+void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins) {}
+void __init at91_set_serial_console(unsigned portnr) {}
+void __init at91_add_device_serial(void) {}
+#endif
+
+
+/* -------------------------------------------------------------------- */
+/*
+ * These devices are always present and don't need any board-specific
+ * setup.
+ */
+static int __init at91_add_standard_devices(void)
+{
+	at91_add_device_hdmac();
+	at91_add_device_rtc();
+	at91_add_device_watchdog();
+	at91_add_device_tc();
+	return 0;
+}
+
+arch_initcall(at91_add_standard_devices);
diff --git a/arch/arm/mach-at91/board-sam9x5ek.c b/arch/arm/mach-at91/board-sam9x5ek.c
new file mode 100644
index 0000000..35fff40
--- /dev/null
+++ b/arch/arm/mach-at91/board-sam9x5ek.c
@@ -0,0 +1,243 @@
+/*
+ * Board-specific setup code for the AT91SAM9x5 Evaluation Kit family
+ *
+ * Copyright (C) 2010 Atmel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/fb.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
+#include <linux/leds.h>
+#include <linux/clk.h>
+
+#include <video/atmel_lcdc.h>
+
+#include <asm/setup.h>
+#include <asm/mach-types.h>
+#include <asm/irq.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/irq.h>
+
+#include <mach/hardware.h>
+#include <mach/board.h>
+#include <mach/gpio.h>
+#include <mach/at91sam9_smc.h>
+#include <mach/at91_shdwc.h>
+
+#include "sam9_smc.h"
+#include "generic.h"
+
+
+static void __init ek_map_io(void)
+{
+	/* Initialize processor: 12.000 MHz crystal */
+	at91sam9x5_initialize(12000000);
+
+	/* DGBU on ttyS0. (Rx & Tx only) */
+	at91_register_uart(0, 0, 0);
+
+	/* USART0 not connected on the -EK board */
+	/* USART1 on ttyS2. (Rx, Tx, RTS, CTS) */
+	at91_register_uart(AT91SAM9X5_ID_USART1, 2, ATMEL_UART_CTS | ATMEL_UART_RTS);
+
+	/* set serial console to ttyS0 (ie, DBGU) */
+	at91_set_serial_console(0);
+}
+
+static void __init ek_init_irq(void)
+{
+	at91sam9x5_init_interrupts(NULL);
+}
+
+
+/*
+ * USB HS Host port (common to OHCI & EHCI)
+ */
+static struct at91_usbh_data __initdata ek_usbh_hs_data = {
+	.ports		= 2,
+	.vbus_pin	= {AT91_PIN_PC0, },
+};
+
+
+/*
+ * USB HS Device port
+ */
+static struct usba_platform_data __initdata ek_usba_udc_data = {
+	.vbus_pin	= AT91_PIN_PC0,
+};
+
+
+/*
+ * SPI devices.
+ */
+static struct spi_board_info ek_spi_devices[] = {
+	{	/* DataFlash chip */
+		.modalias	= "mtd_dataflash",
+		.chip_select	= 0,
+		.max_speed_hz	= 15 * 1000 * 1000,
+		.bus_num	= 0,
+	},
+};
+
+
+/*
+ * NAND flash
+ */
+static struct mtd_partition __initdata ek_nand_partition[] = {
+	{
+		.name	= "Partition 1",
+		.offset	= 0,
+		.size	= SZ_64M,
+	},
+	{
+		.name	= "Partition 2",
+		.offset	= MTDPART_OFS_NXTBLK,
+		.size	= MTDPART_SIZ_FULL,
+	},
+};
+
+static struct mtd_partition * __init nand_partitions(int size, int *num_partitions)
+{
+	*num_partitions = ARRAY_SIZE(ek_nand_partition);
+	return ek_nand_partition;
+}
+
+/* det_pin is not connected */
+static struct atmel_nand_data __initdata ek_nand_data = {
+	.ale		= 21,
+	.cle		= 22,
+	.rdy_pin	= AT91_PIN_PC8,
+	.enable_pin	= AT91_PIN_PC14,
+	.partition_info	= nand_partitions,
+#if defined(CONFIG_MTD_NAND_AT91_BUSWIDTH_16)
+	.bus_width_16	= 1,
+#else
+	.bus_width_16	= 0,
+#endif
+};
+
+static struct sam9_smc_config __initdata ek_nand_smc_config = {
+	.ncs_read_setup		= 0,
+	.nrd_setup		= 2,
+	.ncs_write_setup	= 0,
+	.nwe_setup		= 2,
+
+	.ncs_read_pulse		= 4,
+	.nrd_pulse		= 4,
+	.ncs_write_pulse	= 4,
+	.nwe_pulse		= 4,
+
+	.read_cycle		= 7,
+	.write_cycle		= 7,
+
+	.mode			= AT91_SMC_READMODE | AT91_SMC_WRITEMODE | AT91_SMC_EXNWMODE_DISABLE,
+	.tdf_cycles		= 3,
+};
+
+static void __init ek_add_device_nand(void)
+{
+	/* setup bus-width (8 or 16) */
+	if (ek_nand_data.bus_width_16)
+		ek_nand_smc_config.mode |= AT91_SMC_DBW_16;
+	else
+		ek_nand_smc_config.mode |= AT91_SMC_DBW_8;
+
+	/* configure chip-select 3 (NAND) */
+	sam9_smc_configure(3, &ek_nand_smc_config);
+
+	at91_add_device_nand(&ek_nand_data);
+}
+
+
+/*
+ * GPIO Buttons
+ */
+#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
+static struct gpio_keys_button ek_buttons[] = {
+	{	/* BP4, "leftclic" */
+		.code		= BTN_LEFT,
+		.gpio		= AT91_PIN_PC3,
+		.active_low	= 1,
+		.desc		= "left_click",
+		.wakeup		= 1,
+	},
+	{	/* BP3, "rightclic" */
+		.code		= BTN_RIGHT,
+		.gpio		= AT91_PIN_PC2,
+		.active_low	= 1,
+		.desc		= "right_click",
+		.wakeup		= 1,
+	},
+};
+
+static struct gpio_keys_platform_data ek_button_data = {
+	.buttons	= ek_buttons,
+	.nbuttons	= ARRAY_SIZE(ek_buttons),
+};
+
+static struct platform_device ek_button_device = {
+	.name		= "gpio-keys",
+	.id		= -1,
+	.num_resources	= 0,
+	.dev		= {
+		.platform_data	= &ek_button_data,
+	}
+};
+
+static void __init ek_add_device_buttons(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ek_buttons); i++) {
+		at91_set_GPIO_periph(ek_buttons[i].gpio, 1);
+		at91_set_deglitch(ek_buttons[i].gpio, 1);
+	}
+
+	platform_device_register(&ek_button_device);
+}
+#else
+static void __init ek_add_device_buttons(void) {}
+#endif
+
+
+static void __init ek_board_init(void)
+{
+	/* Serial */
+	at91_add_device_serial();
+	/* USB HS Host */
+	at91_add_device_usbh_ohci(&ek_usbh_hs_data);
+	at91_add_device_usbh_ehci(&ek_usbh_hs_data);
+	/* USB HS Device */
+	at91_add_device_usba(&ek_usba_udc_data);
+	/* SPI */
+	at91_add_device_spi(ek_spi_devices, ARRAY_SIZE(ek_spi_devices));
+	/* NAND */
+	ek_add_device_nand();
+	/* I2C */
+	at91_add_device_i2c(0, NULL, 0);
+	/* Push Buttons */
+	ek_add_device_buttons();
+}
+
+MACHINE_START(AT91SAM9X5EK, "Atmel AT91SAM9X5-EK")
+	/* Maintainer: Atmel */
+	.boot_params	= AT91_SDRAM_BASE + 0x100,
+	.timer		= &at91sam926x_timer,
+	.map_io		= ek_map_io,
+	.init_irq	= ek_init_irq,
+	.init_machine	= ek_board_init,
+MACHINE_END
diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index 6c92db8..140d11b 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -502,9 +502,11 @@ static int at91_clk_show(struct seq_file *s, void *unused)
 		else
 			state = "";
 
+#if 0
 		seq_printf(s, "%-10s users=%2d %-3s %9ld Hz %s\n",
 			clk->name, clk->users, state, clk_get_rate(clk),
 			clk->parent ? clk->parent->name : "");
+#endif
 	}
 	return 0;
 }
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 0c66deb..a775336 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -15,6 +15,7 @@ extern void __init at91sam9261_initialize(unsigned long main_clock);
 extern void __init at91sam9263_initialize(unsigned long main_clock);
 extern void __init at91sam9rl_initialize(unsigned long main_clock);
 extern void __init at91sam9g45_initialize(unsigned long main_clock);
+extern void __init at91sam9x5_initialize(unsigned long main_clock);
 extern void __init at91x40_initialize(unsigned long main_clock);
 extern void __init at91cap9_initialize(unsigned long main_clock);
 extern void __init at572d940hf_initialize(unsigned long main_clock);
@@ -26,6 +27,7 @@ extern void __init at91sam9261_init_interrupts(unsigned int priority[]);
 extern void __init at91sam9263_init_interrupts(unsigned int priority[]);
 extern void __init at91sam9rl_init_interrupts(unsigned int priority[]);
 extern void __init at91sam9g45_init_interrupts(unsigned int priority[]);
+extern void __init at91sam9x5_init_interrupts(unsigned int priority[]);
 extern void __init at91x40_init_interrupts(unsigned int priority[]);
 extern void __init at91cap9_init_interrupts(unsigned int priority[]);
 extern void __init at572d940hf_init_interrupts(unsigned int priority[]);
diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
index 2b499eb..94a43fd 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -117,7 +117,7 @@ struct atmel_nand_data {
 extern void __init at91_add_device_nand(struct atmel_nand_data *data);
 
  /* I2C*/
-#if defined(CONFIG_ARCH_AT91SAM9G45)
+#if defined(CONFIG_ARCH_AT91SAM9G45) || defined(CONFIG_ARCH_AT91SAM9X5)
 extern void __init at91_add_device_i2c(short i2c_id, struct i2c_board_info *devices, int nr_devices);
 #else
 extern void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices);
diff --git a/arch/arm/mach-at91/include/mach/hardware.h b/arch/arm/mach-at91/include/mach/hardware.h
index 3d64a75..6e270c2 100644
--- a/arch/arm/mach-at91/include/mach/hardware.h
+++ b/arch/arm/mach-at91/include/mach/hardware.h
@@ -28,6 +28,8 @@
 #include <mach/at91sam9rl.h>
 #elif defined(CONFIG_ARCH_AT91SAM9G45)
 #include <mach/at91sam9g45.h>
+#elif defined(CONFIG_ARCH_AT91SAM9X5)
+#include <mach/at91sam9x5.h>
 #elif defined(CONFIG_ARCH_AT91CAP9)
 #include <mach/at91cap9.h>
 #elif defined(CONFIG_ARCH_AT91X40)
diff --git a/arch/arm/mach-at91/include/mach/timex.h b/arch/arm/mach-at91/include/mach/timex.h
index 05a6e8a..23df905 100644
--- a/arch/arm/mach-at91/include/mach/timex.h
+++ b/arch/arm/mach-at91/include/mach/timex.h
@@ -72,6 +72,11 @@
 #define AT91SAM9_MASTER_CLOCK	133333333
 #define CLOCK_TICK_RATE		(AT91SAM9_MASTER_CLOCK/16)
 
+#elif defined(CONFIG_ARCH_AT91SAM9X5)
+
+#define AT91SAM9_MASTER_CLOCK	133333333
+#define CLOCK_TICK_RATE		(AT91SAM9_MASTER_CLOCK/16)
+
 #elif defined(CONFIG_ARCH_AT91CAP9)
 
 #define AT91CAP9_MASTER_CLOCK	100000000
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index ce9a206..b93f259 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -79,6 +79,25 @@ static inline u32 sdram_selfrefresh_enable(void)
 	} while (0)
 #define wait_for_interrupt_enable()		cpu_do_idle()
 
+#elif defined(CONFIG_ARCH_AT91SAM9X5)
+#include <mach/at91sam9_ddrsdr.h>
+
+static inline u32 sdram_selfrefresh_enable(void)
+{
+	u32 lpr, saved_lpr;
+
+	saved_lpr = at91_ramc_read(0, AT91_DDRSDRC_LPR);
+	lpr = saved_lpr & ~AT91_DDRSDRC_LPCB;
+	lpr |= AT91_DDRSDRC_LPCB_SELF_REFRESH;
+
+	at91_ramc_write(0, AT91_DDRSDRC_LPR, lpr);
+
+	return saved_lpr;
+}
+
+#define sdram_selfrefresh_disable(saved_lpr)	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr)
+#define wait_for_interrupt_enable()		cpu_do_idle()
+
 #else
 #include <mach/at91sam9_sdramc.h>
 
diff --git a/arch/arm/mach-at91/pm_slowclock.S b/arch/arm/mach-at91/pm_slowclock.S
index f7922a4..1a44c98 100644
--- a/arch/arm/mach-at91/pm_slowclock.S
+++ b/arch/arm/mach-at91/pm_slowclock.S
@@ -20,7 +20,7 @@
 #include <mach/at91rm9200_mc.h>
 #elif defined(CONFIG_ARCH_AT91CAP9)
 #include <mach/at91cap9_ddrsdr.h>
-#elif defined(CONFIG_ARCH_AT91SAM9G45)
+#elif defined(CONFIG_ARCH_AT91SAM9G45) || defined(CONFIG_ARCH_AT91SAM9X5)
 #include <mach/at91sam9_ddrsdr.h>
 #else
 #include <mach/at91sam9_sdramc.h>
@@ -132,7 +132,8 @@ ENTRY(at91_slow_clock)
 	mov	r3, #1
 	str	r3, [r2, #AT91_SDRAMC_SRR]
 #elif defined(CONFIG_ARCH_AT91CAP9) \
-	|| defined(CONFIG_ARCH_AT91SAM9G45)
+	|| defined(CONFIG_ARCH_AT91SAM9G45) \
+	|| defined(CONFIG_ARCH_AT91SAM9X5)
 
 	/* prepare for DDRAM self-refresh mode */
 	ldr	r3, [r2, #AT91_DDRSDRC_LPR]
@@ -265,7 +266,8 @@ ENTRY(at91_slow_clock)
 #ifdef CONFIG_ARCH_AT91RM9200
 	/* Do nothing - self-refresh is automatically disabled. */
 #elif defined(CONFIG_ARCH_AT91CAP9) \
-	|| defined(CONFIG_ARCH_AT91SAM9G45)
+	|| defined(CONFIG_ARCH_AT91SAM9G45) \
+	|| defined(CONFIG_ARCH_AT91SAM9X5)
 	/* Restore LPR on AT91 with DDRAM */
 	ldr	r3, .saved_sam9_lpr
 	str	r3, [r2, #AT91_DDRSDRC_LPR]
@@ -307,7 +309,8 @@ ENTRY(at91_slow_clock)
 .at91_va_base_sdramc:
 	.word AT91_VA_BASE_SYS
 #elif defined(CONFIG_ARCH_AT91CAP9) \
-	|| defined(CONFIG_ARCH_AT91SAM9G45)
+	|| defined(CONFIG_ARCH_AT91SAM9G45) \
+	|| defined(CONFIG_ARCH_AT91SAM9X5)
 .at91_va_base_sdramc:
 	.word AT91_VA_BASE_SYS + AT91_DDRSDRC0
 #else
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 1c28816..db1258f 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -91,7 +91,7 @@ config DW_DMAC
 
 config AT_HDMAC
 	tristate "Atmel AHB DMA support"
-	depends on ARCH_AT91SAM9RL || ARCH_AT91SAM9G45
+	depends on ARCH_AT91SAM9RL || ARCH_AT91SAM9G45 || ARCH_AT91SAM9X5
 	select DMA_ENGINE
 	help
 	  Support the Atmel AHB DMA controller.  This can be integrated in
-- 
1.7.4.1
