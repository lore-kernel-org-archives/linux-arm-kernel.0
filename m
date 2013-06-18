From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jun 2013 16:01:16 +0200
Subject: [PATCH v3 06/10] clk: exynos5420: register clocks using common
 clock framework
In-Reply-To: <CANuQgHHoUyE5e+MnnpzWLxcFNcD11FjYwx76pucw7peV4qmFkQ@mail.gmail.com>
References: <1371466836-4111-1-git-send-email-chander.kashyap@linaro.org>
 <3875156.5RFgBjMoqF@wuerfel>
 <CANuQgHHoUyE5e+MnnpzWLxcFNcD11FjYwx76pucw7peV4qmFkQ@mail.gmail.com>
Message-ID: <201306181601.16795.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Chander Kashyap wrote:
> >> +       [Core Clocks]
> >> +
> >> +  Clock                      ID
> >> +  ----------------------------
> >> +
> >> +  fin_pll            1
> >> +
> >> +  [Clock Gate for Special Clocks]
> >> +
> >> +  Clock                      ID
> >> +  ----------------------------
> >> +  sclk_uart0         128
> >> +  sclk_uart1         129
> >> +  sclk_uart2         130
> >
> >> +
> >> +   [Peripheral Clock Gates]
> >> +
> >> +  Clock                      ID
> >> +  ----------------------------
> >> +
> >> +  aclk66_peric               256
> >> +  uart0                      257
> >> +  uart1                      258
> >
> > It looks like these are actually separate things. Wouldn't it be more sensible
> > to have separate device nodes for each of the lists and use a local index?
> I have listed the parent clock first, then the child clocks, to
> maintain  readability.
> >
> > What numbers are used in the data sheet?
> I didn't get your point?

I would have expected three clock device nodes, one for fin_pll (presumably a
fixed-rate clock?), one for "special clocks" and one for "peripheral clock
gates", and a number space starting at '1' for each of them, rather than
having a shared node and numbers starting at '1', '128' and '256', which looks
a bit clumsy.

Did you take the ID number definitions from a data sheet, or did you make up
the numbers yourself for the purpose of defining a binding?

	Arnd
