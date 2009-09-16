From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 16 Sep 2009 01:50:41 +0100
Subject: [PATCH 5/8] s3c6410: sdhci: Removing unused host_caps entry from
	sdhci0 platform data
In-Reply-To: <1252392910-31200-1-git-send-email-thomas.ab@samsung.com>
References: <1252392910-31200-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <20090916005041.GS13508@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 08, 2009 at 03:55:10PM +0900, thomas.ab at samsung.com wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> This patch removes the unused 'host_caps' entry from the sdhci0
> platform data.

Hmm, I guess we can sort out the capabilities from the information
supplied elsewhere in the platfor data.

Please merge the changes into one patch with the remvoal of the field
from the platform data.
 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/plat-s3c/dev-hsmmc.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c/dev-hsmmc.c b/arch/arm/plat-s3c/dev-hsmmc.c
> index 357ec60..647ca09 100644
> --- a/arch/arm/plat-s3c/dev-hsmmc.c
> +++ b/arch/arm/plat-s3c/dev-hsmmc.c
> @@ -39,8 +39,6 @@ static u64 s3c_device_hsmmc_dmamask = 0xffffffffUL;
>  
>  struct s3c_sdhci_platdata s3c_hsmmc0_def_platdata = {
>  	.max_width		= 4,
> -	.host_caps		= (MMC_CAP_4_BIT_DATA |
> -				  MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
>  	.clk_parent_name	= "dout_mpll",
>  	.clk_source_name 	= "mmc_bus",
>  	.clk_speed		= 50*MHZ,
> -- 
> 1.5.3.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
