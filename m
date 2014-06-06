From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 6 Jun 2014 07:54:18 +0100
Subject: [PATCH 2/3] mfd: davinci voicecodec need regmap_mmio
In-Reply-To: <1402003454-1989084-3-git-send-email-arnd@arndb.de>
References: <1402003454-1989084-1-git-send-email-arnd@arndb.de>
 <1402003454-1989084-3-git-send-email-arnd@arndb.de>
Message-ID: <20140606065418.GM24240@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 05 Jun 2014, Arnd Bergmann wrote:

> Without REGMAP_MMIO, building that driver results in a link error:
> 
> drivers/built-in.o: In function `davinci_vc_probe':
> :(.init.text+0x3c1c): undefined reference to `devm_regmap_init_mmio_clk'
> 
> This adds a Kconfig 'select' statement as the usual way to ensure
> that REGMAP_MMIO is enabled.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mfd/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 4370692..2dd838f 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -760,6 +760,7 @@ config MFD_SYSCON
>  config MFD_DAVINCI_VOICECODEC
>  	tristate
>  	select MFD_CORE
> +	select REGMAP_MMIO
>  
>  config MFD_TI_AM335X_TSCADC
>  	tristate "TI ADC / Touch Screen chip support"

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
