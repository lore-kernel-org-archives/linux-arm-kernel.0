From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 7 Jun 2011 20:55:41 +0800
Subject: [PATCH] gpio/mxc: convert gpio-mxc to use generic irq chip
In-Reply-To: <1307435137-31439-1-git-send-email-shawn.guo@linaro.org>
References: <1307435137-31439-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110607125540.GA21913@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On Tue, Jun 07, 2011 at 04:25:37PM +0800, Shawn Guo wrote:
> The patch converts gpio-mxc driver to use generic irq chip.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/gpio/Kconfig    |    1 +
>  drivers/gpio/gpio-mxc.c |   90 +++++++++++++++--------------------------------
>  2 files changed, 30 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index d973abd..ee8802f 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -97,6 +97,7 @@ config GPIO_MXC
>  	def_bool y
>  	depends on ARCH_MXC
>  	select GPIO_BASIC_MMIO_CORE
> +	select GENERIC_IRQ_CHIP
>  
I should have put GENERIC_IRQ_CHIP before GPIO_BASIC_MMIO_CORE to get
them sorted.  Would you mind fixing it when applying the patch, if
there is no v2 of the patch?

-- 
Regards,
Shawn
