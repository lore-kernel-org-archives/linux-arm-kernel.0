From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 13 Dec 2017 16:57:50 -0600
Subject: [PATCH 1/3] dt-bindings: chosen: Add clocksource and clockevent
 selection
In-Reply-To: <20171213185313.20017-2-alexandre.belloni@free-electrons.com>
References: <20171213185313.20017-1-alexandre.belloni@free-electrons.com>
 <20171213185313.20017-2-alexandre.belloni@free-electrons.com>
Message-ID: <CAL_JsqLm5n6s=cr2hBZp4H9pDPKHUOPWs94JMWYFYJ3hsMMxZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 13, 2017 at 12:53 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> The clocksource and clockevent timer are probed early in the boot process.
> At that time it is difficult for linux to know whether a particular timer
> can be used as the clocksource or the clockevent or by another driver,
> especially when they are all identical or have similar features.

If all identical, then it shouldn't matter. "similar" means some
difference. Describe those differences.

> Until now, multiple strategies have been used to solve that:
>  - use Kconfig option as MXC_USE_EPIT or ATMEL_TCB_CLKSRC_BLOCK

Compile time probably means only one option is really used.

>  - use a kernel parameter as the "clocksource" early_param in mach-omap2

Yeah, OMAP was one of the previous times this came up and also
attempted something like this. This parameter predates selecting
timers based on features described in DT. Look at commit
2eb03937df3ebc (ARM: OMAP3: Update clocksource timer selection).

>  - registering the first seen timer as a clockevent and the second one as
>  a clocksource as in rk_timer_init or dw_apb_timer_init
>
> Add a linux,clocksource and a linux,clockevent node in chosen with a timer
> property pointing to the timer to use. Other properties, like the targeted
> precision may be added later.

Open ended expansion of this does not help convince me it is needed.

Rob
