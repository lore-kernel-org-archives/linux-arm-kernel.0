From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 9 May 2012 09:29:39 +0200
Subject: [PATCH] imx21ads : Fix overlapping static i/o mappings
In-Reply-To: <1335779623-30383-1-git-send-email-jaccon.bastiaansen@gmail.com>
References: <1335779623-30383-1-git-send-email-jaccon.bastiaansen@gmail.com>
Message-ID: <20120509072939.GI27341@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2012 at 11:53:43AM +0200, Jaccon Bastiaansen wrote:
> The statically defined I/O memory regions for the i.MX21 on chip
> peripherals and the on board I/O peripherals of the i.MX21ADS board
> overlap. This results in a kernel crash during startup. This is fixed
> by reducing the memory range for the on board I/O peripherals to the
> actually required range.
> 
> Signed-off-by: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>

Applied, thanks. Please add a ARM i.MX prefix next time to you subject.
Also, added a Cc stable.

Sascha

> ---
>  arch/arm/mach-imx/mach-mx21ads.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
> index e432d4a..4460d25 100644
> --- a/arch/arm/mach-imx/mach-mx21ads.c
> +++ b/arch/arm/mach-imx/mach-mx21ads.c
> @@ -32,7 +32,7 @@
>   * Memory-mapped I/O on MX21ADS base board
>   */
>  #define MX21ADS_MMIO_BASE_ADDR   0xf5000000
> -#define MX21ADS_MMIO_SIZE        SZ_16M
> +#define MX21ADS_MMIO_SIZE        0xc00000
>  
>  #define MX21ADS_REG_ADDR(offset)    (void __force __iomem *) \
>  		(MX21ADS_MMIO_BASE_ADDR + (offset))
> -- 
> 1.7.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
