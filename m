From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 20 Aug 2014 09:22:23 -0400
Subject: [PATCH v17 8/9] irq: enable hip04 irq chip
In-Reply-To: <1407408695-19626-9-git-send-email-haojian.zhuang@linaro.org>
References: <1407408695-19626-1-git-send-email-haojian.zhuang@linaro.org>
 <1407408695-19626-9-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140820132223.GV12769@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian,

On Thu, Aug 07, 2014 at 06:51:34PM +0800, Haojian Zhuang wrote:
> HiP04 GIC is the variate of ARM GICv2.
> 
> ARM GICv2 supports 8 cores. HiP04 GIC extends to support 16 cores. It
> results that bit fields in GIC_DIST_TARGET & GIC_DIST_SOFTINT are
> different from ARM GICv2. And the maximium IRQ is downgrade from 1020 to 510.
> 
> Since different register offset & bitfields definitation breaks
> compartible with ARM GICv2, create a new hip04 irq driver.
> 
> And this driver is derived from irq-gic.c to support the Hisilicon HiP04
> interrupt controller, which is similar to the GIC, but deviates at some
> points. Support for power management, non-banked registers, cascaded
> GICs (and multiple controllers in general) and bigLittle support has
> been removed from the GIC driver.
> 
> Affinity related functions have been adjusted to match the Hisilicon
> hardware implementation.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  drivers/irqchip/Makefile    |   1 +
>  drivers/irqchip/irq-hip04.c | 424 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 425 insertions(+)
>  create mode 100644 drivers/irqchip/irq-hip04.c

Ok, I've tentatively applied this irqchip/hip04.  Once I merge that
branch into irqchip/core, you can consider it a stable base to merge in
with the rest of your series.  With everyone at KS this week, I'm going
to let things cook in -next a little longer than usual.  So, it'll
probably be early next week when I merge this in to irqchip/core.

fwiw, there are still a few things I'd like to comment on in this
driver.  However, we've beat it up enough.  As long as it isn't
adversely affecting irq-gic for everyone else, let's merge it and get
the ball moving.  My comments can easily be follow-on patches.

thx,

Jason.
