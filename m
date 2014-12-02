From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Dec 2014 14:22:33 +0100
Subject: [PATCH] arm: perf: Directly handle SMP platforms with one SPI
In-Reply-To: <1416581603-30557-1-git-send-email-daniel.thompson@linaro.org>
References: <1416581603-30557-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <CACRpkdaof9hW2rbH4eDNWMCiaW7+aNE_2TNyMbz+B4aqaJfsgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 3:53 PM, Daniel Thompson
<daniel.thompson@linaro.org> wrote:

> Some ARM platforms mux the PMU interrupt of every core into a single
> SPI. On such platforms if the PMU of any core except 0 raises an interrupt
> then it cannot be serviced and eventually, if you are lucky, the spurious
> irq detection might forcefully disable the interrupt.
>
> On these SoCs it is not possible to determine which core raised the
> interrupt so workaround this issue by queuing irqwork on the other
> cores whenever the primary interrupt handler is unable to service the
> interrupt.
>
> The u8500 platform has an alternative workaround that dynamically alters
> the affinity of the PMU interrupt. This workaround logic is no longer
> required so the original code is removed as is the hook it relied upon.
>
> Tested on imx6q (which has fours cores/PMUs all muxed to a single SPI).
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

After som pain I managed to compile and test this with perf.
Works like a charm.

Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
