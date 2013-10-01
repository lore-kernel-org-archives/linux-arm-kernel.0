From: dinguyen@altera.com (Dinh Nguyen)
Date: Tue, 1 Oct 2013 14:28:56 -0500
Subject: [PATCH] arm: socfpga: Fix incorrect sdmmc clock name
In-Reply-To: <1379434985-25294-1-git-send-email-dinguyen@altera.com>
References: <1379434985-25294-1-git-send-email-dinguyen@altera.com>
Message-ID: <1380655736.13502.6.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Just wondering if I can solicit any comments for this patch? It's small,
so I'm not sure if I need at least a good Ack-by and put it in my tree
for a pull request, or ask to be applied to the arm-soc or Mike's clock
tree?

Thanks,
Dinh

On Tue, 2013-09-17 at 11:23 -0500, Dinh Nguyen wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> The SD/MMC clock is named "sdmmc_clk", and NOT "mmc_clk". Because of this,
> the SD driver was getting the incorrect clock value. This prevented the
> SD driver from initializing correctly.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Olof Johansson <olof@lixom.net>
> Cc: Pavel Machek <pavel@denx.de>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/clk/socfpga/clk.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
> index 5bb848c..81dd31a 100644
> --- a/drivers/clk/socfpga/clk.c
> +++ b/drivers/clk/socfpga/clk.c
> @@ -49,7 +49,7 @@
>  #define SOCFPGA_L4_SP_CLK		"l4_sp_clk"
>  #define SOCFPGA_NAND_CLK		"nand_clk"
>  #define SOCFPGA_NAND_X_CLK		"nand_x_clk"
> -#define SOCFPGA_MMC_CLK			"mmc_clk"
> +#define SOCFPGA_MMC_CLK			"sdmmc_clk"
>  #define SOCFPGA_DB_CLK			"gpio_db_clk"
>  
>  #define div_mask(width)	((1 << (width)) - 1)
