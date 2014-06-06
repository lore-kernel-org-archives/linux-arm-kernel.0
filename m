From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 6 Jun 2014 07:53:51 +0100
Subject: [PATCH 1/3] mfd: UCB1x00: enable modular build
In-Reply-To: <1402003454-1989084-2-git-send-email-arnd@arndb.de>
References: <1402003454-1989084-1-git-send-email-arnd@arndb.de>
 <1402003454-1989084-2-git-send-email-arnd@arndb.de>
Message-ID: <20140606065351.GL24240@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The UCB1200 / UCB1300 driver uses the MCP_SA11X0 driver, which
> can be a loadable module, but this results in a link error
> when UCB1200 itself is built-in:
> 
> drivers/built-in.o: In function `ucb1x00_io_set_dir':
> :(.text+0x4a364): undefined reference to `mcp_reg_write'
> drivers/built-in.o: In function `ucb1x00_io_write':
> :(.text+0x4a3dc): undefined reference to `mcp_reg_write'
> drivers/built-in.o: In function `ucb1x00_io_read':
> :(.text+0x4a400): undefined reference to `mcp_reg_read'
> drivers/built-in.o: In function `ucb1x00_adc_enable':
> :(.text+0x4a460): undefined reference to `mcp_enable'
> ...
> 
> This can easily be resolved by making CONFIG_MCP_UCB1200 itself
> a tristate option, since that causes Kconfig to track the
> dependency correctly.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index ee8204c..4370692 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1248,7 +1248,7 @@ config MCP_SA11X0
>  
>  # Chip drivers
>  config MCP_UCB1200
> -	bool "Support for UCB1200 / UCB1300"
> +	tristate "Support for UCB1200 / UCB1300"
>  	depends on MCP_SA11X0
>  	select MCP
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
