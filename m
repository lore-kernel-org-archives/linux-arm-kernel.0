From: claude.youn@gmail.com (Seungwhan Youn)
Date: Tue, 5 Jul 2011 16:45:30 +0900
Subject: [PATCH 7/7] ASoC: Samsung: Update DMA interface
In-Reply-To: <20110704170259.GC28726@opensource.wolfsonmicro.com>
References: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
	<1309781915-31549-8-git-send-email-kgene.kim@samsung.com>
	<20110704170259.GC28726@opensource.wolfsonmicro.com>
Message-ID: <CA+s+8rf3oBFe7TcEnWqh1L51FuN59uU0F=RTgargOFGJN+f7XA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Two questions here:
>
> - It looks like a lot of this code can be shared between all the drivers
> ?using the dmaengine API. ?Is there any reason not to factor it out?
> - Should this not be adding a new driver for dmaengine based Samsung
> ?CPUs? ?The ifdefs are very big.

I think that dma code looks very similar to current one, so how about
using platform_resource setting for dma type and make some inline
functions to cover these differences? We already have platform driver
for dma in arch/arm and dev-audio.c.
