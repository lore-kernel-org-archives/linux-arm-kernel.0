From: robh@kernel.org (Rob Herring)
Date: Wed, 16 Sep 2015 09:12:13 -0500
Subject: [PATCH v3 RESEND 0/5] Remaining part of kill off set_irq_flags
 usage
In-Reply-To: <1440889285-5637-1-git-send-email-robh@kernel.org>
References: <1440889285-5637-1-git-send-email-robh@kernel.org>
Message-ID: <55F978BD.3030203@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/29/2015 06:01 PM, Rob Herring wrote:
> Thomas,
> 
> As requested, here are the remaining patches for killing off 
> set_irq_flags which have not been picked up. The rest of the 
> series has been picked up and are in -next. 

Thomas, are you going to pick up these remaining patches?

Rob

> 
> Rob
> 
> Rob Herring (5):
>   gpu/drm: kill off set_irq_flags usage
>   irqchip: kill off set_irq_flags usage
>   sh: kill off set_irq_flags usage
>   ARM: remove ununsed set_irq_flags
>   arm64: remove ununsed set_irq_flags
> 
>  arch/arm/include/asm/hw_irq.h             |  6 ------
>  arch/arm/kernel/irq.c                     | 20 --------------------
>  arch/arm64/include/asm/hardirq.h          |  5 -----
>  drivers/gpu/drm/msm/mdp/mdp5/mdp5_irq.c   |  1 -
>  drivers/gpu/ipu-v3/ipu-common.c           |  3 +--
>  drivers/irqchip/exynos-combiner.c         |  2 +-
>  drivers/irqchip/irq-armada-370-xp.c       |  3 +--
>  drivers/irqchip/irq-bcm2835.c             |  2 +-
>  drivers/irqchip/irq-clps711x.c            |  6 +++---
>  drivers/irqchip/irq-gic-v3.c              |  5 ++---
>  drivers/irqchip/irq-gic.c                 |  4 ++--
>  drivers/irqchip/irq-hip04.c               |  4 ++--
>  drivers/irqchip/irq-keystone.c            |  2 +-
>  drivers/irqchip/irq-mmp.c                 |  3 ---
>  drivers/irqchip/irq-mxs.c                 |  1 -
>  drivers/irqchip/irq-renesas-intc-irqpin.c |  1 -
>  drivers/irqchip/irq-renesas-irqc.c        |  1 -
>  drivers/irqchip/irq-s3c24xx.c             | 14 ++------------
>  drivers/irqchip/irq-sun4i.c               |  2 +-
>  drivers/irqchip/irq-versatile-fpga.c      |  2 +-
>  drivers/irqchip/irq-vic.c                 |  2 +-
>  drivers/irqchip/irq-vt8500.c              |  1 -
>  drivers/irqchip/spear-shirq.c             |  1 -
>  drivers/sh/intc/internals.h               | 10 +---------
>  24 files changed, 20 insertions(+), 81 deletions(-)
> 
