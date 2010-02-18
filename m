From: jassisinghbrar@gmail.com (jassi brar)
Date: Thu, 18 Feb 2010 10:14:47 +0900
Subject: PL-330 DMA driver
In-Reply-To: <63386a3d1002171353v36f7b5c8tdab15b1593581e02@mail.gmail.com>
References: <1b68c6791002162150wb8fbae8ya1e5b3c0a56b7fad@mail.gmail.com>
	<63386a3d1002171026h51f34d4buc9ba0293ea08c004@mail.gmail.com>
	<20100217203114.GC30033@n2100.arm.linux.org.uk>
	<Pine.LNX.4.64.1002172220080.4623@axis700.grange>
	<63386a3d1002171353v36f7b5c8tdab15b1593581e02@mail.gmail.com>
Message-ID: <1b68c6791002171714u59a7d0fak7cd531de96eb0025@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2010 at 6:53 AM, Linus Walleij
<linus.ml.walleij@gmail.com> wrote:
> 2010/2/17 Guennadi Liakhovetski <g.liakhovetski@gmx.de>:
>
>> Of course, there's also a problem of reusing peripheral drivers with
>> different DMA controllers...
>
> That's what I'm facing with MMCI and a host of other peripherals.
>
> We have to either:
>
> (1) Use something, i.e the DMA engine slave
>
> (2) Fork the driver entirely to some ste-mmci.c and delete all generic
> ?code. (Repeat for each vendor using a primecell!)
>
> (3) Sprinkle mmci.c with #ifdef ARCH_U300 for our DMA engine.
> ?Or, not so bad, atleast sprinkle the smallish part I have now
> ?broken out in mmci.c that deals with DMA transfers.
>
> I think the current patch does (1) and it actually works, then if
> it gets burdensome to others, using a generic DMA engine can
> be a special case of (3) since that works for us so we're on the right
> path in two cases and (2) doesn't look good to me.
>
> Yours,
> Linus Walleij

CCing the S3C maintainer (Ben Dooks)  to share his opinion.
