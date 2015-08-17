From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 17 Aug 2015 21:37:22 +0200
Subject: [PATCH] clk: rockchip: add pclk_cpu to the list of rk3188
 critical clocks
In-Reply-To: <9DBF9CCE-196E-43FB-BA76-BFB4B5F47A22@mniewoehner.de>
References: <5400BEF8-5245-4F7B-845B-D326A7BC56B5@mniewoehner.de>
 <5275855.eah07vmf4I@phil>
 <9DBF9CCE-196E-43FB-BA76-BFB4B5F47A22@mniewoehner.de>
Message-ID: <10213368.VjAQGt7Kjq@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,


need to pick a bit more on your patch submission :-)

Please take a look for example at
http://lists.infradead.org/pipermail/linux-rockchip/2014-November/001043.html

on how a v2 submission needs to look like.

Specifically:
- In most cases not as a reply to a reply to another mail.
- Mail subject: [PATCH v2] clk: rockchip: add pclk_cpu to the list of rk3188 
critical clocks


Am Montag, 17. August 2015, 20:51:14 schrieb Michael Niewoehner:
> Hi Heiko,
> 
> I merged yours and mine :-)
> 
> 

no prose nor empty lines. If necessary such stuff could sit below the "---" 
which results in it not making it into the actuall commit message.


> pclk_cpu needs to keep running because it is needed for devices like
> the act8865 regulator but with the recent gpio clock handling this is
> not always the case anymore. So add it to the list of critical clocks.
> 
> Signed-off-by: Michael Niewoehner <linux@mniewoehner.de>
> ---

Here any prose-text you like to add.

Also, changelog:
changes in v2:
- adapt commit message
- add Linus Walleij to recipients, as the patch is related to the gpio clock
  change in the rockchip pinctrl driver it should go through his tree as well

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


no quotes of other mails, like the stuff below.


Heiko

> 
> > Hi,
> > 
> > Am Montag, 17. August 2015, 19:38:22 schrieb Michael Niewoehner:
> >> gpio clock is getting disabled to save power but pclk_cpu is needed for
> >> act8865 regulator
> > 
> > Please refine the commit message a bit :-) . Something along
> > 
> > pclk_cpu needs to keep running and with the recent gpio clock
> > handling this is not always the case anymore. So add it to the list
> > of critical clocks.
> > 
> > 
> > and also please add "Linus Walleij <linus.walleij@linaro.org>" to the list
> > of recipients. As the gpio clock handling change does go through his
> > tree, the matching critical clock handling should also go through him.
> > 
> > 
> > Heiko
> > 
> >> Signed-off-by: Michael Niewoehner <linux@mniewoehner.de>
> >> ---
> >> drivers/clk/rockchip/clk-rk3188.c | 1 +
> >> 1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/drivers/clk/rockchip/clk-rk3188.c
> >> b/drivers/clk/rockchip/clk-rk3188.c index e4f9d47..1c93229 100644
> >> --- a/drivers/clk/rockchip/clk-rk3188.c
> >> +++ b/drivers/clk/rockchip/clk-rk3188.c
> >> @@ -708,6 +708,7 @@ static const char *const rk3188_critical_clocks[]
> >> __initconst = { "aclk_cpu",
> >> 
> >> 	"aclk_peri",
> >> 	"hclk_peri",
> >> 
> >> +	"pclk_cpu",
> >> };
> >> 
> >> static void __init rk3188_common_clk_init(struct device_node *np)
