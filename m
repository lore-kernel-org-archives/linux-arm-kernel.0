From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 17 Nov 2012 23:42:48 -0800
Subject: [PATCH] Misc: ARM_CHAR_LCD: Permit the use of a driver on any
 ARM machine
In-Reply-To: <1353222091-17521-1-git-send-email-shc_work@mail.ru>
References: <1353222091-17521-1-git-send-email-shc_work@mail.ru>
Message-ID: <20121118074248.GA11547@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 18, 2012 at 11:01:31AM +0400, Alexander Shiyan wrote:
> arm-charlcd driver can be used on any ARM machine, so dependency of
> PLAT_VERSATILE is removed.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/misc/Kconfig |   14 ++++++++------
>  1 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index b151b7c..83d8d44 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -434,13 +434,15 @@ config VMWARE_BALLOON
>  
>  config ARM_CHARLCD
>  	bool "ARM Ltd. Character LCD Driver"
> -	depends on PLAT_VERSATILE
> +	depends on ARM
> +	default n

n is always the default, right?  So this line isn't needed.

thanks,

greg k-h
