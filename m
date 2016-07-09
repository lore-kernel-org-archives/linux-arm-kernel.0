From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 09 Jul 2016 22:17:06 +0200
Subject: [PATCH 4/6] irqchip: add irqchip driver for nuc900
In-Reply-To: <57806E9F.3020407@iommu.org>
References: <1466851042-22239-1-git-send-email-vw@iommu.org>
 <8706947.5rzUDVsB2F@wuerfel> <57806E9F.3020407@iommu.org>
Message-ID: <7701071.Nr6sCmDkjL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, July 9, 2016 11:25:19 AM CEST Wan Zongshun wrote:
> On 2016?06?29? 23:27, Arnd Bergmann wrote:
> > On Saturday, June 25, 2016 6:37:20 PM CEST Wan Zongshun wrote:
> >> +#define IRQ_WDT             W90X900_IRQ(1)
> >> +#define IRQ_WWDT    W90X900_IRQ(2)
> >> +#define IRQ_LVD             W90X900_IRQ(3)
> >> +#define IRQ_EXT0    W90X900_IRQ(4)
> >> +#define IRQ_EXT1    W90X900_IRQ(5)
> >> +#define IRQ_EXT2    W90X900_IRQ(6)
> >> +#define IRQ_EXT3    W90X900_IRQ(7)
> >> +#define IRQ_EXT4    W90X900_IRQ(8)
> >> +#define IRQ_EXT5    W90X900_IRQ(9)
> >> +#define IRQ_EXT6    W90X900_IRQ(10)
> >
> > I'd suggest dropping the list, the contents are now in the dts.
> 
> Arnd, I will drop this file later, since old w90x900 plat still need it.

Sure.

> but I will remove the Macros related to nuc970 and avoid nuc970 
> interrupt using those Macro.
> 
> But I still need hack this irqs.h like below, since here NR_IRQS defined 
> and it is need for nuc970 irqchip driver.
> 
> #if !defined(CONFIG_SOC_NUC900)
> #define NR_IRQS         (IRQ_ADC+1)
> #else
> #define NR_IRQS         62
> #endif

Have you considered using CONFIG_SPARSE_IRQ? That would avoid the need
for setting NR_IRQS entirely, but may also require more work elsewhere.

	Arnd
