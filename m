From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 28 Aug 2012 08:47:10 +0200
Subject: [PATCH] imx21ads : avoid overlapping static i/o mappings
In-Reply-To: <1346016938-28175-1-git-send-email-jaccon.bastiaansen@gmail.com>
References: <1346016938-28175-1-git-send-email-jaccon.bastiaansen@gmail.com>
Message-ID: <20120828064710.GP26594@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 26, 2012 at 11:35:38PM +0200, Jaccon Bastiaansen wrote:
> The static I/O mappings for the cs89x0 ethernet controller and the
> secondary AHB port 1 (SAHB1) overlapped, causing a kernel crash
> at startup. This is fixed by mapping the cs89x0 to 0xf6000000 (which
> is free to use according to arch/arm/plat-mxc/include/mach/hardware.h).
> 
> Signed-off-by: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
> ---
>  arch/arm/mach-imx/mach-mx21ads.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
> index ed22e3f..712c90e 100644
> --- a/arch/arm/mach-imx/mach-mx21ads.c
> +++ b/arch/arm/mach-imx/mach-mx21ads.c
> @@ -31,7 +31,7 @@
>  /*
>   * Memory-mapped I/O on MX21ADS base board
>   */
> -#define MX21ADS_MMIO_BASE_ADDR   0xf5000000
> +#define MX21ADS_MMIO_BASE_ADDR   0xf6000000

I would prefer to ioremap the region instead. This makes sure this
problem is solved once and for all.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
