From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 May 2013 19:26:47 +0200
Subject: [PATCH v2 2/5] irqchip: mmp: support irqchip
In-Reply-To: <1369707707-30295-3-git-send-email-haojian.zhuang@gmail.com>
References: <1369707707-30295-1-git-send-email-haojian.zhuang@gmail.com>
 <1369707707-30295-3-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <201305281926.47790.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 May 2013, Haojian Zhuang wrote:
>         icu_data[0].domain = irq_domain_add_legacy(node, nr_irqs, 0, 0,
>                                                    &mmp_irq_domain_ops,
>                                                    &icu_data[0]);

Is there anything stopping you from converting to the linear domain now?

> +IRQCHIP_DECLARE(mmp_intc, "mrvl,mmp-intc", mmp_of_init);
> +IRQCHIP_DECLARE(mmp2_intc, "mrvl,mmp2-intc", mmp2_of_init);
> +IRQCHIP_DECLARE(mmp2_mux_intc, "mrvl,mmp2-mux-intc", mmp2_mux_of_init);

Please put each line directly after the function it refers to,
similar to how we do it for EXPORT_SYMBOL.

	Arnd
