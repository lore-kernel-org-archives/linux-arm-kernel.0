From: dongas86@gmail.com (Dong Aisheng)
Date: Sun, 12 Jun 2016 19:52:57 +0800
Subject: [PATCH 06/11] clk: imx6ul: fix gpt2 clock names
In-Reply-To: <20160612114111.GD20243@tiger>
References: <1465396420-27064-1-git-send-email-aisheng.dong@nxp.com>
 <1465396420-27064-6-git-send-email-aisheng.dong@nxp.com>
 <20160612114111.GD20243@tiger>
Message-ID: <20160612115256.GC32690@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2016 at 07:41:11PM +0800, Shawn Guo wrote:
> On Wed, Jun 08, 2016 at 10:33:35PM +0800, Dong Aisheng wrote:
> > fix gpt2 clock names
> > 
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  drivers/clk/imx/clk-imx6ul.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
> > index 0f1f17a8f3ed..67ae3465dd37 100644
> > --- a/drivers/clk/imx/clk-imx6ul.c
> > +++ b/drivers/clk/imx/clk-imx6ul.c
> > @@ -305,8 +305,8 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
> >  	clks[IMX6UL_CLK_CAN1_SERIAL]	= imx_clk_gate2("can1_serial",	"can_podf",	base + 0x68,	16);
> >  	clks[IMX6UL_CLK_CAN2_IPG]	= imx_clk_gate2("can2_ipg",	"ipg",		base + 0x68,	18);
> >  	clks[IMX6UL_CLK_CAN2_SERIAL]	= imx_clk_gate2("can2_serial",	"can_podf",	base + 0x68,	20);
> > -	clks[IMX6UL_CLK_GPT2_BUS]	= imx_clk_gate2("gpt_bus",	"perclk",	base + 0x68,	24);
> > -	clks[IMX6UL_CLK_GPT2_SERIAL]	= imx_clk_gate2("gpt_serial",	"perclk",	base + 0x68,	26);
> > +	clks[IMX6UL_CLK_GPT2_BUS]	= imx_clk_gate2("gpt_bus2",	"perclk",	base + 0x68,	24);
> > +	clks[IMX6UL_CLK_GPT2_SERIAL]	= imx_clk_gate2("gpt_serial2",	"perclk",	base + 0x68,	26);
> 
> gpt2_bus and gpt2_serial, please.
> 

Yes, sorry the careless.
Will resend it.

Regards
Dong Aisheng

> Shawn
> 
> >  	clks[IMX6UL_CLK_UART2_IPG]	= imx_clk_gate2("uart2_ipg",	"ipg",		base + 0x68,	28);
> >  	clks[IMX6UL_CLK_UART2_SERIAL]	= imx_clk_gate2("uart2_serial",	"uart_podf",	base + 0x68,	28);
> >  	clks[IMX6UL_CLK_AIPSTZ3]	= imx_clk_gate2("aips_tz3",	"ahb",		base + 0x68,	30);
> > -- 
> > 1.9.1
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
