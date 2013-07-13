From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Sat, 13 Jul 2013 00:51:04 -0300
Subject: [PATCH] arm: multi_v7_defconfig: Tweaks for omap and sunxi
In-Reply-To: <1373685174-7918-1-git-send-email-olof@lixom.net>
References: <1373685174-7918-1-git-send-email-olof@lixom.net>
Message-ID: <51E0CEA8.2040201@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

El 13/07/13 00:12, Olof Johansson escribi?:
> OMAP recently changed how the platforms are configured, so OMAP2/3/4 SoC
> support is no longer enabled by default. Add them back.
> 
> Enable new ethernet driver for sunxi.

"ARM: multi_v7: Enable Allwinner EMAC in multi_v7_defconfig" by Maxime
already does this, and is on Linus Torvalds' tree:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=fb1c60288a886a28dc7c055449fd1936140fe891

> 
> The i.MX console options moved due to resorting, no functional change.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> 
> The OMAP changes are needed to deal with the dependency flip from OMAP2PLUS
> being on and defaulting the SoCs accordingly, to the SoC options selecting
> OMAP2PLUS. See the "ARM: OMAP2+: Remove board-4430sdp.c" for background.
> 
>  arch/arm/configs/multi_v7_defconfig | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 80aacc6..fcd2b9b 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -15,8 +15,10 @@ CONFIG_SOC_IMX53=y
>  CONFIG_SOC_IMX6Q=y
>  CONFIG_SOC_IMX6SL=y
>  CONFIG_SOC_VF610=y
> -CONFIG_ARCH_OMAP2PLUS=y
> +CONFIG_ARCH_OMAP3=y
> +CONFIG_ARCH_OMAP4=y
>  CONFIG_SOC_OMAP5=y
> +CONFIG_SOC_AM33XX=y
>  CONFIG_SOC_AM43XX=y
>  CONFIG_ARCH_ROCKCHIP=y
>  CONFIG_ARCH_SOCFPGA=y
> @@ -57,6 +59,7 @@ CONFIG_SATA_AHCI_PLATFORM=y
>  CONFIG_SATA_HIGHBANK=y
>  CONFIG_SATA_MV=y
>  CONFIG_NETDEVICES=y
> +CONFIG_SUN4I_EMAC=y

Additionally, this patch is missing CONFIG_MDIO_SUN4I=y, which I think
would be needed to make CONFIG_SUN4I_EMAC=y of any use. Maybe a Kconfig
select would be a good idea here?

>  CONFIG_NET_CALXEDA_XGMAC=y
>  CONFIG_SMSC911X=y
>  CONFIG_STMMAC_ETH=y
> @@ -70,6 +73,8 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
>  CONFIG_SERIAL_SIRFSOC=y
>  CONFIG_SERIAL_SIRFSOC_CONSOLE=y
>  CONFIG_SERIAL_TEGRA=y
> +CONFIG_SERIAL_IMX=y
> +CONFIG_SERIAL_IMX_CONSOLE=y
>  CONFIG_SERIAL_VT8500=y
>  CONFIG_SERIAL_VT8500_CONSOLE=y
>  CONFIG_SERIAL_OF_PLATFORM=y
> @@ -77,8 +82,6 @@ CONFIG_SERIAL_OMAP=y
>  CONFIG_SERIAL_OMAP_CONSOLE=y
>  CONFIG_SERIAL_XILINX_PS_UART=y
>  CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
> -CONFIG_SERIAL_IMX=y
> -CONFIG_SERIAL_IMX_CONSOLE=y
>  CONFIG_SERIAL_FSL_LPUART=y
>  CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
>  CONFIG_I2C_DESIGNWARE_PLATFORM=y
> 

Cheers,

Emilio
