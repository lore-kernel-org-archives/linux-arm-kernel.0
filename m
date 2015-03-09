From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Mar 2015 16:50:26 +0100
Subject: [PATCH v2 04/18] clocksource: Add ARM System timer driver
In-Reply-To: <1424455277-29983-5-git-send-email-mcoquelin.stm32@gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1424455277-29983-5-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <CACRpkdYnj0vTBVEEDp4isznRZ+KQuC2h+VViZr=Pt8VtEOWP-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 7:01 PM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:

> This patch adds clocksource support for ARMv7-M's System timer,
> also known as SysTick.
>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
(...)
> +       /* If no clock found, try to get clock-frequency property */
> +       if (!rate) {
> +               ret = of_property_read_u32(np, "clock-frequency", &rate);
> +               if (ret)
> +                       goto out_unmap;
> +       }

If this driver is only used for this one system, and if on this one system
the clk subsystem will provide the clock rate, then there is no need
to include this hackaround property.

Alternatively there is no point including reading the frequency from
the clk subsystem for this one system.

So which one is it?

Yours,
Linus Walleij
