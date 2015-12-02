From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Dec 2015 14:44 +0100
Subject: [PATCH 1/5] ARM: config: Regenerate multi_v5_defconfig
In-Reply-To: <1449012812-9779-2-git-send-email-andrew@lunn.ch>
References: <1449012812-9779-1-git-send-email-andrew@lunn.ch>
 <1449012812-9779-2-git-send-email-andrew@lunn.ch>
Message-ID: <2254361.JL23NtLhah@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 December 2015 00:33:28 Andrew Lunn wrote:
> Dues the Kconfig changes, multi_v5_defconfig needs regenerating.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/configs/multi_v5_defconfig | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
> index f69a459f4f92..f98d4b8b54c5 100644
> --- a/arch/arm/configs/multi_v5_defconfig
> +++ b/arch/arm/configs/multi_v5_defconfig
> @@ -11,10 +11,9 @@ CONFIG_MODULE_UNLOAD=y
> @@ -53,7 +52,6 @@ CONFIG_MTD_CFI_GEOMETRY=y
>  CONFIG_MTD_CFI_INTELEXT=y
>  CONFIG_MTD_CFI_STAA=y
>  CONFIG_MTD_PHYSMAP=y
> -CONFIG_MTD_M25P80=y

I think we need to enable MTD_SPI_NOR_BASE now to get the driver
back, see 03e296f613af ("mtd: m25p80: use the SPI nor framework")

>  CONFIG_MTD_NAND=y
>  CONFIG_MTD_NAND_ORION=y
>  CONFIG_BLK_DEV_LOOP=y
> @@ -66,8 +64,6 @@ CONFIG_ATA=y
>  CONFIG_SATA_AHCI=y
>  CONFIG_SATA_MV=y
>  CONFIG_NETDEVICES=y
> -CONFIG_NET_DSA_MV88E6123_61_65=y
> -CONFIG_NET_DSA_MV88E6171=y
>  CONFIG_MV643XX_ETH=y
>  CONFIG_R8169=y
>  CONFIG_MARVELL_PHY=y

Same for NET_SWITCHDEV, it used to be 'select'ed by NET_DSA, but is
now a dpeendency.

> @@ -162,8 +156,6 @@ CONFIG_STAGING=y
>  CONFIG_FB_XGI=y
>  CONFIG_EXT2_FS=y
>  CONFIG_EXT3_FS=y
> -# CONFIG_EXT3_FS_XATTR is not set
> -CONFIG_EXT4_FS=y
>  CONFIG_ISO9660_FS=m
>  CONFIG_JOLIET=y
>  CONFIG_UDF_FS=m

We can drop CONFIG_EXT3_FS now and just select CONFIG_EXT4_FS.
Let's also drop EXT2.

	Arnd
