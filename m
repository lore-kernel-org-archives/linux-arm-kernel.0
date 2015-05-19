From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 19 May 2015 17:34:16 +0200
Subject: [PATCH v8 09/16] clockevents/drivers: Add STM32 Timer driver
In-Reply-To: <20150519145006.GH2067@n2100.arm.linux.org.uk>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <555B098A.8030202@linaro.org>
 <CALszF6AJ3Zf598wYeUx=iNWHHKT24xUyfagB=+4GocwZ-Fd-0g@mail.gmail.com>
 <6177628.0ZDPLeVyah@wuerfel>
 <CALszF6BZKD-CPTZ6Hc85wv2Z3Y7JmUv-cMkBtbk2Ga6WeeWU=A@mail.gmail.com>
 <555B3F80.8070605@linaro.org>
 <CALszF6A-De6dvcRNoa9ruL+y6Wt_rc7bi-O-VxHWkFF9NSt5_g@mail.gmail.com>
 <20150519145006.GH2067@n2100.arm.linux.org.uk>
Message-ID: <CALszF6CRXst-4UwMYeDLxrN_3N4Z9q1dxAR7CzFyngeM6Qeqzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-19 16:50 GMT+02:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>
> config CLKSRC_STM32
>         bool "Clocksource for STM32 SoCs" if COMPILE_TEST
>         depends on OF
>         select CLKSRC_MMIO
>
> This permits CLKSRC_STM32 to be selected by STM32 (provided OF is enabled,
> it's always going to be for that case, right?) while allowing the option
> to be visible when both OF!=n and COMPILE_TEST!=n.

Yes OF is always enabled when STM32.

So it fits our needs, as we only want the option to be visible when
both OF!=n and COMPILE_TEST!=n.

>
> Remember,
>
>         bool "string" if <condition-affects-visibility-of-string>
>         depends on <condition-affects-config-symbol-availability>
>
> The former merely hides the option from the user _if_ the condition fails.
> The latter _disables_ the option completely (except if you try and select
> it, at which point you end up with a Kconfig warning about that.)

Thanks for the reminder!
Maxime
