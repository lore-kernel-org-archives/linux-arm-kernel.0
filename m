From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 3 Feb 2010 11:31:02 +0100
Subject: [PATCH 04/13] ARM: LPC32XX arch support in Kconfig and Makefile
In-Reply-To: <1264643011-17390-5-git-send-email-wellsk40@gmail.com>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<1264643011-17390-5-git-send-email-wellsk40@gmail.com>
Message-ID: <20100203103102.GE11354@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Wed, Jan 27, 2010 at 05:43:22PM -0800, wellsk40 at gmail.com wrote:
> From: Kevin Wells <wellsk40@gmail.com>
> 
> Added support and default config flags in Kconfig for the LCP32XX
> arch. Updated the Makefile to include the mach-lpc32xx dir when
> the ARCH_LCP32XX arch is selected.
> 
> Signed-off-by: Kevin Wells <wellsk40@gmail.com>
> ---
>  arch/arm/Kconfig  |   16 ++++++++++++++++
>  arch/arm/Makefile |    1 +
This patch isn't self-contained.  This might hurt bisectability.
IMHO all intermediate states should be compilable.

>  2 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 4c33ca8..cc2dbf9 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -550,6 +550,20 @@ config ARCH_W90X900
>  	  <http://www.nuvoton.com/hq/enu/ProductAndSales/ProductLines/
>  		ConsumerElectronicsIC/ARMMicrocontroller/ARMMicrocontroller>
>  
> +config ARCH_LPC32XX
> +	bool "NXP LPC32XX"
> +	select CPU_ARM926T
> +	select ARCH_REQUIRE_GPIOLIB
> +	select GENERIC_GPIO
no need to select GENERIC_GPIO if you have ARCH_REQUIRE_GPIOLIB

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
