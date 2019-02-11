Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D096C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:30:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD70222A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F1o3uVtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD70222A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h6E/jK4Gabz9sibpVj9ZlpaJJciuUvro2mv307hJ6lM=; b=F1o3uVtgJ0Cd6g
	8PLTW+vMe3mMiR/jk2m/TlYgo8CInERlOQL3WvFPdPTN3DZJ+NzKe0oSFd1ndwVRi8lrRoJp33v7M
	AO+Uds+r8XvxKmkpBzhINUCKQuslghvGh0FXA0RNf/n7/85jn1Hq+COVaTSQADVukIqHQKhYJ8Sto
	LUKAL/6ZA7dVCvzwYT+glA3LTwvFGS9b30vkUXcg8TEzpwLSd5lCN0B/JP5Nu4Tv+tnueGDjO9mIh
	/JA0GwnaIJAXECNeb7z/IJNcMHyxi+GJXMNuIsRMw403IEbEJD+WNl9jHiQRltIV2Q4EiVjEJEzCJ
	LRW7f9l8lAzAydyvo2ug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtDXp-0000hu-MI; Mon, 11 Feb 2019 15:30:53 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtDXk-0000gn-LS
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 15:30:52 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1DC3EBD;
 Mon, 11 Feb 2019 07:30:46 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 125F23F589; Mon, 11 Feb 2019 07:30:44 -0800 (PST)
Subject: Re: [PATCH 04/17 v1] irqchip: Add driver for IXP4xx
To: Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
References: <20190203214205.13594-1-linus.walleij@linaro.org>
 <20190203214205.13594-5-linus.walleij@linaro.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <ffc97649-bfc2-e411-149f-cd5ed9e8c77e@arm.com>
Date: Mon, 11 Feb 2019 15:30:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190203214205.13594-5-linus.walleij@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_073048_728502_A19813D3 
X-CRM114-Status: GOOD (  40.77  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Olof Johansson <olof@lixom.net>, Tim Harvey <tharvey@gateworks.com>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Linus,

On 03/02/2019 21:41, Linus Walleij wrote:
> The IXP4xx (arch/arm/mach-ixp4xx) is an old Intel XScale
> platform that has very wide deployment and use.
> 
> As part of modernizing the platform, we need to implement a
> proper irqchip in the irqchip subsystem.
> 
> The IXP4xx irqchip is tightly jotted together with the GPIO
> controller, and wheras in the past we would deal with this

nit: whereas

> complex logic by adding necessarily different code, we can
> nowadays modernize it using a hierarchical irqchip.
> 
> The actual IXP4 irqchip is a simple active low level IRQ
> controller, whereas the GPIO functionality resides in a
> different memory area and adds edge trigger support for
> the interrupts.
> 
> The interrupts from GPIO lines 0..12 are 1:1 mapped to
> a fixed set of hardware IRQs on this IRQchip, so we
> expect the child GPIO interrupt controller to go in and
> allocate descriptors for these interrupts.
> 
> For the other interrupts, as we do not yet have DT
> support for this platform, we create a linear irqdomain
> and then go in and allocate the IRQs that the legacy
> boards use. This code will be removed on the DT probe
> path when we add DT support to the platform.
> 
> We add some translation code for supporting DT
> translations for the fwnodes, but we leave most of that
> for later.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> irqchip maintainers: I am requesting an ACK for this once
> you're happy with the driver, as I intend to merge all of
> this IXP4xx rework through ARM SoC.
> ---
>  MAINTAINERS                        |   2 +
>  drivers/irqchip/Kconfig            |   6 +
>  drivers/irqchip/Makefile           |   1 +
>  drivers/irqchip/irq-ixp4xx.c       | 360 +++++++++++++++++++++++++++++
>  include/linux/irqchip/irq-ixp4xx.h |  12 +
>  5 files changed, 381 insertions(+)
>  create mode 100644 drivers/irqchip/irq-ixp4xx.c
>  create mode 100644 include/linux/irqchip/irq-ixp4xx.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 32d444476a90..0d48faa3e635 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1651,6 +1651,8 @@ M:	Krzysztof Halasa <khalasa@piap.pl>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	arch/arm/mach-ixp4xx/
> +F:	drivers/irqchip/irq-ixp4xx.c
> +F:	include/linux/irqchip/irq-ixp4xx.h
>  
>  ARM/INTEL RESEARCH IMOTE/STARGATE 2 MACHINE SUPPORT
>  M:	Jonathan Cameron <jic23@cam.ac.uk>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 3d1e60779078..c7e09913826b 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -150,6 +150,12 @@ config IMGPDC_IRQ
>  	select GENERIC_IRQ_CHIP
>  	select IRQ_DOMAIN
>  
> +config IXP4XX_IRQ
> +	bool
> +	select IRQ_DOMAIN
> +	select GENERIC_IRQ_MULTI_HANDLER
> +	select SPARSE_IRQ
> +
>  config MADERA_IRQ
>  	tristate
>  
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index c93713d24b86..06139d612108 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_ATMEL_AIC5_IRQ)	+= irq-atmel-aic-common.o irq-atmel-aic5.o
>  obj-$(CONFIG_I8259)			+= irq-i8259.o
>  obj-$(CONFIG_IMGPDC_IRQ)		+= irq-imgpdc.o
>  obj-$(CONFIG_IRQ_MIPS_CPU)		+= irq-mips-cpu.o
> +obj-$(CONFIG_IXP4XX_IRQ)		+= irq-ixp4xx.o
>  obj-$(CONFIG_SIRF_IRQ)			+= irq-sirfsoc.o
>  obj-$(CONFIG_JCORE_AIC)			+= irq-jcore-aic.o
>  obj-$(CONFIG_RDA_INTC)			+= irq-rda-intc.o
> diff --git a/drivers/irqchip/irq-ixp4xx.c b/drivers/irqchip/irq-ixp4xx.c
> new file mode 100644
> index 000000000000..7deaf0f82a53
> --- /dev/null
> +++ b/drivers/irqchip/irq-ixp4xx.c
> @@ -0,0 +1,360 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * irqchip for the IXP4xx interrupt controller
> + * Copyright (C) 2019 Linus Walleij <linus.walleij@linaro.org>
> + *
> + * Based on arch/arm/mach-ixp4xx/common.c
> + * Copyright 2002 (C) Intel Corporation
> + * Copyright 2003-2004 (C) MontaVista, Software, Inc.
> + * Copyright (C) Deepak Saxena <dsaxena@plexity.net>
> + */
> +#include <linux/bitops.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/irq.h>
> +#include <linux/io.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/irq-ixp4xx.h>
> +#include <linux/irqdomain.h>
> +#include <linux/platform_device.h>
> +#include <linux/cpu.h>
> +
> +#include <asm/exception.h>
> +#include <asm/mach/irq.h>
> +
> +#define IXP4XX_ICPR	0x00 /* Interrupt Status */
> +#define IXP4XX_ICMR	0x04 /* Interrupt Enable */
> +#define IXP4XX_ICLR	0x08 /* Interrupt IRQ/FIQ Select */
> +#define IXP4XX_ICIP	0x0C /* IRQ Status */
> +#define IXP4XX_ICFP	0x10 /* FIQ Status */
> +#define IXP4XX_ICHR	0x14 /* Interrupt Priority */
> +#define IXP4XX_ICIH	0x18 /* IRQ Highest Pri Int */
> +#define IXP4XX_ICFH	0x1C /* FIQ Highest Pri Int */
> +
> +/* IXP43x and IXP46x-only */
> +#define	IXP4XX_ICPR2	0x20 /* Interrupt Status 2 */
> +#define	IXP4XX_ICMR2	0x24 /* Interrupt Enable 2 */
> +#define	IXP4XX_ICLR2	0x28 /* Interrupt IRQ/FIQ Select 2 */
> +#define IXP4XX_ICIP2	0x2C /* IRQ Status */
> +#define IXP4XX_ICFP2	0x30 /* FIQ Status */
> +#define IXP4XX_ICEEN	0x34 /* Error High Pri Enable */
> +
> +/**
> + * struct ixp4xx_irq - state container for the Faraday IRQ controller
> + * @irqbase: IRQ controller memory base in virtual memory
> + * @is_356: if this is an IXP43x, IXP45x or IX46x SoC (with 64 IRQs)
> + * @irqchip: irqchip for this instance
> + * @domain: IRQ domain for this instance
> + */
> +struct ixp4xx_irq {
> +	void __iomem *irqbase;
> +	bool is_356;
> +	struct irq_chip irqchip;
> +	struct irq_domain *domain;
> +};
> +
> +/* Local static state container */
> +static struct ixp4xx_irq ixirq;
> +
> +/* GPIO Clocks */
> +#define IXP4XX_GPIO_CLK_0		14
> +#define IXP4XX_GPIO_CLK_1		15
> +
> +static int ixp4xx_set_irq_type(struct irq_data *d, unsigned int type)
> +{
> +	/* All are level active high (asserted) here */

It'd be good to return an error if type isn't LEVEL_HIGH.

> +	return 0;
> +}
> +
> +static void ixp4xx_irq_mask(struct irq_data *d)
> +{
> +	struct ixp4xx_irq *ixi = irq_data_get_irq_chip_data(d);
> +	u32 val;
> +
> +	if (ixi->is_356 && d->hwirq >= 32) {
> +		val = __raw_readl(ixi->irqbase + IXP4XX_ICMR2);
> +		val &= ~BIT(d->hwirq - 32);
> +		__raw_writel(val, ixi->irqbase + IXP4XX_ICMR2);
> +	} else {
> +		val = __raw_readl(ixi->irqbase + IXP4XX_ICMR);
> +		val &= ~BIT(d->hwirq);
> +		__raw_writel(val, ixi->irqbase + IXP4XX_ICMR);
> +	}
> +}

This probably comes from the original code, but I'd like to be able to
use a LE kernel on this HW (full disclosure: I have some of this crap
stashed somewhere in the basement... ;-).

How about using something that enforces the endianness of the accesses,
as I suspect the bus is hardcoded to BE? ioread32be/iowrite32be springs
to mind, and I can see the current IXP4xx code provides such an
implementation in its own io.h (which you may have to make private).

> +
> +/*
> + * Level triggered interrupts on GPIO lines can only be cleared when the
> + * interrupt condition disappears.
> + */
> +static void ixp4xx_irq_unmask(struct irq_data *d)
> +{
> +	struct ixp4xx_irq *ixi = irq_data_get_irq_chip_data(d);
> +	u32 val;
> +
> +	if (ixi->is_356 && d->hwirq >= 32) {
> +		val = __raw_readl(ixi->irqbase + IXP4XX_ICMR2);
> +		val |= BIT(d->hwirq - 32);
> +		__raw_writel(val, ixi->irqbase + IXP4XX_ICMR2);
> +	} else {
> +		val = __raw_readl(ixi->irqbase + IXP4XX_ICMR);
> +		val |= BIT(d->hwirq);
> +		__raw_writel(val, ixi->irqbase + IXP4XX_ICMR);
> +	}
> +}

Same here, as well as all the other places sporting a __raw_ accessor.

> +
> +asmlinkage void __exception_irq_entry ixp4xx_handle_irq(struct pt_regs *regs)
> +{
> +	struct ixp4xx_irq *ixi = &ixirq;
> +	unsigned long status;
> +	int i;
> +
> +	status = __raw_readl(ixi->irqbase + IXP4XX_ICIP);
> +	for_each_set_bit(i, &status, 32)
> +		handle_domain_irq(ixi->domain, i, regs);
> +
> +	/*
> +	 * IXP465/IXP435 has an upper IRQ status register
> +	 */
> +	if (ixi->is_356) {
> +		status = __raw_readl(ixi->irqbase + IXP4XX_ICIP2);
> +		for_each_set_bit(i, &status, 32)
> +			handle_domain_irq(ixi->domain, i + 32, regs);
> +	}
> +}
> +
> +static int ixp4xx_irq_domain_translate(struct irq_domain *domain,
> +				       struct irq_fwspec *fwspec,
> +				       unsigned long *hwirq,
> +				       unsigned int *type)
> +{
> +	/* We support standard DT translation */
> +	if (is_of_node(fwspec->fwnode) && fwspec->param_count == 2) {
> +		*hwirq = fwspec->param[0];
> +		*type = fwspec->param[1];
> +		return 0;
> +	}
> +
> +	if (is_fwnode_irqchip(fwspec->fwnode)) {
> +		if (fwspec->param_count != 2)
> +			return -EINVAL;
> +		*hwirq = fwspec->param[0];
> +		*type = fwspec->param[1];
> +		WARN_ON(*type == IRQ_TYPE_NONE);
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ixp4xx_irq_domain_alloc(struct irq_domain *d,
> +				   unsigned int irq, unsigned int nr_irqs,
> +				   void *data)
> +{
> +	struct ixp4xx_irq *ixi = d->host_data;
> +	irq_hw_number_t hwirq;
> +	unsigned int type = IRQ_TYPE_NONE;
> +	struct irq_fwspec *fwspec = data;
> +	int ret;
> +	int i;
> +
> +	ret = ixp4xx_irq_domain_translate(d, fwspec, &hwirq, &type);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		/*
> +		 * TODO: after converting IXP4xx to only device tree, set
> +		 * handle_bad_irq as default handler and assume all consumers
> +		 * call .set_type() as this is provided in the second cell in
> +		 * the device tree phandle.
> +		 */
> +		irq_domain_set_info(d,
> +				    irq + i,
> +				    hwirq + i,
> +				    &ixi->irqchip,
> +				    ixi,
> +				    handle_level_irq,
> +				    NULL, NULL);
> +		irq_set_probe(irq + i);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * This needs to be a hierarchical irqdomain to work well with the
> + * GPIO irqchip (which is lower in the hierarchy)
> + */
> +static const struct irq_domain_ops ixp4xx_irqdomain_ops = {
> +	.translate = ixp4xx_irq_domain_translate,
> +	.alloc = ixp4xx_irq_domain_alloc,
> +	.free = irq_domain_free_irqs_common,
> +};
> +
> +/**
> + * ixp4xx_get_irq_domain() - retrieve the ixp4xx irq domain
> + *
> + * This function will go away when we transition to DT probing.
> + */
> +struct irq_domain *ixp4xx_get_irq_domain(void)
> +{
> +	struct ixp4xx_irq *ixi = &ixirq;
> +
> +	return ixi->domain;
> +}
> +EXPORT_SYMBOL_GPL(ixp4xx_get_irq_domain);
> +
> +/*
> + * This is the Linux IRQ to hwirq mapping table. This goes away when
> + * we have DT support as all IRQ resources are defined in the device
> + * tree. It will register all the IRQs that are not used by the hierarchical
> + * GPIO IRQ chip. The "holes" inbetween these IRQs will be requested by
> + * the GPIO driver using . This is a step-gap solution.
> + */
> +struct ixp4xx_irq_chunk {
> +	int irq;
> +	int hwirq;
> +	int nr_irqs;
> +};
> +
> +static const struct ixp4xx_irq_chunk ixp4xx_irq_chunks[] = {
> +	{
> +		.irq = 16,
> +		.hwirq = 0,
> +		.nr_irqs = 6,
> +	},
> +	{
> +		.irq = 24,
> +		.hwirq = 8,
> +		.nr_irqs = 11,
> +	},
> +	{
> +		.irq = 46,
> +		.hwirq = 30,
> +		.nr_irqs = 2,
> +	},
> +	/* Only on the 436 variants */
> +	{
> +		.irq = 48,
> +		.hwirq = 32,
> +		.nr_irqs = 10,
> +	},
> +};
> +
> +/**
> + * ixp4x_irq_setup() - Common setup code for the IXP4xx interrupt controller
> + * @ixi: State container
> + * @irqbase: Virtual memory base for the interrupt controller
> + * @fwnode: Corresponding fwnode abstraction for this controller
> + * @is_356: if this is an IXP43x, IXP45x or IXP46x SoC variant
> + */
> +static int ixp4xx_irq_setup(struct ixp4xx_irq *ixi,
> +			    void __iomem *irqbase,
> +			    struct fwnode_handle *fwnode,
> +			    bool is_356)
> +{
> +	int nr_irqs;
> +
> +	ixi->irqbase = irqbase;
> +	ixi->is_356 = is_356;
> +
> +	/* Route all sources to IRQ instead of FIQ */
> +	__raw_writel(0x0, ixi->irqbase + IXP4XX_ICLR);
> +
> +	/* Disable all interrupts */
> +	__raw_writel(0x0, ixi->irqbase + IXP4XX_ICMR);
> +
> +	if (is_356) {
> +		/* Route upper 32 sources to IRQ instead of FIQ */
> +		__raw_writel(0x0, ixi->irqbase + IXP4XX_ICLR2);
> +
> +		/* Disable upper 32 interrupts */
> +		__raw_writel(0x0, ixi->irqbase + IXP4XX_ICMR2);
> +
> +		nr_irqs = 64;
> +	} else {
> +		nr_irqs = 32;
> +	}
> +
> +	ixi->irqchip.name = "IXP4xx";
> +	ixi->irqchip.irq_mask = ixp4xx_irq_mask;
> +	ixi->irqchip.irq_unmask	= ixp4xx_irq_unmask;
> +	ixi->irqchip.irq_set_type = ixp4xx_set_irq_type;

Aren't you guaranteed to only have one such irqchip? If so, this could
become a static const object, instead of allocating it dynamically. Not
a big deal though.

> +
> +	ixi->domain = irq_domain_create_linear(fwnode, nr_irqs,
> +					       &ixp4xx_irqdomain_ops,
> +					       ixi);
> +	if (!ixi->domain) {
> +		pr_crit("IXP4XX: can not add primary irqdomain\n");
> +		return -ENODEV;
> +	}
> +
> +	set_handle_irq(ixp4xx_handle_irq);
> +
> +	return 0;
> +}
> +
> +/**
> + * ixp4xx_irq_init() - Function to initialize the irqchip from boardfiles
> + * @irqbase: physical base for the irq controller
> + * @is_356: if this is an IXP43x, IXP45x or IXP46x SoC variant
> + */
> +void __init ixp4xx_irq_init(resource_size_t irqbase,
> +			    bool is_356)
> +{
> +	struct ixp4xx_irq *ixi = &ixirq;
> +	void __iomem *base;
> +	struct fwnode_handle *fwnode;
> +	struct irq_fwspec fwspec;
> +	int nr_chunks;
> +	int ret;
> +	int i;
> +
> +	base = ioremap(irqbase, 0x100);
> +	if (!base) {
> +		pr_crit("IXP4XX: could not ioremap interrupt controller\n");
> +		return;
> +	}
> +	fwnode = irq_domain_alloc_fwnode(base);

I assume this is a temporary solution until the SoC gains a DT port (and
the irqchip a DT node)?

> +	if (!fwnode) {
> +		pr_crit("IXP4XX: no domain handle\n");
> +		return;
> +	}
> +	ret = ixp4xx_irq_setup(ixi, base, fwnode, is_356);
> +	if (ret) {
> +		pr_crit("IXP4XX: failed to set up irqchip\n");
> +		irq_domain_free_fwnode(fwnode);
> +	}
> +
> +	nr_chunks = ARRAY_SIZE(ixp4xx_irq_chunks);
> +	if (!is_356)
> +		nr_chunks--;
> +
> +	/*
> +	 * After adding OF support, this is no longer needed: irqs
> +	 * will be allocated for the respective fwnodes.
> +	 */
> +	for (i = 0; i < nr_chunks; i++) {
> +		const struct ixp4xx_irq_chunk *chunk = &ixp4xx_irq_chunks[i];
> +
> +		pr_info("Allocate Linux IRQs %d..%d HW IRQs %d..%d\n",
> +			chunk->irq, chunk->irq + chunk->nr_irqs - 1,
> +			chunk->hwirq, chunk->hwirq + chunk->nr_irqs - 1);
> +		fwspec.fwnode = fwnode;
> +		fwspec.param[0] = chunk->hwirq;
> +		fwspec.param[1] = IRQ_TYPE_LEVEL_HIGH;
> +		fwspec.param_count = 2;
> +		ret = __irq_domain_alloc_irqs(ixi->domain,
> +					      chunk->irq,
> +					      chunk->nr_irqs,
> +					      NUMA_NO_NODE,
> +					      &fwspec,
> +					      false,
> +					      NULL);
> +		if (ret < 0) {
> +			pr_crit("IXP4XX: can not allocate irqs in hierarchy %d\n",
> +				ret);
> +			return;
> +		}
> +	}
> +}
> +EXPORT_SYMBOL_GPL(ixp4xx_irq_init);
> diff --git a/include/linux/irqchip/irq-ixp4xx.h b/include/linux/irqchip/irq-ixp4xx.h
> new file mode 100644
> index 000000000000..9395917d6936
> --- /dev/null
> +++ b/include/linux/irqchip/irq-ixp4xx.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __IRQ_IXP4XX_H
> +#define __IRQ_IXP4XX_H
> +
> +#include <linux/ioport.h>
> +struct irq_domain;
> +
> +void ixp4xx_irq_init(resource_size_t irqbase,
> +		     bool is_356);
> +struct irq_domain *ixp4xx_get_irq_domain(void);
> +
> +#endif /* __IRQ_IXP4XX_H */
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
