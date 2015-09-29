From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 29 Sep 2015 23:01:31 +0800
Subject: [PATCH v3 3/7] irqchip/gic: Convert the GIC driver to ACPI probing
In-Reply-To: <1443451758-22717-4-git-send-email-marc.zyngier@arm.com>
References: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com>
 <1443451758-22717-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <560AA7CB.7020600@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2015 10:49 PM, Marc Zyngier wrote:
> Now that we have a basic infrastructure to register irqchips and
> call them on discovery of a matching entry in MADT, convert the
> GIC driver to this new probing method.
>
> It ends up being a code deletion party, which is a rather good thing.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm64/include/asm/acpi.h        |  1 -
>   arch/arm64/include/asm/irq.h         |  2 --
>   arch/arm64/kernel/acpi.c             | 25 -------------
>   drivers/irqchip/irq-gic.c            | 69 ++++++++++++++++++------------------
>   drivers/irqchip/irqchip.c            |  3 --
>   include/linux/irqchip/arm-gic-acpi.h | 31 ----------------
>   6 files changed, 35 insertions(+), 96 deletions(-)
>   delete mode 100644 include/linux/irqchip/arm-gic-acpi.h

I love the code deletion party too :)

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
