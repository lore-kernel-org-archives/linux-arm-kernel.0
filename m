From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 17 Aug 2015 21:55:11 +0200
Subject: [PATCH v2] clk: rockchip: add pclk_cpu to the list of rk3188
 critical clocks
In-Reply-To: <F5234F5E-2A91-4B63-B260-3F20A4D16A9D@mniewoehner.de>
References: <5400BEF8-5245-4F7B-845B-D326A7BC56B5@mniewoehner.de>
 <10213368.VjAQGt7Kjq@phil>
 <F5234F5E-2A91-4B63-B260-3F20A4D16A9D@mniewoehner.de>
Message-ID: <14545587.HIDVkPerl6@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 17. August 2015, 21:50:53 schrieb Michael Niewoehner:
> pclk_cpu needs to keep running because it is needed for devices like
> the act8865 regulator but with the recent gpio clock handling this is
> not always the case anymore. So add it to the list of critical clocks.
> 
> Signed-off-by: Michael Niewoehner <linux@mniewoehner.de>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
> Changes in v2:
> - adapt commit message
> - add Linus Walleij to recipients, as the patch is related to the gpio clock
> change in the rockchip pinctrl driver it should go through his tree as well
> 
> drivers/clk/rockchip/clk-rk3188.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3188.c
> b/drivers/clk/rockchip/clk-rk3188.c index e4f9d47..1c93229 100644
> --- a/drivers/clk/rockchip/clk-rk3188.c
> +++ b/drivers/clk/rockchip/clk-rk3188.c
> @@ -708,6 +708,7 @@ static const char *const rk3188_critical_clocks[]
> __initconst = { "aclk_cpu",
> 	"aclk_peri",
> 	"hclk_peri",
> +	"pclk_cpu",
> };
> 
> static void __init rk3188_common_clk_init(struct device_node *np)
