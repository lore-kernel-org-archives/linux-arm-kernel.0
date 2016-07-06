From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 06 Jul 2016 21:59:48 +0200
Subject: [PATCH 00/22] ARM: clps711x: Switch to DT and Multiplatform
In-Reply-To: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
References: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
Message-ID: <3364202.xZFayybK9O@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, June 4, 2016 10:09:52 AM CEST Alexander Shiyan wrote:
> The Cirrus Logic company announced EOL on May 20 this year for the
> ARMv4 processors, so the company where I work ceases the use of the CPU
> for our devices and switches our boards to use with another type of CPU.
> I can not continue develop for this platform, so I gathered all the
> existing patches/solutions for the final series. Of course, we keep
> support our existing products with this CPU, so I remain able to check
> any third-party patches.
> This series of patches switches CLPS711X platform for use with device
> tree and adds multiplatform support.
> The series contain various subsystem changes but designed for applying
> directly in the ARM-SOC tree.
> 

I've applied the majority of these into arm-soc now. I did not
care much about ordering for bisection except for build coverage,
as we already broke bisection when the gpio changes got applied.

I'm sure nobody cares about it too much.

> Alexander Shiyan (22):
>   ARM: clps711x: Reduce static map size

next/soc

>   clk: clps711x: Changing the compatibility string to match with the
>     smallest supported chip
>   clocksource: clps711x: Changing the compatibility string to match with
>     the smallest supported chip
>   irqchip: clps711x: Changing the compatibility string to match with the
>     smallest supported chip
>   serial: clps711x: Changing the compatibility string to match with the
>     smallest supported chip
>   pwm: clps711x: Changing the compatibility string to match with the
>     smallest supported chip

next/drivers

>   gpio: clps711x: Changing the compatibility string to match with the
>     smallest supported chip
>   gpio: syscon: Changing the compatibility string to match with the
>     smallest supported chip

already merged in gpio tree

>   input: clps711x-keypad: Changing the compatibility string to match
>     with the smallest supported chip
>   video: clps711x-fb: Changing the compatibility string to match with
>     the smallest supported chip

next/drivers

>   ARM: clps711x: Add basic DT support

next/soc

>   ARM: dts: clps711x: Add DT Cirrus Logic EDB7211 Development board

next/dt

>   spi: clps711x: Driver refactor

I've sent this to Mark Brown along with the missing binding description.
I'll either add this one here, or he can pick it up into the spi tree.

>   ARM: clps711x: Remove board support

next/soc

>   video: clps711x: Remove old driver
>   clk: clps711x: Remove board support
>   clocksource: clps711x: Remove board support
>   irqchip: clps711x: Remove board support
>   serial: clps711x: Remove board support
>   gpio: clps711x: Remove board support

I've skipped these for now, I think I'll just resend them after the
merge window.

>   ARM: clps711x: Switch to MULTIPLATFORM

next/soc

>   ARM: config: Add a multi_v4t_defconfig

next/defconfig

Sorry for the delay. I hope this works out and I didn't miss any additional
compile-time dependencies.

	Arnd
