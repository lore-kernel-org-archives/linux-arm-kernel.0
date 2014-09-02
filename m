From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 02 Sep 2014 17:00:08 +0100
Subject: [PATCH] irqchip: exynos-combiner: Fix compilation error on ARM64
In-Reply-To: <1409671492-7725-1-git-send-email-ch.naveen@samsung.com>
References: <1409671492-7725-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <5405E988.7050707@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/09/14 16:24, Naveen Krishna Chatradhi wrote:
> The following compilation error occurs on 64-bit Exynos7 SoC:
>
> drivers/irqchip/exynos-combiner.c: In function ?combiner_irq_domain_map?:
> drivers/irqchip/exynos-combiner.c:162:2: error: implicit declaration of function ?set_irq_flags? [-Werror=implicit-function-declaration]
>    set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
>    ^
> drivers/irqchip/exynos-combiner.c:162:21: error: ?IRQF_VALID? undeclared (first use in this function)
>    set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
>                       ^
> drivers/irqchip/exynos-combiner.c:162:21: note: each undeclared identifier is reported only once for each function it appears in
> drivers/irqchip/exynos-combiner.c:162:34: error: ?IRQF_PROBE? undeclared (first use in this function)
>    set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
>
> Fix the build error by including asm/hardirq.h.
>

You should avoid using asm headers whenever possible esp. in driver
code. linux/hardirq.h or much better linux/interrupt.h should fix this
error.

Regards,
Sudeep
