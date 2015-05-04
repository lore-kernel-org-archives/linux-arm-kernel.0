From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 04 May 2015 12:28:40 +0200
Subject: [PATCH v7 05/15] dt-bindings: Document the STM32 reset bindings
In-Reply-To: <5544A069.5000808@linaro.org>
References: <1430410844-16062-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1430410844-16062-6-git-send-email-mcoquelin.stm32@gmail.com>
 <55433467.2010603@linaro.org>
 <CALszF6Bw900E9MtpaVmvkFxsrOODRkNg+RxRXz5V3WghHtsxbw@mail.gmail.com>
 <5544A069.5000808@linaro.org>
Message-ID: <1430735320.3722.34.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, den 02.05.2015, 11:01 +0100 schrieb Daniel Thompson:
> On 02/05/15 08:55, Maxime Coquelin wrote:
> > 2015-05-01 10:08 GMT+02:00 Daniel Thompson <daniel.thompson@linaro.org>:
[...]
> >> Do you intend the clock driver to use the same compatible string (given it
> >> is the same bit of hardware).
> >>
> >> If so, is it better to use st,stm32f4-rcc here? It seems unlikey to me that
> >> the register layout of the PLLs and dividers can be the same on the f7 parts
> >> (and later).
> >
> > I agree we need a compatible dedicate to f4 series for clocks, and
> > maybe even one for f429 (to be checked).
> > For the reset part, we don't have this need.
> >
> > So either we use only "st,stm32f4" as you suggest, or we can have both
> > in device tree:
> >
> > rcc: reset at 40023800 {
> >      #reset-cells = <1>;
> >      compatible = "st,stm32f4-rcc", "st,stm32-rcc";
> >      reg = <0x40023800 0x400>;
> > };
> >
> > What do you think?
> 
> Having both makes sense. The reset driver probably doesn't care about 
> differences between F4 and F7 (I know very little about F7 but I can't 
> think of any obvious h/ware evolution that would confuse the current 
> reset driver).

Seconded, this is exactly the way compatible string lists are supposed
to be used.

[...]

regards
Philipp
