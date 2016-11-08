From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Tue, 8 Nov 2016 14:44:45 +0000
Subject: [PATCH RFC 2/7] ARM: S3C64XX: Add DMA slave maps for PL080 devices
In-Reply-To: <1478276094-19135-4-git-send-email-s.nawrocki@samsung.com>
References: <1478276094-19135-1-git-send-email-s.nawrocki@samsung.com>
 <1478276094-19135-4-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20161108144445.GD1575@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2016 at 05:14:49PM +0100, Sylwester Nawrocki wrote:
> This patch adds DMA slave map tables to the pl080 devices's
> platform_data in order to support the new channel request API.
> A few devices for which there was no DMA support with current
> code are omitted from the tables.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/mach-s3c64xx/pl080.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm/mach-s3c64xx/pl080.c b/arch/arm/mach-s3c64xx/pl080.c
> index 89c5a62..8c88680 100644
> --- a/arch/arm/mach-s3c64xx/pl080.c
> +++ b/arch/arm/mach-s3c64xx/pl080.c
<snip>
> @@ -134,6 +153,8 @@ struct pl08x_platform_data s3c64xx_dma0_plat_data = {
>  	.put_xfer_signal = pl08x_put_xfer_signal,
>  	.slave_channels = s3c64xx_dma0_info,
>  	.num_slave_channels = ARRAY_SIZE(s3c64xx_dma0_info),
> +	.slave_map = s3c64xx_dma0_slave_map,
> +	.slavecnt = ARRAY_SIZE(s3c64xx_dma0_slave_map),
>  };

Here we add a .slavecnt but the pl08x_platform_data structure doesn't
contain that field. I can't see it on the branch you linked in
the cover letter either, is it added by a patch on another branch
I am missing?

> @@ -224,6 +254,8 @@ struct pl08x_platform_data s3c64xx_dma1_plat_data = {
>  	.put_xfer_signal = pl08x_put_xfer_signal,
>  	.slave_channels = s3c64xx_dma1_info,
>  	.num_slave_channels = ARRAY_SIZE(s3c64xx_dma1_info),
> +	.slave_map = s3c64xx_dma1_slave_map,
> +	.slavecnt = ARRAY_SIZE(s3c64xx_dma1_slave_map),
>  };

ditto.

Thanks,
Charles
