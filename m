From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 15 Jan 2013 07:33:07 -0500
Subject: [PATCH 3/4] Enable ecc-mode selection in the driver
In-Reply-To: <2d08c4c072fd4922a6056362adb96a455307d583.1358242644.git.s.peter@mpl.ch>
References: <cover.1358242644.git.s.peter@mpl.ch>
 <2d08c4c072fd4922a6056362adb96a455307d583.1358242644.git.s.peter@mpl.ch>
Message-ID: <20130115123307.GA13433@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan,

This is a good-looking patch series, nice and small!  A few comments:

On Tue, Jan 15, 2013 at 01:13:12PM +0100, Stefan Peter wrote:
> In order to be able to use the ecc-mode, add the bch module to the default
> settings for the kirwood boards and enable the activation in orin-nand.c

s/orin-nand/orion-nand/

> 
> Signed-off-by: Stefan Peter <s.peter@mpl.ch>
> ---
> diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
> index 93f3794..4a9d3f7 100644
> --- a/arch/arm/configs/kirkwood_defconfig
> +++ b/arch/arm/configs/kirkwood_defconfig
> @@ -84,6 +84,7 @@ CONFIG_MTD_CFI_STAA=y
>  CONFIG_MTD_PHYSMAP=y
>  CONFIG_MTD_M25P80=y
>  CONFIG_MTD_NAND=y
> +CONFIG_MTD_NAND_ECC_BCH=y
>  CONFIG_MTD_NAND_ORION=y
>  CONFIG_BLK_DEV_LOOP=y
>  # CONFIG_SCSI_PROC_FS is not set

Please make the defconfig change a separate patch.

As a general note (this series shouldn't be a problem), please sort the
series so that you add the driver feature first, then enable it in
defconfig, then use it in DT.  This way, a future bisection won't run
into any nasty surprises, other than what they're looking for. ;-)

thx,

Jason.
