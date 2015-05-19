From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 19 May 2015 15:49:52 +0200
Subject: [PATCH v8 09/16] clockevents/drivers: Add STM32 Timer driver
In-Reply-To: <CALszF6BZKD-CPTZ6Hc85wv2Z3Y7JmUv-cMkBtbk2Ga6WeeWU=A@mail.gmail.com>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>	<555B098A.8030202@linaro.org>	<CALszF6AJ3Zf598wYeUx=iNWHHKT24xUyfagB=+4GocwZ-Fd-0g@mail.gmail.com>	<6177628.0ZDPLeVyah@wuerfel>
 <CALszF6BZKD-CPTZ6Hc85wv2Z3Y7JmUv-cMkBtbk2Ga6WeeWU=A@mail.gmail.com>
Message-ID: <555B3F80.8070605@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/2015 03:42 PM, Maxime Coquelin wrote:
> 2015-05-19 12:55 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>> Please also make it possible to select this driver on other architectures
>> with COMPILE_TEST, so we get coverage from all the x86 test infrastructure.
>
> You proposal is to revert back to the original patch, except that
> ARCH_STM32 should select CLKSRC_STM32, right?
>
> Daniel, what do you think?

It is not exactly as the initial patch.

I think Arnd is proposing:

config CLKSRC_STM32
	bool "Clocksource for STM32 SoCs" if COMPILE_TEST
	select CLKSRC_MMIO





-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
