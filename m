From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 01 Jun 2018 23:19:23 -0700
Subject: [PATCH 1/2] clk: imx6ul: add GPIO clock gates
In-Reply-To: <1439344955.9677.1526991935718@email.1und1.de>
References: <1526959560-6014-1-git-send-email-Anson.Huang@nxp.com>
 <1439344955.9677.1526991935718@email.1und1.de>
Message-ID: <152792036327.225090.14543251343485084840@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stefan Wahren (2018-05-22 05:25:35)
> > +++ b/include/dt-bindings/clock/imx6ul-clock.h
> > @@ -242,20 +242,25 @@
> >  #define IMX6UL_CLK_CKO2_PODF         229
> >  #define IMX6UL_CLK_CKO2                      230
> >  #define IMX6UL_CLK_CKO                       231
> > +#define IMX6UL_CLK_GPIO1             232
> > +#define IMX6UL_CLK_GPIO2             233
> > +#define IMX6UL_CLK_GPIO3             234
> > +#define IMX6UL_CLK_GPIO4             235
> > +#define IMX6UL_CLK_GPIO5             236
> 
> this change looks like a breakage of devicetree ABI. You are changing the mean of the existing clock IDs on i.MX6ULL, which probably regress the combination of older DTBs with newer kernel.
> 

Agreed. Why can't we just tack on more numbers at the end?

> >  
> >  /* For i.MX6ULL */
> > -#define IMX6ULL_CLK_ESAI_PRED                232
