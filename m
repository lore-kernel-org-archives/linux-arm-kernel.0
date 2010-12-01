From: mcuos.com@gmail.com (Wan ZongShun)
Date: Wed, 1 Dec 2010 09:47:14 +0800
Subject: [PATCH 34/54] ARM: nuc93x: irq_data conversion.
In-Reply-To: <20101130134106.GI15575@mail.wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
	<20101130134106.GI15575@mail.wantstofly.org>
Message-ID: <AANLkTinHLg4px0jXKr=6H4tSbLM2akPrRtSvSu8C5Zf=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/30 Lennert Buytenhek <buytenh@wantstofly.org>:
> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
> ---
> ?arch/arm/mach-nuc93x/irq.c | ? 16 ++++++++--------
> ?1 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-nuc93x/irq.c b/arch/arm/mach-nuc93x/irq.c
> index a7a88ea..1f8a05a 100644
> --- a/arch/arm/mach-nuc93x/irq.c
> +++ b/arch/arm/mach-nuc93x/irq.c
> @@ -25,9 +25,9 @@
> ?#include <mach/hardware.h>
> ?#include <mach/regs-irq.h>
>
> -static void nuc93x_irq_mask(unsigned int irq)
> +static void nuc93x_irq_mask(struct irq_data *d)
> ?{
> - ? ? ? __raw_writel(1 << irq, REG_AIC_MDCR);
> + ? ? ? __raw_writel(1 << d->irq, REG_AIC_MDCR);
> ?}
>
> ?/*
> @@ -35,21 +35,21 @@ static void nuc93x_irq_mask(unsigned int irq)
> ?* to REG_AIC_EOSCR for ACK
> ?*/
>
> -static void nuc93x_irq_ack(unsigned int irq)
> +static void nuc93x_irq_ack(struct irq_data *d)
> ?{
> ? ? ? ?__raw_writel(0x01, REG_AIC_EOSCR);
> ?}
>
> -static void nuc93x_irq_unmask(unsigned int irq)
> +static void nuc93x_irq_unmask(struct irq_data *d)
> ?{
> - ? ? ? __raw_writel(1 << irq, REG_AIC_MECR);
> + ? ? ? __raw_writel(1 << d->irq, REG_AIC_MECR);
>
> ?}
>
> ?static struct irq_chip nuc93x_irq_chip = {
> - ? ? ? .ack ? ? ? = nuc93x_irq_ack,
> - ? ? ? .mask ? ? ?= nuc93x_irq_mask,
> - ? ? ? .unmask ? ?= nuc93x_irq_unmask,
> + ? ? ? .irq_ack ? ? ? ?= nuc93x_irq_ack,
> + ? ? ? .irq_mask ? ? ? = nuc93x_irq_mask,
> + ? ? ? .irq_unmask ? ? = nuc93x_irq_unmask,
> ?};
>
> ?void __init nuc93x_init_irq(void)
> --
> 1.7.1
>
>

Acked-by: Wan ZongShun <mcuos.com@gmail.com>

Thanks for your patch.

-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com
