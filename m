From: robherring2@gmail.com (Rob Herring)
Date: Tue, 13 Sep 2011 08:50:56 -0500
Subject: [PATCH] ARM: CACHE-L2X0: filter start address can be 0 and is
	often 0
In-Reply-To: <1315895573-30765-1-git-send-email-Baohua.Song@csr.com>
References: <1315895573-30765-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <4E6F5FC0.20806@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2011 01:32 AM, Barry Song wrote:
> Cc: Rob Herring <robherring2@gmail.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Acked-by: Rob Herring <rob.herring@calxeda.com>

> ---
>  arch/arm/mm/cache-l2x0.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index a780448..0d85d22 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -437,7 +437,7 @@ static void __init pl310_of_setup(const struct device_node *np,
>  
>  	of_property_read_u32_array(np, "arm,filter-ranges",
>  				   filter, ARRAY_SIZE(filter));
> -	if (filter[0] && filter[1]) {
> +	if (filter[1]) {
>  		writel_relaxed(ALIGN(filter[0] + filter[1], SZ_1M),
>  			       l2x0_base + L2X0_ADDR_FILTER_END);
>  		writel_relaxed((filter[0] & ~(SZ_1M - 1)) | L2X0_ADDR_FILTER_EN,
