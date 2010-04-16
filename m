From: kevin.wells@nxp.com (Kevin Wells)
Date: Fri, 16 Apr 2010 02:17:39 +0200
Subject: [PATCH] ARM: LPC32XX: Update PHY3250 MTD partition info
In-Reply-To: <1271353494-13831-1-git-send-email-bengardiner@nanometrics.ca>
References: <1271353494-13831-1-git-send-email-bengardiner@nanometrics.ca>
Message-ID: <083DF309106F364B939360100EC290F80976AE806D@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
Hi Ben,

Thanks for posting these. The MTD support is currently
only available on our GIT server, although we plan on
getting the MTD patches into the mtd subtree soon..

> Adding the two other partitions of the phycore3250's nand flash:
> u-boot and the u-boot environment partitions. The former can be useful
> if you are feeling adventurous and would like to upgrade u-boot. The
> later is very useful for userspace utilities like fw_setenv which can
> be used to modify the bootargs for the next reboot or insert many other
> useful scripts.
> 
> In addition, adding these partitions brings the mtdblock numbers back
> to what they were with the 2.6.27.8 release of the linux kernel shipped
> with the phycore3250 evm.
> 
> Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
> ---
>  arch/arm/mach-lpc32xx/phy3250.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-
> lpc32xx/phy3250.c
> index b908d17..2672b63 100644
> --- a/arch/arm/mach-lpc32xx/phy3250.c
> +++ b/arch/arm/mach-lpc32xx/phy3250.c
> @@ -345,6 +345,16 @@ static int nandwp_enable(int enable)
>  #define BLK_SIZE (512 * 32)
>  static struct mtd_partition __initdata phy3250_nand_partition[] = {
>  	{
> +		.name	= "phy3250-uboot",
> +		.offset	= 0,
> +		.size	= (BLK_SIZE * 90)
> +	},
> +	{
> +		.name	= "phy3250-ubt-env",
> +		.offset	= (BLK_SIZE * 90),
> +		.size	= (BLK_SIZE * 10)
> +	},
> +	{
>  		.name	= "phy3250-kernel",
>  		.offset	= (BLK_SIZE * 100),
>  		.size	= (BLK_SIZE * 256)

This partitioning scheme isn't set it stone yet. We'll look at it
again once we get those patches up for review.

> --
> 1.6.3.3

thanks,
Kevin
