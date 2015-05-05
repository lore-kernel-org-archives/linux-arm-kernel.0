From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 05 May 2015 17:42:37 +0200
Subject: [PATCH v7 05/15] dt-bindings: Document the STM32 reset bindings
In-Reply-To: <CALszF6DyUA7Wr2qo4sASFBTRwwjhGAkFKRYnY+1UwHmf4nTj5w@mail.gmail.com>
References: <1430410844-16062-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1430410844-16062-6-git-send-email-mcoquelin.stm32@gmail.com>
 <55433467.2010603@linaro.org>
 <CALszF6Bw900E9MtpaVmvkFxsrOODRkNg+RxRXz5V3WghHtsxbw@mail.gmail.com>
 <5544A069.5000808@linaro.org>
 <CALszF6BTb0Ce6jfT5gY4eEtSep6+8XqOxu1LbpUXHmPYX9PmgQ@mail.gmail.com>
 <5548CEA2.8020807@linaro.org>
 <CALszF6DyUA7Wr2qo4sASFBTRwwjhGAkFKRYnY+1UwHmf4nTj5w@mail.gmail.com>
Message-ID: <1430840557.3035.60.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 05.05.2015, 17:19 +0200 schrieb Maxime Coquelin:
> >> For example, includes/dt-bindings/mfd/stm32f4-rcc.h would look like:
> >>
> >> #define GPIOA 0
> >> #define GPIOB 1
> >> ...
> >> #define LTDC 186

That looks a bit fragile.
At least the defines for the indices should be properly namespaced,
check out include/dt-bindings/gpio/tegra-gpio.h for a similar case.

> >> #define STM32F4_RESET(x) (x + 128)
> >> #define STM32F4_CLOCK(x) (x + 384)
> >>
> >> Then, in DT, a reset would be described like this:
> >>
> >> timer2 {
> >>      resets = <&rcc STM32F4_RESET(TIM2)>;
> >> };
> >>
> >> Phillip, Daniel, does that look acceptable to you?
> >
> >
> > Doesn't look unreasonable.
> >
> > I am a little uneasy simply because there are very few similar header files
> > in that directory but I haven't thought of a better idea.
> 
> Since this file will be shared by both clock and reset drivers, I
> don't see better option.
> I will implement it in v8 if Philipp agrees.

Are the device tree maintainers happy with this idiom spreading?
Except for the point above, I think this is acceptable.

regards
Philipp
