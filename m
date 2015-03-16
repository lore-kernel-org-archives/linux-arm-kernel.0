From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Mon, 16 Mar 2015 12:05:44 +0100
Subject: [PATCH 3/3] ARM: dts: Define stdout-path property for Spring board
In-Reply-To: <1426501710-24177-4-git-send-email-javier.martinez@collabora.co.uk>
References: <1426501710-24177-1-git-send-email-javier.martinez@collabora.co.uk>
 <1426501710-24177-4-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <5506B908.1060007@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 16.03.2015 um 11:28 schrieb Javier Martinez Canillas:
> The kernel can use as the default console a serial port if is defined

"The kernel can use a serial port as the default console if it's defined
..."

> as stdout device in the Device Tree.
> 
> This allows a board to be booted without the need of having a console
> parameter in the kernel command line.
> 
> Currently the Spring DTS has bootargs in the /chosen node and this is
> kept since users that don't have a serial console on this board might
> be using it to have the boot log shown in the display. This will have
> more precedence than the stdout-path but it's fine since is only used

"since it's"

> when CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND is enabled.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/boot/dts/exynos5250-spring.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
> index f02775487cd4..b9ec763a5602 100644
> --- a/arch/arm/boot/dts/exynos5250-spring.dts
> +++ b/arch/arm/boot/dts/exynos5250-spring.dts
> @@ -25,6 +25,7 @@
>  
>  	chosen {
>  		bootargs = "console=tty1";
> +		stdout-path = "serial3:115200n8";

Is this a guess or did you verify that against some schematics?

>  	};
>  
>  	gpio-keys {

Assuming that bootargs still work,

Reviewed-by: Andreas F?rber <afaerber@suse.de>

I do wonder why this mechanism could not point to the same location as
bootargs? ("dp-controller"?) The device does not even have screws for
opening it, so accessing the serial port is highly theoretical.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
Graham Norton; HRB 21284 (AG N?rnberg)
