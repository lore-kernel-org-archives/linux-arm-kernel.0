From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 11 Apr 2010 20:39:15 +0200
Subject: [PATCH] MX2: devices.c: Fix typo in imx21 usb mem resource address
In-Reply-To: <1270990471-28137-1-git-send-email-lars@metafoo.de>
References: <1270990471-28137-1-git-send-email-lars@metafoo.de>
Message-ID: <20100411183915.GA4679@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this was introduced by 

	988addf (Merge branch 'origin' into devel-stable)

when trying to fix a (logic) merge conflict.

On Sun, Apr 11, 2010 at 02:54:31PM +0200, Lars-Peter Clausen wrote:
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  arch/arm/mach-mx2/devices.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mx2/devices.c b/arch/arm/mach-mx2/devices.c
> index b91e412..67182e1 100644
> --- a/arch/arm/mach-mx2/devices.c
> +++ b/arch/arm/mach-mx2/devices.c
> @@ -483,8 +483,8 @@ int __init mxc_register_gpios(void)
>  #ifdef CONFIG_MACH_MX21
>  static struct resource mx21_usbhc_resources[] = {
>  	{
> -		.start	= MX21_BASE_ADDR,
> -		.end	= MX21_BASE_ADDR + 0x1FFF,
> +		.start	= MX21_USBOTG_BASE_ADDR,
> +		.end	= MX21_USBOTG_BASE_ADDR + 0x1FFF,
Would you mind making this

	... + 0x1fff,

as this is the only line left using capital letters for hex numbers in
that file.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
