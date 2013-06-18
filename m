From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 18 Jun 2013 16:26:56 +0200
Subject: [PATCH v3 06/10] clk: exynos5420: register clocks using common
 clock framework
In-Reply-To: <201306181601.16795.arnd@arndb.de>
References: <1371466836-4111-1-git-send-email-chander.kashyap@linaro.org>
 <CANuQgHHoUyE5e+MnnpzWLxcFNcD11FjYwx76pucw7peV4qmFkQ@mail.gmail.com>
 <201306181601.16795.arnd@arndb.de>
Message-ID: <9285029.CIld1HyBWB@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tuesday 18 of June 2013 16:01:16 Arnd Bergmann wrote:
> On Tuesday 18 June 2013, Chander Kashyap wrote:
> > >> +       [Core Clocks]
> > >> +
> > >> +  Clock                      ID
> > >> +  ----------------------------
> > >> +
> > >> +  fin_pll            1
> > >> +
> > >> +  [Clock Gate for Special Clocks]
> > >> +
> > >> +  Clock                      ID
> > >> +  ----------------------------
> > >> +  sclk_uart0         128
> > >> +  sclk_uart1         129
> > >> +  sclk_uart2         130
> > >> 
> > >> +
> > >> +   [Peripheral Clock Gates]
> > >> +
> > >> +  Clock                      ID
> > >> +  ----------------------------
> > >> +
> > >> +  aclk66_peric               256
> > >> +  uart0                      257
> > >> +  uart1                      258
> > > 
> > > It looks like these are actually separate things. Wouldn't it be more
> > > sensible to have separate device nodes for each of the lists and use a
> > > local index?> 
> > I have listed the parent clock first, then the child clocks, to
> > maintain  readability.
> > 
> > > What numbers are used in the data sheet?
> > 
> > I didn't get your point?
> 
> I would have expected three clock device nodes, one for fin_pll (presumably
> a fixed-rate clock?), one for "special clocks" and one for "peripheral
> clock gates", and a number space starting at '1' for each of them, rather
> than having a shared node and numbers starting at '1', '128' and '256',
> which looks a bit clumsy.
> 
> Did you take the ID number definitions from a data sheet, or did you make up
> the numbers yourself for the purpose of defining a binding?

This is a binding that has been defined for Samsung Common Clock Framework 
drivers. Exynos4 and Exynos5250 use the same convention. The numbers are 
defined in a way that should allow adding further clocks of particular types in 
future as need for such shows up.

Physically there is one clock controller (CMU) which has a lot of dividers, 
muxes and gates and so it is represented as a single device node.

Best regards,
Tomasz

> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
