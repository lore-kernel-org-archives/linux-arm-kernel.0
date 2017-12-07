From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 7 Dec 2017 11:40:54 +0530
Subject: [PATCH v2 3/3] ARM: davinci: fix mmc entries in DM365's eDMA
 slaves table
In-Reply-To: <20171205123458.97837-4-amery@hanoverdisplays.com>
References: <2298378f-37d0-0c04-dfe3-4503c58e5456@ti.com>
 <20171204133359.45625-1-amery@hanoverdisplays.com>
 <20171205123458.97837-1-amery@hanoverdisplays.com>
 <20171205123458.97837-4-amery@hanoverdisplays.com>
Message-ID: <4303d85c-aa8d-c343-c869-6a9b55541db6@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 05 December 2017 06:04 PM, Alejandro Mery wrote:
> Signed-off-by: Alejandro Mery <amery@hanoverdisplays.com>

Patch looks good, but please resubmit with patch description. Patch
description should be readable independent of headline so please add it
even if its just restating what is present in the headline.

Also, please add a Fixes tag.

Fixes: 0c750e1fe481 ("ARM: davinci: dm365: Add dma_slave_map to edma")

You can base the next version on fixes branch of my tree[1].

Thanks,
Sekhar

[1] git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git

> ---
>  arch/arm/mach-davinci/dm365.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
> index 103316f01a22..5ace9380626a 100644
> --- a/arch/arm/mach-davinci/dm365.c
> +++ b/arch/arm/mach-davinci/dm365.c
> @@ -868,10 +868,10 @@ static const struct dma_slave_map dm365_edma_map[] = {
>  	{ "spi_davinci.0", "rx", EDMA_FILTER_PARAM(0, 17) },
>  	{ "spi_davinci.3", "tx", EDMA_FILTER_PARAM(0, 18) },
>  	{ "spi_davinci.3", "rx", EDMA_FILTER_PARAM(0, 19) },
> -	{ "dm6441-mmc.0", "rx", EDMA_FILTER_PARAM(0, 26) },
> -	{ "dm6441-mmc.0", "tx", EDMA_FILTER_PARAM(0, 27) },
> -	{ "dm6441-mmc.1", "rx", EDMA_FILTER_PARAM(0, 30) },
> -	{ "dm6441-mmc.1", "tx", EDMA_FILTER_PARAM(0, 31) },
> +	{ "da830-mmc.0", "rx", EDMA_FILTER_PARAM(0, 26) },
> +	{ "da830-mmc.0", "tx", EDMA_FILTER_PARAM(0, 27) },
> +	{ "da830-mmc.1", "rx", EDMA_FILTER_PARAM(0, 30) },
> +	{ "da830-mmc.1", "tx", EDMA_FILTER_PARAM(0, 31) },
>  };
>  
>  static struct edma_soc_info dm365_edma_pdata = {
> -- 
> 2.15.0
> 
