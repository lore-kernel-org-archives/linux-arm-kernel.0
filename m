From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Sun, 18 Sep 2016 11:17:04 -0400
Subject: [PATCH 06/10] ARM: dts: exynos: Fix invalid GIC interrupt flags
 in exynos5
In-Reply-To: <1474054971-16831-7-git-send-email-krzk@kernel.org>
References: <1474054971-16831-1-git-send-email-krzk@kernel.org>
 <1474054971-16831-7-git-send-email-krzk@kernel.org>
Message-ID: <c64744b1-eab5-350b-7f87-86c159abffb6@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 09/16/2016 03:42 PM, Krzysztof Kozlowski wrote:
> Interrupt of type IRQ_TYPE_NONE is not allowed for GIC interrupts and
> generates an error:
> 	genirq: Setting trigger mode 0 for irq 16 failed (gic_set_type+0x0/0x68)
> 
> The GIC requires shared interrupts to be edge rising or level high.
> Platform declares support for both.  Choose level high everywhere.
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: Alban Browaeys <alban.browaeys@gmail.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

I tested this patch on an Exynos5800 Peach Pi Chromebook and
an Exynos5422 Odroid XU4 board and no regressions were found.

Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
