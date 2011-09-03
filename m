From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sat, 3 Sep 2011 19:04:31 +0530
Subject: [RFC PATCH 0/3] Yet another GIC OF binding series
In-Reply-To: <1312921020-6820-1-git-send-email-robherring2@gmail.com>
References: <1312921020-6820-1-git-send-email-robherring2@gmail.com>
Message-ID: <CAJuYYwT9ZB-4O9fnMT_svFY=X4bBZhs0U6=Zp-cCaWhxLgpmAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 August 2011 01:46, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Grant,
>
> Here's yet another patch series for GIC binding and init.
>
> You keep saying we should have a common DT function scanning for interrupt
> controller nodes and calling their initialization functions. But that will
> not work until we have dynamic assignment of linux irq numbers. So either
> everyone should just stop trying to do DT bindings for GIC/VIC until that
> is in place, or we need an interim solution. This is another attempt at
> the latter. I reworked gic_of_init intending for it to be the interrupt
> controller specific initialization function that DT interrupt controller
> scanning code would call. For now, it is just called by the platform code.
> The platform initialization looks something like this:
>
> struct of_intc_desc desc;
> memset(&desc, 0, sizeof(desc));
> desc.controller = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-gic");
> gic_of_init(&desc);
>
> I've addressed your previous comments and in particular initializing more
> than 1 GIC is supported now.

Works fine for Exynos4.

Tested-by: Thomas Abraham <thomas.abraham@linaro.org>

>
> Rob
>
> Rob Herring (3):
> ?dt: irq: add interrupt controller descriptor struct
> ?ARM: gic: allow irq_start to be 0
> ?ARM: gic: add OF based initialization
>
> ?Documentation/devicetree/bindings/arm/gic.txt | ? 28 +++++++++++++++++++
> ?arch/arm/common/gic.c ? ? ? ? ? ? ? ? ? ? ? ? | ? 36 ++++++++++++++++++++++++-
> ?arch/arm/include/asm/hardware/gic.h ? ? ? ? ? | ? ?2 +
> ?include/linux/of_irq.h ? ? ? ? ? ? ? ? ? ? ? ?| ? ?6 ++++
> ?4 files changed, 71 insertions(+), 1 deletions(-)
> ?create mode 100644 Documentation/devicetree/bindings/arm/gic.txt
>
> --
> 1.7.4.1
>
>
