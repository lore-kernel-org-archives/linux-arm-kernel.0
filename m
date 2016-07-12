From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Jul 2016 10:26:28 +0200
Subject: [PATCH v2 02/10] irqchip: add irqchip driver for nuc900
In-Reply-To: <5784968A.7080007@iommu.org>
References: <1468135649-19980-1-git-send-email-vw@iommu.org>
 <1761342.TGgYi16yul@wuerfel> <5784968A.7080007@iommu.org>
Message-ID: <5434334.4rKzx80y6W@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, July 12, 2016 3:04:42 PM CEST Wan Zongshun wrote:
> >
> > Ideally, this should just go away once we use SPARSE_IRQ.
> 
> This platform also can use SPARSE_IRQ? this just a simple irq map and no 
> more irq number in this Soc.
> 

SPARSE_IRQ is implied by ARCH_MULTIPLATFORM, so we will have to
use it once that gets enabled.

Your new irqchip driver already handles IRQ domains, so it will
work out of the box with SPARSE_IRQ, but you have to change the
reference to "NR_IRQS" into something else.

I've prototyped a patch series to enable ARCH_MULTIPLATFORM,
I hope you can start working from what I have and get it to run.

	Arnd
