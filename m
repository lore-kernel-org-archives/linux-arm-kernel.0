From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 May 2015 16:05:36 +0200
Subject: [PATCH v8 09/16] clockevents/drivers: Add STM32 Timer driver
In-Reply-To: <555B3F80.8070605@linaro.org>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <CALszF6BZKD-CPTZ6Hc85wv2Z3Y7JmUv-cMkBtbk2Ga6WeeWU=A@mail.gmail.com>
 <555B3F80.8070605@linaro.org>
Message-ID: <2641240.S39i1jrT81@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 May 2015 15:49:52 Daniel Lezcano wrote:
> On 05/19/2015 03:42 PM, Maxime Coquelin wrote:
> > 2015-05-19 12:55 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
> >> Please also make it possible to select this driver on other architectures
> >> with COMPILE_TEST, so we get coverage from all the x86 test infrastructure.
> >
> > You proposal is to revert back to the original patch, except that
> > ARCH_STM32 should select CLKSRC_STM32, right?
> >
> > Daniel, what do you think?
> 
> It is not exactly as the initial patch.
> 
> I think Arnd is proposing:
> 
> config CLKSRC_STM32
>         bool "Clocksource for STM32 SoCs" if COMPILE_TEST
>         select CLKSRC_MMIO

Yes, that's fine, although we might also need a 'depends on OF'
line, not sure.

	Arnd
