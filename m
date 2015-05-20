From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 May 2015 08:50:35 +0200
Subject: [PATCH 01/12] ARM: mach-imx: iomux-imx31: Use DECLARE_BITMAP
In-Reply-To: <04e6c29d921d20f6089dd5d13f2c35bbe362eb0e.1432085659.git.joe@perches.com>
References: <cover.1432085659.git.joe@perches.com>
 <04e6c29d921d20f6089dd5d13f2c35bbe362eb0e.1432085659.git.joe@perches.com>
Message-ID: <20150520065035.GO24769@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, May 19, 2015 at 06:37:49PM -0700, Joe Perches wrote:
> Use the generic mechanism to declare a bitmap instead of unsigned long.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/arm/mach-imx/iomux-imx31.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/iomux-imx31.c b/arch/arm/mach-imx/iomux-imx31.c
> index d6a3075..6dd22ca 100644
> --- a/arch/arm/mach-imx/iomux-imx31.c
> +++ b/arch/arm/mach-imx/iomux-imx31.c
> @@ -40,7 +40,7 @@ static DEFINE_SPINLOCK(gpio_mux_lock);
>  
>  #define IOMUX_REG_MASK (IOMUX_PADNUM_MASK & ~0x3)
>  
> -static unsigned long mxc_pin_alloc_map[NB_PORTS * 32 / BITS_PER_LONG];
> +static DECLARE_BITMAP(mxc_pin_alloc_map, NB_PORTS * 32);
>  /*
>   * set the mode for a IOMUX pin.
>   */
Compile tested and
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
