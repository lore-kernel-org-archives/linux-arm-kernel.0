From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Mon, 30 Jul 2018 14:30:25 +0900
Subject: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
In-Reply-To: <1532624495.2283.197.camel@impinj.com>
References: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com>	
 <1532588943-19481-3-git-send-email-hayashibara.keiji@socionext.com>	
 <CAHp75VcEdxDEo0T5_9BzOPaeaqjbmbrWmaE9+ZuUDYhjh6jpVw@mail.gmail.com>
 <1532624495.2283.197.camel@impinj.com>
Message-ID: <002901d427c6$6b9a4ff0$42ceefd0$@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Trent and Andy,

> From: Trent Piepho [mailto:tpiepho at impinj.com]
> Sent: Friday, July 27, 2018 2:02 AM
> To: andy.shevchenko at gmail.com; Hayashibara, Keiji/?? ?? <hayashibara.keiji@socionext.com>
> Subject: Re: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
> 
> On Thu, 2018-07-26 at 11:46 +0300, Andy Shevchenko wrote:
> > > +
> > > +       /*
> > > +        * the supported rates are even numbers from 4 to 254. (4,6,8...254)
> > > +        * round up as we look for equal or less speed
> > > +        */
> > > +       ckrat = DIV_ROUND_UP(clk_get_rate(priv->clk), speed);
> > > +       ckrat = roundup(ckrat, 2);
> >
> > ckrat += ckrat & 1;
> 
> Either way, the compiler produces the same code:
> 
>  add r0, r0, #1 
>  bic r0, r0, #1
> 
> I.e., ckrat = (ckrat + 1) & ~1, one "add" and one "and".
> 
> Might as well use the macro so it's clear. There is also round_up(x,y), which I believe is intended to be used
> only with power of 2 values of y.

I confirmed round_up() macro.
This macro is optimized to power of 2 argument,
and it matches to this case and clear.

I will replace to round_up() macro.

Thank you.

-----------------
Best Regards,
Keiji Hayashibara
