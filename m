From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 4 Oct 2011 12:47:13 +0200
Subject: [PATCH 22/30] mfd: build twl6030 only on omap2
In-Reply-To: <1317566760-25681-23-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-23-git-send-email-arnd@arndb.de>
Message-ID: <20111004104713.GY4118@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Sun, Oct 02, 2011 at 04:45:52PM +0200, Arnd Bergmann wrote:
> We can only have one pwm driver built into the kernel,
I seem to remember that Bill Gatliff was working on a PWM subsystem that would
get rid of the current pwm.h ugliness. Do we have any updates on this one ?

The patch below looks like a hack to me, trying to work around the current
lack of such subsystem.

Cheers,
Samuel.

> so make sure
> that this one is only available on omap2 to avoid conflicts with
> pwm drivers of other platforms.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Balaji T K <balajitk@ti.com>
> Cc: Hemanth V <hemanthv@ti.com>
> ---
>  drivers/mfd/Kconfig |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 48cce35..26bebe8 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -256,8 +256,8 @@ config MFD_TWL4030_AUDIO
>  	default n
>  
>  config TWL6030_PWM
> -	tristate "TWL6030 PWM (Pulse Width Modulator) Support"
> -	depends on TWL4030_CORE
> +	bool "TWL6030 PWM (Pulse Width Modulator) Support"
> +	depends on TWL4030_CORE && ARCH_OMAP2
>  	select HAVE_PWM
>  	default n
>  	help
> -- 
> 1.7.5.4
> 

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
