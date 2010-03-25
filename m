From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 25 Mar 2010 16:20:55 +0100
Subject: [PATCH v2] PL330: Add PL330 DMA controller driver
In-Reply-To: <1b68c6791003250517y4e2789baoe147e5982c363682@mail.gmail.com>
References: <4BAAD5BB.7050101@samsung.com>
	<1b68c6791003242234h106d9530p12b5a046a906227e@mail.gmail.com>
	<63386a3d1003250130w6f34854ag2ca163799e9b7bed@mail.gmail.com>
	<1b68c6791003250517y4e2789baoe147e5982c363682@mail.gmail.com>
Message-ID: <63386a3d1003250820x3cf81000i9d27e95c755b9ca8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/3/25 jassi brar <jassisinghbrar@gmail.com>:

> My approach is to write a separate PL330 core driver as the backend which
> can be reused by any DMA API implementer driver. That will avoid
> having two copies of the PL330 driver, among other benefits.

Seems like a rather good approach.

> And if this patch is accepted, there
> _will_ exist two copies of the PL330 driver -- one in drivers/dma/pl330_dmac.c
> and another in arch/arm/plat-samsung/. Only the former will be lying unused
> until some other SoC vendor decided to use PL330, because S3C has come too
> long a way to change its drivers to driver/dma/ API and modify DMA
> drivers for every SoC.

What's wrong with merging them later then? Refactoring FTW.

> I have the pl330-core part almost ready, but i need time to implement
> some _testable_
> implementation of the scheme. If maintainers want to see structure of
> my code, I can
> share it too, but I think I pretty much made it clear.

Why not just post it on the list? I'm curious! Since I'm working on a PrimeCell
DMA API I would love to look at PrimeCell DMA engine drivers.

Yours,
Linus Walleij
