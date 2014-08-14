From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 14 Aug 2014 10:41:33 +0800
Subject: [PATCH v17 8/9] irq: enable hip04 irq chip
In-Reply-To: <1407408695-19626-9-git-send-email-haojian.zhuang@linaro.org>
References: <1407408695-19626-1-git-send-email-haojian.zhuang@linaro.org>
 <1407408695-19626-9-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CAD6h2NQMXb2XPbg4noQW65zKeAF7b5Av6FjHqnkYOJxRZddtAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 August 2014 18:51, Haojian Zhuang <haojian.zhuang@linaro.org> wrote:
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
>

Hi Jason,

All other HiP04 patches are ready. How do you think about this one? Is
it OK for you? If so,
will you take it into your git tree or we take it through armsoc tree
with your Ack?

Best Regards
Haojian
