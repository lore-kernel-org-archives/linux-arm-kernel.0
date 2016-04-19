From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Tue, 19 Apr 2016 14:07:04 -0400
Subject: [PATCH] ARM: lpc32xx: remove duplicate const on
 lpc32xx_auxdata_lookup
In-Reply-To: <1460943458-27609-1-git-send-email-vz@mleia.com>
References: <1460943458-27609-1-git-send-email-vz@mleia.com>
Message-ID: <1461089224.2877.2.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-04-18 at 04:37 +0300, Vladimir Zapolskiy wrote:
> Remove redundant duplicate const, which is found by smatch:
> 
>   arch/arm/mach-lpc32xx/phy3250.c:162:42: warning: duplicate const
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>

> ---
>  arch/arm/mach-lpc32xx/phy3250.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
> index b2f9e22..1ae7230 100644
> --- a/arch/arm/mach-lpc32xx/phy3250.c
> +++ b/arch/arm/mach-lpc32xx/phy3250.c
> @@ -159,7 +159,7 @@ static struct lpc32xx_mlc_platform_data lpc32xx_mlc_data = {
>  	.dma_filter = pl08x_filter_id,
>  };
>  
> -static const struct of_dev_auxdata const lpc32xx_auxdata_lookup[] __initconst = {
> +static const struct of_dev_auxdata lpc32xx_auxdata_lookup[] __initconst = {
>  	OF_DEV_AUXDATA("arm,pl022", 0x20084000, "dev:ssp0", NULL),
>  	OF_DEV_AUXDATA("arm,pl022", 0x2008C000, "dev:ssp1", NULL),
>  	OF_DEV_AUXDATA("arm,pl110", 0x31040000, "dev:clcd", &lpc32xx_clcd_data),
