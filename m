From: tony@atomide.com (Tony Lindgren)
Date: Tue, 6 Mar 2018 11:31:44 -0800
Subject: [PATCH 02/10] ARM: omap2plus_defconfig: Add SERIAL_DEV for
 bluetooth
In-Reply-To: <20180301221704.104530-3-tony@atomide.com>
References: <20180301221704.104530-1-tony@atomide.com>
 <20180301221704.104530-3-tony@atomide.com>
Message-ID: <20180306193144.GD5799@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [180301 22:18]:
> We now have SERIAL_DEV that at least TI WLAN devices can use.
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -248,6 +250,7 @@ CONFIG_SERIAL_8250_RSA=y
>  CONFIG_SERIAL_OF_PLATFORM=y
>  CONFIG_SERIAL_OMAP=y
>  CONFIG_SERIAL_OMAP_CONSOLE=y
> +CONFIG_SERIAL_DEV_BUS=m
>  CONFIG_I2C_CHARDEV=y
>  CONFIG_SPI=y
>  CONFIG_SPI_OMAP24XX=y

This we actually want to have built-in, otherwise we don't
get SERIAL_DEV_CTRL_TTYPORT. Updated patch below.

Regards,

Tony

8< -------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 1 Mar 2018 10:47:35 -0800
Subject: [PATCH] ARM: omap2plus_defconfig: Add SERIAL_DEV for bluetooth

We now have SERIAL_DEV that at least TI WLAN devices can use.
We want SERIAL_DEV built-in, so we can also enable the option
for SERIAL_DEV_CTRL_TTYPORT.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -104,9 +104,11 @@ CONFIG_BT_HIDP=m
 CONFIG_BT_HCIBTUSB=m
 CONFIG_BT_HCIBTSDIO=m
 CONFIG_BT_HCIUART=m
+CONFIG_BT_HCIUART_NOKIA=m
 CONFIG_BT_HCIUART_BCSP=y
 CONFIG_BT_HCIUART_LL=y
 CONFIG_BT_HCIUART_3WIRE=y
+CONFIG_BT_HCIUART_BCM=y
 CONFIG_BT_HCIBCM203X=m
 CONFIG_BT_HCIBPA10X=m
 CONFIG_BT_HCIBFUSB=m
@@ -248,6 +250,7 @@ CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_OMAP=y
 CONFIG_SERIAL_OMAP_CONSOLE=y
+CONFIG_SERIAL_DEV_BUS=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_SPI=y
 CONFIG_SPI_OMAP24XX=y
-- 
2.16.2
