From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 21 Sep 2011 15:47:05 +0200
Subject: [PATCH 7/8] ARM: integrate CMA with DMA-mapping subsystem
In-Reply-To: <CAMjpGUch=ogFQwBLqOukKVnyh60600jw5tMq-KYeNGSZ2PLQpA@mail.gmail.com>
References: <1313764064-9747-1-git-send-email-m.szyprowski@samsung.com>
	<1313764064-9747-8-git-send-email-m.szyprowski@samsung.com>
	<CAMjpGUch=ogFQwBLqOukKVnyh60600jw5tMq-KYeNGSZ2PLQpA@mail.gmail.com>
Message-ID: <001a01cc7864$f2c98ea0$d85cabe0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, September 08, 2011 7:27 PM Mike Frysinger wrote:

> On Fri, Aug 19, 2011 at 10:27, Marek Szyprowski wrote:
> >  arch/arm/include/asm/device.h         |    3 +
> >  arch/arm/include/asm/dma-contiguous.h |   33 +++
> 
> seems like these would be good asm-generic/ additions rather than arm

Only some of them can be really moved to asm-generic imho. The following
lines are definitely architecture specific:

void dma_contiguous_early_fixup(phys_addr_t base, unsigned long size);

Some other archs might define empty fixup function. Right now only ARM 
architecture is the real client of the CMA. IMHO if any other arch stats
using CMA, some of the CMA definitions can be then moved to asm-generic.
Right now I wanted to keep it as simple as possible.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
