From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 14 Jun 2012 15:40:09 +0800
Subject: [PATCH 16/16] ARM: imx: enable SPARSE_IRQ for imx platform
In-Reply-To: <1339653587-4832-17-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-17-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAN1soZw5NZq1RP3z6w1P+5PQTjuT-hPucCwbiG3CQk0UpCacbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 1:59 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> As all irqchips on imx have been changed to allocate their irq_descs,
> and all unneeded mach/irqs.h inclusions on imx have been cleaned up,
> now it's time to select SPARSE_IRQ for imx/mxc.
>
> The SPARSE_IRQ support forces irqs allocation starting from 16. ?All
> those static irq number definition for SoCs need to shift 16 to keep
> non-DT boot works.
>
Do we really need to shift 16 to keep non-DT boot works?

I think that we can allocate "new irq numbers - NR_IRQS_LEGACY" in interrupt
controller in DT mode. And we needn't shift NR_IRQS_LEGACY in non-DT mode,
since irq numbers are already specified in .nr_irqs of machine description.

Maybe you can reference code in arch/arm/mach-mm/irq.c &
arch/arm/mach-mm/brownstone.c.

Regards
Haojian
