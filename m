From: b32955@freescale.com (Huang Shijie)
Date: Mon, 21 Apr 2014 10:32:11 +0800
Subject: [PATCH 1/5] ARM: defconfigs: add MTD_SPI_NOR (new dependency
 for M25P80)
In-Reply-To: <1397719309-2022-2-git-send-email-computersforpeace@gmail.com>
References: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
 <1397719309-2022-2-git-send-email-computersforpeace@gmail.com>
Message-ID: <20140421023208.GA5268@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 12:21:45AM -0700, Brian Norris wrote:
> These defconfigs contain the CONFIG_M25P80 symbol, which is now
> dependent on the MTD_SPI_NOR symbol. Add CONFIG_MTD_SPI_NOR to the
> relevant defconfigs.
> 
> At the same time, drop the now-nonexistent CONFIG_MTD_CHAR symbol.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Shawn Guo <shawn.guo@freescale.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
> This change is based on l2-mtd.git/spinor, which is based on 3.15-rc1:
> 
>   git://git.infradead.org/l2-mtd.git +spinor
> 
>  arch/arm/configs/bockw_defconfig     | 2 +-
>  arch/arm/configs/dove_defconfig      | 2 +-
>  arch/arm/configs/imx_v6_v7_defconfig | 1 +
>  arch/arm/configs/keystone_defconfig  | 1 +
>  arch/arm/configs/kirkwood_defconfig  | 1 +
>  arch/arm/configs/koelsch_defconfig   | 1 +
>  arch/arm/configs/lager_defconfig     | 1 +
>  arch/arm/configs/lpc32xx_defconfig   | 2 +-
>  arch/arm/configs/multi_v5_defconfig  | 1 +
>  arch/arm/configs/multi_v7_defconfig  | 1 +
>  arch/arm/configs/mvebu_v5_defconfig  | 1 +
>  arch/arm/configs/mvebu_v7_defconfig  | 1 +
>  arch/arm/configs/mxs_defconfig       | 1 +
>  arch/arm/configs/sama5_defconfig     | 2 +-
>  arch/arm/configs/shmobile_defconfig  | 1 +
>  arch/arm/configs/tegra_defconfig     | 1 +
>  16 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
> index e816140d81c5..28339e072a71 100644
> --- a/arch/arm/configs/bockw_defconfig
> +++ b/arch/arm/configs/bockw_defconfig
> @@ -50,11 +50,11 @@ CONFIG_DEVTMPFS_MOUNT=y
>  # CONFIG_PREVENT_FIRMWARE_BUILD is not set
>  # CONFIG_FW_LOADER is not set
>  CONFIG_MTD=y
> -CONFIG_MTD_CHAR=y
>  CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_CFI=y
>  CONFIG_MTD_CFI_AMDSTD=y
>  CONFIG_MTD_M25P80=y
> +CONFIG_MTD_SPI_NOR=y
>  CONFIG_SCSI=y
>  CONFIG_BLK_DEV_SD=y
>  CONFIG_NETDEVICES=y
> diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
> index f15955144175..701677f9248c 100644
> --- a/arch/arm/configs/dove_defconfig
> +++ b/arch/arm/configs/dove_defconfig
> @@ -37,7 +37,6 @@ CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_MTD=y
>  CONFIG_MTD_CMDLINE_PARTS=y
> -CONFIG_MTD_CHAR=y
>  CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_CFI=y
>  CONFIG_MTD_JEDECPROBE=y
> @@ -48,6 +47,7 @@ CONFIG_MTD_CFI_INTELEXT=y
>  CONFIG_MTD_CFI_STAA=y
>  CONFIG_MTD_PHYSMAP=y
>  CONFIG_MTD_M25P80=y
> +CONFIG_MTD_SPI_NOR=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_RAM=y
>  CONFIG_BLK_DEV_RAM_COUNT=1
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 09e974392fa1..c098195e9bd3 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -89,6 +89,7 @@ CONFIG_MTD_SST25L=y
>  CONFIG_MTD_NAND=y
>  CONFIG_MTD_NAND_GPMI_NAND=y
>  CONFIG_MTD_NAND_MXC=y
> +CONFIG_MTD_SPI_NOR=y
>  CONFIG_MTD_UBI=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_RAM=y
> diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
> index ec9a41d50680..b3057730689f 100644
> --- a/arch/arm/configs/keystone_defconfig
> +++ b/arch/arm/configs/keystone_defconfig
> @@ -112,6 +112,7 @@ CONFIG_MTD_PLATRAM=y
>  CONFIG_MTD_M25P80=y
>  CONFIG_MTD_NAND=y
>  CONFIG_MTD_NAND_DAVINCI=y
> +CONFIG_MTD_SPI_NOR=y
>  CONFIG_MTD_UBI=y
>  CONFIG_PROC_DEVICETREE=y
>  CONFIG_BLK_DEV_LOOP=y
> diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
> index 2e762d94e94b..b9e480c10b10 100644
> --- a/arch/arm/configs/kirkwood_defconfig
> +++ b/arch/arm/configs/kirkwood_defconfig
> @@ -61,6 +61,7 @@ CONFIG_MTD_PHYSMAP=y
>  CONFIG_MTD_M25P80=y
>  CONFIG_MTD_NAND=y
>  CONFIG_MTD_NAND_ORION=y
> +CONFIG_MTD_SPI_NOR=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_EEPROM_AT24=y
>  # CONFIG_SCSI_PROC_FS is not set
> diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
> index 86faab565a96..dcd55f20d36e 100644
> --- a/arch/arm/configs/koelsch_defconfig
> +++ b/arch/arm/configs/koelsch_defconfig
> @@ -42,6 +42,7 @@ CONFIG_ATA=y
>  CONFIG_SATA_RCAR=y
>  CONFIG_MTD=y
>  CONFIG_MTD_M25P80=y
> +CONFIG_MTD_SPI_NOR=y
>  CONFIG_NETDEVICES=y
>  # CONFIG_NET_VENDOR_ARC is not set
>  # CONFIG_NET_CADENCE is not set
> diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
> index 58702440472a..c4dbd778458b 100644
> --- a/arch/arm/configs/lager_defconfig
> +++ b/arch/arm/configs/lager_defconfig
> @@ -53,6 +53,7 @@ CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_MTD=y
>  CONFIG_MTD_M25P80=y
> +CONFIG_MTD_SPI_NOR=y
>  CONFIG_BLK_DEV_SD=y
>  CONFIG_ATA=y
>  CONFIG_SATA_RCAR=y
> diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
> index 398a367ffce8..2de54c35fb47 100644
> --- a/arch/arm/configs/lpc32xx_defconfig
> +++ b/arch/arm/configs/lpc32xx_defconfig
> @@ -53,12 +53,12 @@ CONFIG_DEVTMPFS_MOUNT=y
>  # CONFIG_FW_LOADER is not set
>  CONFIG_MTD=y
>  CONFIG_MTD_CMDLINE_PARTS=y
> -CONFIG_MTD_CHAR=y
>  CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_M25P80=y
>  CONFIG_MTD_NAND=y
>  CONFIG_MTD_NAND_SLC_LPC32XX=y
>  CONFIG_MTD_NAND_MLC_LPC32XX=y
> +CONFIG_MTD_SPI_NOR=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_CRYPTOLOOP=y
>  CONFIG_BLK_DEV_RAM=y
> diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
> index aa3dfb084fed..aaf23933fb91 100644
> --- a/arch/arm/configs/multi_v5_defconfig
> +++ b/arch/arm/configs/multi_v5_defconfig
> @@ -56,6 +56,7 @@ CONFIG_MTD_PHYSMAP=y
>  CONFIG_MTD_M25P80=y
>  CONFIG_MTD_NAND=y
>  CONFIG_MTD_NAND_ORION=y
> +CONFIG_MTD_SPI_NOR=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_EEPROM_AT24=y
>  # CONFIG_SCSI_PROC_FS is not set
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index d4e8a47a2f7c..9937db16050c 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -108,6 +108,7 @@ CONFIG_CMA_SIZE_MBYTES=64
>  CONFIG_OMAP_OCP2SCP=y
>  CONFIG_MTD=y
>  CONFIG_MTD_M25P80=y
> +CONFIG_MTD_SPI_NOR=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_ICS932S401=y
>  CONFIG_APDS9802ALS=y
> diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
> index 36484a37a1ca..85d20666cef5 100644
> --- a/arch/arm/configs/mvebu_v5_defconfig
> +++ b/arch/arm/configs/mvebu_v5_defconfig
> @@ -50,6 +50,7 @@ CONFIG_MTD_PHYSMAP=y
>  CONFIG_MTD_M25P80=y
>  CONFIG_MTD_NAND=y
>  CONFIG_MTD_NAND_ORION=y
> +CONFIG_MTD_SPI_NOR=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_EEPROM_AT24=y
>  # CONFIG_SCSI_PROC_FS is not set
> diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
> index a34713d8db9f..ae45bf05fa00 100644
> --- a/arch/arm/configs/mvebu_v7_defconfig
> +++ b/arch/arm/configs/mvebu_v7_defconfig
> @@ -53,6 +53,7 @@ CONFIG_I2C_MV64XXX=y
>  CONFIG_MTD=y
>  CONFIG_MTD_CHAR=y
>  CONFIG_MTD_M25P80=y
> +CONFIG_MTD_SPI_NOR=y
>  CONFIG_MTD_CFI=y
>  CONFIG_MTD_CFI_INTELEXT=y
>  CONFIG_MTD_CFI_AMDSTD=y
> diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
> index 6150108e15de..eac87f4fae07 100644
> --- a/arch/arm/configs/mxs_defconfig
> +++ b/arch/arm/configs/mxs_defconfig
> @@ -55,6 +55,7 @@ CONFIG_MTD_M25P80=y
>  CONFIG_MTD_SST25L=y
>  CONFIG_MTD_NAND=y
>  CONFIG_MTD_NAND_GPMI_NAND=y
> +CONFIG_MTD_SPI_NOR=y
>  CONFIG_MTD_UBI=y
>  # CONFIG_BLK_DEV is not set
>  CONFIG_EEPROM_AT24=y
> diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
> index dc3881e07630..8282ebab6e52 100644
> --- a/arch/arm/configs/sama5_defconfig
> +++ b/arch/arm/configs/sama5_defconfig
> @@ -65,12 +65,12 @@ CONFIG_DEVTMPFS_MOUNT=y
>  # CONFIG_PREVENT_FIRMWARE_BUILD is not set
>  CONFIG_MTD=y
>  CONFIG_MTD_CMDLINE_PARTS=y
> -CONFIG_MTD_CHAR=y
>  CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_CFI=y
>  CONFIG_MTD_M25P80=y
>  CONFIG_MTD_NAND=y
>  CONFIG_MTD_NAND_ATMEL=y
> +CONFIG_MTD_SPI_NOR=y
>  CONFIG_MTD_UBI=y
>  CONFIG_MTD_UBI_GLUEBI=y
>  CONFIG_PROC_DEVICETREE=y
> diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> index 83b07258a385..ddfdc36be9c8 100644
> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -43,6 +43,7 @@ CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_MTD=y
>  CONFIG_MTD_M25P80=y
> +CONFIG_MTD_SPI_NOR=y
>  CONFIG_BLK_DEV_SD=y
>  CONFIG_ATA=y
>  CONFIG_SATA_RCAR=y
> diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
> index 2926281368ab..e4464986d7b4 100644
> --- a/arch/arm/configs/tegra_defconfig
> +++ b/arch/arm/configs/tegra_defconfig
> @@ -90,6 +90,7 @@ CONFIG_DMA_CMA=y
>  CONFIG_CMA_SIZE_MBYTES=64
>  CONFIG_MTD=y
>  CONFIG_MTD_M25P80=y
> +CONFIG_MTD_SPI_NOR=y
>  CONFIG_PROC_DEVICETREE=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_AD525X_DPOT=y
> -- 
I think we should not use the "select", since the SPI-NOR framework also depends
on the MTD code.

For the mxs_defconfig and imx_v6_v7_defconfig

Acked-by: Huang Shijie <b32955@freescale.com>
