From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 25 Apr 2016 16:00:31 -0700
Subject: [PATCH] soc: brcmstb: select SOC_BUS
In-Reply-To: <1461625017-1939162-1-git-send-email-arnd@arndb.de>
References: <1461625017-1939162-1-git-send-email-arnd@arndb.de>
Message-ID: <571EA18F.2030401@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/04/16 15:55, Arnd Bergmann wrote:
> The newly added code for the SoC bus fails to link if the
> bus is not built:
> 
> drivers/soc/built-in.o: In function `brcmstb_soc_device_init':
> :(.init.text+0x110): undefined reference to `soc_device_register'
> 
> This adds a 'select' statement to avoid the error.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Fixes: cef4bafcea2c ("soc: brcmstb: add SoC driver to brcmstb")

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!

> ---
>  drivers/soc/brcmstb/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/brcmstb/Kconfig b/drivers/soc/brcmstb/Kconfig
> index 39cab3b..7fec3b4 100644
> --- a/drivers/soc/brcmstb/Kconfig
> +++ b/drivers/soc/brcmstb/Kconfig
> @@ -1,6 +1,7 @@
>  menuconfig SOC_BRCMSTB
>  	bool "Broadcom STB SoC drivers"
>  	depends on ARM
> +	select SOC_BUS
>  	help
>  	  Enables drivers for the Broadcom Set-Top Box (STB) series of chips.
>  	  This option alone enables only some support code, while the drivers
> 


-- 
Florian
