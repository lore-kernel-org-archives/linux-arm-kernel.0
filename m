From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 24 Apr 2017 12:10:41 +0200
Subject: [PATCH] clk: meson: gxbb: fix build error without RESET_CONTROLLER
In-Reply-To: <20170424100542.20226-1-tobias.regnery@gmail.com>
References: <20170424100542.20226-1-tobias.regnery@gmail.com>
Message-ID: <8556c66c-585f-d171-e2a8-1f59d109e9de@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2017 12:05 PM, Tobias Regnery wrote:
> With CONFIG_RESET_CONTROLLER=n we see the following link error in the
> meson gxbb clk driver:
> 
> drivers/built-in.o: In function 'gxbb_aoclkc_probe':
> drivers/clk/meson/gxbb-aoclk.c:161: undefined reference to 'devm_reset_controller_register'
> 
> Fix this by selecting the reset controller subsystem.
> 
> Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>
> ---
>  drivers/clk/meson/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index 19480bcc7046..2f29ee1a4d00 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -14,6 +14,7 @@ config COMMON_CLK_MESON8B
>  config COMMON_CLK_GXBB
>  	bool
>  	depends on COMMON_CLK_AMLOGIC
> +	select RESET_CONTROLLER
>  	help
>  	  Support for the clock controller on AmLogic S905 devices, aka gxbb.
>  	  Say Y if you want peripherals and CPU frequency scaling to work.
> 

Hi Tobias,

I was going to push this, thanks for the patch !

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Neil
