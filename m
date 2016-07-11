From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Jul 2016 17:46:34 +0200
Subject: [PATCH v2 02/10] irqchip: add irqchip driver for nuc900
In-Reply-To: <1468135649-19980-3-git-send-email-vw@iommu.org>
References: <1468135649-19980-1-git-send-email-vw@iommu.org>
 <1468135649-19980-3-git-send-email-vw@iommu.org>
Message-ID: <1761342.TGgYi16yul@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, July 10, 2016 3:27:22 PM CEST Wan Zongshun wrote:
> +
> +#if !defined(CONFIG_SOC_NUC900)
>  #define NR_IRQS                (IRQ_ADC+1)
> +#else
> +#define NR_IRQS                62
> +#endif
>  

The Kconfig symbols are a bit confusing here: CONFIG_SOC_NUC900
controls the compilation of the soc_device driver, but I guess
what you actually mean here is CONFIG_SOC_NUC970, which is the
support for the actual chip.

Maybe rename the former to something less confusing and change
this to CONFIG_SOC_NUC970?

Ideally, this should just go away once we use SPARSE_IRQ.

	Arnd
