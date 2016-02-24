From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Feb 2016 09:53:55 +0100
Subject: [PATCH] ARM: realview: DT support for the PBA8
In-Reply-To: <1456303714-31039-1-git-send-email-linus.walleij@linaro.org>
References: <1456303714-31039-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <30042109.XpH2Vid3ZU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 February 2016 09:48:34 Linus Walleij wrote:
> This adds a devicetree for the ARM RealView PBA8 platform,
> also known as HBI-0178, "RealView(R) Platform Baseboard for
> Cortex(TM)-A8".

Nice!

> Tested in QEMU with -M realview-pb-a8 and works like a charm,
> however with these annoying boot messages:
> 
> of_amba_device_create(): amba_device_add()
>     failed (-19) for /soc/sysctl at 10001000
> of_amba_device_create(): amba_device_add()
>     failed (-19) for /soc/ssp at 1000d000
> of_amba_device_create(): amba_device_add()
>     failed (-19) for /soc/timer at 10018000
> of_amba_device_create(): amba_device_add()
>     failed (-19) for /soc/timer at 10019000
> of_amba_device_create(): amba_device_add()
>     failed (-19) for /soc/sysctl at 1001a000
> 
> I think this is because these PrimeCells do not exist in the
> QEMU machine model but would work fine on the real hardware.
> QEMU still works, because the SP810 clocks will anyway probe,
> as they are not amba_devices but use the special CLK_OF_DECLARE()
> probing macro.
> 

I think we can treat this as a harmless qemu deficiency.

It would be nice to fix qemu to avoid the warnings, but as you say
it's not a showstopper.

	Arnd
