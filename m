From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 3 Sep 2014 07:57:28 -0400
Subject: [PATCH v2] irqchip: exynos-combiner: Fix compilation error on
 ARM64
In-Reply-To: <1409722329-18309-1-git-send-email-ch.naveen@samsung.com>
References: <1409722329-18309-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <20140903115728.GJ30467@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 03, 2014 at 11:02:09AM +0530, Naveen Krishna Chatradhi wrote:
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
> Fix the build error by including linux/interrupt.h.
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> ---
> Changes since v1:
> Used linux/interrupt.h instead of asm/hardirq.h
> 
>  drivers/irqchip/exynos-combiner.c |    1 +
>  1 file changed, 1 insertion(+)

Applied to irqchip/urgent

thx,

Jason.
