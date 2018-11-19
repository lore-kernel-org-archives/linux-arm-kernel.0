From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 19 Nov 2018 14:56:26 +0100
Subject: [PATCH] ARM: smp_twd: Remove legacy TWD registration
In-Reply-To: <20181115100659.18256-1-geert+renesas@glider.be>
References: <20181115100659.18256-1-geert+renesas@glider.be>
Message-ID: <CACRpkdY9ZPj0h5ZHnZsdMBe4o4aQ7dRanU=m6Q+r=5tP-oqYgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 12:24 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> As of commit 7484c727b636a838 ("ARM: realview: delete the RealView board
> files"), the ARM Timer and Watchdog Unit is instantiated from DT only.
> Moreover, the driver is selected from ARCH_MULTIPLATFORM platforms only,
> which implies OF, TIMER_OF, and COMMON_CLK.
>
> Hence remove all unused legacy infrastructure from the driver.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Good riddance.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

>  arch/arm/kernel/smp_twd.c      | 66 ----------------------------------

Does this driver have some intimate relationship to the arch
or can we move it to drivers/clocksource?

Yours,
Linus Walleij
