From: slemieux.tyco@gmail.com (Sylvain Lemieux (gmail))
Date: Wed, 21 Sep 2016 13:41:07 -0400
Subject: [PATCH] clk: nxp: clk-lpc32xx: Unmap region obtained by of_iomap
In-Reply-To: <162fe71f-e190-3511-6b06-35efdbc8573f@mleia.com>
References: <1474368846-15916-1-git-send-email-arvind.yadav.cs@gmail.com>
 <162fe71f-e190-3511-6b06-35efdbc8573f@mleia.com>
Message-ID: <1474479667.13453.0.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-09-21 at 13:17 +0300, Vladimir Zapolskiy wrote:
> On 20.09.2016 13:54, Arvind Yadav wrote:
> > From: Arvind Yadav <arvind.yadav.cs@gmail.com>
> > 
> > Free memory mapping, if lpc32xx_clk_init is not successful.
> > 
> > Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> > ---
> >  drivers/clk/nxp/clk-lpc32xx.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/clk/nxp/clk-lpc32xx.c b/drivers/clk/nxp/clk-lpc32xx.c
> > index 90d740a..34c9735 100644
> > --- a/drivers/clk/nxp/clk-lpc32xx.c
> > +++ b/drivers/clk/nxp/clk-lpc32xx.c
> > @@ -1513,6 +1513,7 @@ static void __init lpc32xx_clk_init(struct device_node *np)
> >  	if (IS_ERR(clk_regmap)) {
> >  		pr_err("failed to regmap system control block: %ld\n",
> >  			PTR_ERR(clk_regmap));
> > +		iounmap(base);
> >  		return;
> >  	}
> >  
> > 
> 
> Acked-by: Vladimir Zapolskiy <vz@mleia.com>
> 
> Thank you for the patch.
> 
Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>

> --
> With best wishes,
> Vladimir
> 
> 
