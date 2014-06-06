From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 6 Jun 2014 07:54:36 +0100
Subject: [PATCH 3/3] mfd: STw481x: allow modular build
In-Reply-To: <1402003454-1989084-4-git-send-email-arnd@arndb.de>
References: <1402003454-1989084-1-git-send-email-arnd@arndb.de>
 <1402003454-1989084-4-git-send-email-arnd@arndb.de>
Message-ID: <20140606065436.GN24240@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 05 Jun 2014, Arnd Bergmann wrote:

> This driver depends on I2C, which may be a loadable module.
> While you'd probably want both to be built-in in practice,
> allowing a modular build avoids possible randconfig link
> errors.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 2dd838f..6cc4b6a 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1226,7 +1226,7 @@ config MFD_WM8994
>  	  functionaltiy of the device other drivers must be enabled.
>  
>  config MFD_STW481X
> -	bool "Support for ST Microelectronics STw481x"
> +	tristate "Support for ST Microelectronics STw481x"
>  	depends on I2C && ARCH_NOMADIK
>  	select REGMAP_I2C
>  	select MFD_CORE

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
