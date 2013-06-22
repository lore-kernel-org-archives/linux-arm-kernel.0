From: anton@enomsg.org (Anton Vorontsov)
Date: Fri, 21 Jun 2013 17:35:11 -0700
Subject: [PATCH] power/reset: Make the vexpress driver optional on arm
 and arm64
In-Reply-To: <1370877121-26211-1-git-send-email-pawel.moll@arm.com>
References: <1370877121-26211-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20130622003510.GA32416@lizard.mcd26095.sjc.wayport.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 04:12:01PM +0100, Pawel Moll wrote:
> The driver can be used on either arm or arm64 platforms, but
> the latter doesn't have any platform-specific configuration
> options, so it must be possible to manually enable the driver.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> ---

Applied. Thanks a lot, Pawel!

> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 349e9ae..ee039dc 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -32,7 +32,8 @@ config POWER_RESET_RESTART
>  	  user presses a key. u-boot then boots into Linux.
>  
>  config POWER_RESET_VEXPRESS
> -	bool
> +	bool "ARM Versatile Express power-off and reset driver"
> +	depends on ARM || ARM64
>  	depends on POWER_RESET
>  	help
>  	  Power off and reset support for the ARM Ltd. Versatile
> -- 
> 1.8.1.2
