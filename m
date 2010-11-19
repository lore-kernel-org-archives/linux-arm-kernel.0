From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 19 Nov 2010 21:31:04 +0100
Subject: [PATCH 35/51] ARM: mx25: dynamically allocate imx2-wdt devices
In-Reply-To: <1290029419-21435-35-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
	<1290029419-21435-35-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20101119203103.GX8942@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

just a minor nit I'm going to fix in my tree

On Wed, Nov 17, 2010 at 10:30:03PM +0100, Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-mx25/Kconfig                      |    1 +
>  arch/arm/mach-mx25/devices-imx25.h              |    4 ++++
>  arch/arm/mach-mx25/devices.c                    |   15 ---------------
>  arch/arm/mach-mx25/devices.h                    |    1 -
>  arch/arm/mach-mx25/mach-mx25_3ds.c              |    2 +-
>  arch/arm/plat-mxc/devices/platform-imx2-wdt.c   |   14 ++++++++++----
>  arch/arm/plat-mxc/include/mach/devices-common.h |    1 +
>  7 files changed, 17 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/mach-mx25/Kconfig b/arch/arm/mach-mx25/Kconfig
> index 10c0f60..d152af2 100644
> --- a/arch/arm/mach-mx25/Kconfig
> +++ b/arch/arm/mach-mx25/Kconfig
> @@ -6,6 +6,7 @@ config MACH_MX25_3DS
>  	bool "Support MX25PDK (3DS) Platform"
>  	select IMX_HAVE_PLATFORM_ESDHC
>  	select IMX_HAVE_PLATFORM_IMXDI_RTC
> +	select IMX_HAVE_PLATFORM_IMX2_WDT
IMX_HAVE_PLATFORM_IMX2_WDT sorts before IMX_HAVE_PLATFORM_IMXDI_RTC.

Best regards
Uwe 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
