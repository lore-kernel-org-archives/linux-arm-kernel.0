From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 24 Feb 2016 10:18:33 +0000
Subject: [PATCH] ARM: realview: DT support for the PBA8
In-Reply-To: <1456303714-31039-1-git-send-email-linus.walleij@linaro.org>
References: <1456303714-31039-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAFEAcA8hH2Q0LXp_vDiyTCLYX4xFff_fkp7=saPmi-ET104SHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 February 2016 at 08:48, Linus Walleij <linus.walleij@linaro.org> wrote:
> This adds a devicetree for the ARM RealView PBA8 platform,
> also known as HBI-0178, "RealView(R) Platform Baseboard for
> Cortex(TM)-A8".
>
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

The missing timers would be a two-line QEMU patch,
as would the ssp, since we have SP804 and PL022 device
models. We have no model of the SP810 but it would probably
not be too hard to write a "mostly does nothing" version.
Patches welcome :-)

thanks
-- PMM
