From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 11 Mar 2011 22:39:36 +0100
Subject: [PATCH 4/8] ARM: PXA: Z2: Add mtd partition with logo
In-Reply-To: <1299839023-16601-4-git-send-email-anarsoul@gmail.com>
References: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
	<1299839023-16601-4-git-send-email-anarsoul@gmail.com>
Message-ID: <201103112239.36682.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 March 2011 11:23:39 Vasily Khoruzhick wrote:
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

I guess you can rather supply the MTD layout on kernel command line (see 
Drivers/MTD).

> ---
>  arch/arm/mach-pxa/z2.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
> index bffb920..aec87f7 100644
> --- a/arch/arm/mach-pxa/z2.c
> +++ b/arch/arm/mach-pxa/z2.c
> @@ -169,6 +169,10 @@ static struct mtd_partition z2_flash_parts[] = {
>  	}, {
>  		.name	= "Flash",
>  		.offset	= 0x60000,
> +		.size	= 0x780000,
> +	}, {
> +		.name	= "U-Boot Logo",
> +		.offset = 0x7e0000,
>  		.size	= MTDPART_SIZ_FULL,
>  	},
>  };
