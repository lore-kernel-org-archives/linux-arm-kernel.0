From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 2 May 2013 16:36:24 +0100
Subject: [PATCH, RFC 10/22] mfd: ab8500: debugfs code depends on gpadc
In-Reply-To: <1367507786-505303-11-git-send-email-arnd@arndb.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <1367507786-505303-11-git-send-email-arnd@arndb.de>
Message-ID: <20130502153624.GN25256@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 02 May 2013, Arnd Bergmann wrote:

> The AB8500_DEBUG code specifically requires access to the gpadc code,
> not just the common ab8500 driver.
> 
> drivers/built-in.o: In function `ab8500_gpadc_bat_ctrl_print':
>  mfd/ab8500-debugfs.c:1733: undefined reference to `ab8500_gpadc_get'
>  mfd/ab8500-debugfs.c:1734: undefined reference to `ab8500_gpadc_read_raw'
>  mfd/ab8500-debugfs.c:1736: undefined reference to `ab8500_gpadc_ad_to_voltage'
> 
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Philippe LANGLAIS <philippe.langlais@stericsson.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 9b4703e..bf785db 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -580,7 +580,7 @@ config AB8500_CORE
>  
>  config AB8500_DEBUG
>         bool "Enable debug info via debugfs"
> -       depends on AB8500_CORE && DEBUG_FS
> +       depends on AB8500_GPADC && DEBUG_FS
>         default y if DEBUG_FS
>         help
>           Select this option if you want debug information using the debug

Did you find this with ALLCONFIG out of interest.

Applied by the way.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
