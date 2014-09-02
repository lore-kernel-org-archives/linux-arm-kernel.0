From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 2 Sep 2014 13:56:21 -0400
Subject: [PATCH] irqchip: exynos-combiner: Fix compilation error on ARM64
In-Reply-To: <1409671492-7725-1-git-send-email-ch.naveen@samsung.com>
References: <1409671492-7725-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <20140902175621.GG30467@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Naveen,

On Tue, Sep 02, 2014 at 08:54:52PM +0530, Naveen Krishna Chatradhi wrote:
> The following compilation error occurs on 64-bit Exynos7 SoC:
> 
> drivers/irqchip/exynos-combiner.c: In function ?combiner_irq_domain_map?:
> drivers/irqchip/exynos-combiner.c:162:2: error: implicit declaration of function ?set_irq_flags? [-Werror=implicit-function-declaration]
>   set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
>   ^
> drivers/irqchip/exynos-combiner.c:162:21: error: ?IRQF_VALID? undeclared (first use in this function)
>   set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
>                      ^
> drivers/irqchip/exynos-combiner.c:162:21: note: each undeclared identifier is reported only once for each function it appears in
> drivers/irqchip/exynos-combiner.c:162:34: error: ?IRQF_PROBE? undeclared (first use in this function)
>   set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
> 
> Fix the build error by including asm/hardirq.h.
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/irqchip/exynos-combiner.c |    2 ++
>  1 file changed, 2 insertions(+)

Please include me in the Cc on future irqchip fixes, I almost missed
this one.

thx,

Jason.
