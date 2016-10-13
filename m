From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 13 Oct 2016 09:05:35 +0200
Subject: [PATCH 4/4] staging/vchi: Remove dependency on CONFIG_BROKEN.
In-Reply-To: <20161003185209.27733-5-eric@anholt.net>
References: <20161003185209.27733-1-eric@anholt.net>
 <20161003185209.27733-5-eric@anholt.net>
Message-ID: <20161013070535.GA23147@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2016 at 11:52:09AM -0700, Eric Anholt wrote:
> The driver builds now.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/staging/vc04_services/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_services/Kconfig
> index 9676fb29075a..db8e1beb89f9 100644
> --- a/drivers/staging/vc04_services/Kconfig
> +++ b/drivers/staging/vc04_services/Kconfig
> @@ -1,6 +1,6 @@
>  config BCM2708_VCHIQ
>  	tristate "Videocore VCHIQ"
> -	depends on RASPBERRYPI_FIRMWARE && BROKEN
> +	depends on RASPBERRYPI_FIRMWARE
>  	default y
>  	help
>  		Kernel to VideoCore communication interface for the

I've dropped this patch from my branch as there are build errors on
arm64 systems still, and we don't want regressions like that.

I've forwarded you the error messages, and I'll be glad to add this
patch back once these issues are fixed.

thanks,

greg k-h
