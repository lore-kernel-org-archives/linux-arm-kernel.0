From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 11 Apr 2012 14:07:48 +0200
Subject: [PATCHv8 05/10] ARM: dma-mapping: use
 asm-generic/dma-mapping-common.h
In-Reply-To: <201204101147.20733.arnd@arndb.de>
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
 <1334055852-19500-6-git-send-email-m.szyprowski@samsung.com>
 <201204101147.20733.arnd@arndb.de>
Message-ID: <012f01cd17db$b5f918d0$21eb4a70$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tuesday, April 10, 2012 1:47 PM Arnd Bergmann wrote:

> On Tuesday 10 April 2012, Marek Szyprowski wrote:
> > This patch modifies dma-mapping implementation on ARM architecture to
> > use common dma_map_ops structure and asm-generic/dma-mapping-common.h
> > helpers.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  arch/arm/Kconfig                   |    1 +
> >  arch/arm/include/asm/device.h      |    1 +
> >  arch/arm/include/asm/dma-mapping.h |  196 +++++-------------------------------
> >  arch/arm/mm/dma-mapping.c          |  148 ++++++++++++++++-----------
> >  4 files changed, 115 insertions(+), 231 deletions(-)
> 
> Looks good in principle. One question: Now that many of the functions are only
> used in the dma_map_ops, can you make them 'static' instead?

Some of these non static functions (mainly arm_dma_*_sg_* family) are also used by dma bounce
code introduced in the next patch, that's why I left them without static attribute.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
