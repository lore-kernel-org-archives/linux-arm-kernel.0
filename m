From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 26 Apr 2010 05:56:27 +0100
Subject: [PATCH 1/7] PL330: Add common core driver
In-Reply-To: <q2y63386a3d1004241859v8b31f756rb6ff9b4a7452ba@mail.gmail.com>
References: <1271834848-29179-1-git-send-email-jassisinghbrar@gmail.com>
	<j2x63386a3d1004231449ta90046b5pc29622b58a87b99a@mail.gmail.com>
	<n2y1b68c6791004231620lcd670271u3a9d33bb52c10e37@mail.gmail.com>
	<q2y63386a3d1004241859v8b31f756rb6ff9b4a7452ba@mail.gmail.com>
Message-ID: <20100426045627.GI28105@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 25, 2010 at 03:59:26AM +0200, Linus Walleij wrote:
> 2010/4/24 jassi brar <jassisinghbrar@gmail.com>:
> 
> > You mean the DMA engine driver for PL330, right?
> > Since Joonyoung's driver was pre-empted by these patches,
> > he might want to re-write parts of his driver for this backend.
> > If he doesn't show any interest in a few days, I'll do it.
> 
> Great, my interest here is mainly that this PrimeCell has
> a DMAengine API, if it e.g. runs the DMAengine tests
> nicely, we know it works.

I'd like to make a decision once and for-all about whether to go with
DMAengine or try7 and design something that SoC types can agree on.
 
> > Btw, I think that driver should be divided in two files
> > drivers/dma/api-pl330.c with common code and
> > drivers/dma/<soc>-pl330.c for platform specific stuff like IRQ,
> > registers base mapping and other quirks(if any). Any opinions?

Possibly, but I think it may be better to pass these things via platform
device for registers and irqs, and platform data for the quirks.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
