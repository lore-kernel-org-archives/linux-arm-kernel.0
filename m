Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12D0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:54:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F1BA2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vCbx6CsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1BA2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/XRyDK63V/z+v7UUIBa5Nz/5Ut+WqLNitCgxPtdQVQo=; b=vCbx6CsSxVAJl2
	f/Pwcz2/JKIXApASvgdF24D5kNs2Dpc8CGDL5s7lrZAZ7sBdSVDjYcfp3iDgOKUdrZLcdfhJb3nqF
	zmKW3rbAzb8Y7DVze3DrynXYO4O3bJix1Bb3PSXy1R9DrW+XYD5RIpKyTLozlJY9wQXuPdoOK7kpi
	yvgTZunMPf3L/jT6PvkAs8pcVx5wzsZPGK3o85gRY60Ol6EGzFqzT/+wRYCiihnv+oC1lRt2AJo9t
	HS4wMzWPOymQ0DsuBjE7LGkwOUu7g1OAu5W8DHyZ508953HJbQNrdf8Wku2q+WSxCLa6QFtCXfSm1
	pI1YernR/4diQSK1Xzkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx7Wn-0000eS-64; Fri, 22 Feb 2019 09:53:57 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx7Wj-0000e8-QV
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 09:53:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A02EE80D;
 Fri, 22 Feb 2019 01:53:53 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5909C3F703;
 Fri, 22 Feb 2019 01:53:52 -0800 (PST)
Date: Fri, 22 Feb 2019 09:53:48 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 10/30 v2] irqchip: ixp4xx: Add OF initialization support
Message-ID: <20190222095348.44a09be7@why.wild-wind.fr.eu.org>
In-Reply-To: <20190221154458.23763-11-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
 <20190221154458.23763-11-linus.walleij@linaro.org>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_015353_861328_41AFD6EB 
X-CRM114-Status: GOOD (  19.73  )
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
Cc: Thomas Gleixner <tglx@linutronix.de>, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>, Jason Cooper <jason@lakedaemon.net>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 21 Feb 2019 16:44:38 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> This adds support for probing and settin up the IXP4xx
> irqchip from device tree.
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
>  drivers/irqchip/irq-ixp4xx.c | 45 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-ixp4xx.c b/drivers/irqchip/irq-ixp4xx.c
> index 89c80ce047a7..1ea7561fddb7 100644
> --- a/drivers/irqchip/irq-ixp4xx.c
> +++ b/drivers/irqchip/irq-ixp4xx.c
> @@ -15,6 +15,9 @@
>  #include <linux/irqchip.h>
>  #include <linux/irqchip/irq-ixp4xx.h>
>  #include <linux/irqdomain.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/cpu.h>
>  
> @@ -360,3 +363,45 @@ void __init ixp4xx_irq_init(resource_size_t irqbase,
>  	}
>  }
>  EXPORT_SYMBOL_GPL(ixp4xx_irq_init);
> +
> +#ifdef CONFIG_OF
> +int __init ixp4xx_of_init_irq(struct device_node *np,
> +			      struct device_node *parent)
> +{
> +	struct ixp4xx_irq *ixi = &ixirq;
> +	void __iomem *base;
> +	struct fwnode_handle *fwnode;
> +	bool is_356;
> +	int ret;
> +
> +	base = of_iomap(np, 0);
> +	if (!base) {
> +		pr_crit("IXP4XX: could not ioremap interrupt controller\n");
> +		return -ENODEV;
> +	}
> +	fwnode = of_node_to_fwnode(np);
> +	if (!fwnode) {
> +		pr_crit("IXP4XX: no domain handle\n");
> +		return -ENODEV;
> +	}

For this to happen, np would have to be NULL. I don't think that's
possible at all, as you managed to get here. So I think you can safely
drop this check.

> +
> +	/* These chip variants have 64 interrupts */
> +	is_356 = of_device_is_compatible(np, "intel,ixp43x-interrupt") ||
> +		of_device_is_compatible(np, "intel,ixp45x-interrupt") ||
> +		of_device_is_compatible(np, "intel,ixp46x-interrupt");
> +
> +	ret = ixp4xx_irq_setup(ixi, base, fwnode, is_356);
> +	if (ret)
> +		pr_crit("IXP4XX: failed to set up irqchip\n");
> +
> +	return ret;
> +}
> +IRQCHIP_DECLARE(ixp42x, "intel,ixp42x-interrupt",
> +		ixp4xx_of_init_irq);
> +IRQCHIP_DECLARE(ixp43x, "intel,ixp43x-interrupt",
> +		ixp4xx_of_init_irq);
> +IRQCHIP_DECLARE(ixp45x, "intel,ixp45x-interrupt",
> +		ixp4xx_of_init_irq);
> +IRQCHIP_DECLARE(ixp46x, "intel,ixp46x-interrupt",
> +		ixp4xx_of_init_irq);
> +#endif


With the above fixed:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Without deviation from the norm, progress is not possible.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
