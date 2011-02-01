From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 1 Feb 2011 15:15:15 +0100
Subject: [PATCH] ARM: add PrimeCell generic DMA to MMCI/PL180
In-Reply-To: <20110201133036.GI31216@n2100.arm.linux.org.uk>
References: <20101219195959.GA28157@n2100.arm.linux.org.uk>
	<20101221135421.GS28157@n2100.arm.linux.org.uk>
	<20101221155935.GV28157@n2100.arm.linux.org.uk>
	<AANLkTin2fBLsq2YJHjZ=e+gmwWXWezH0t38bzsjiJ+i=@mail.gmail.com>
	<20110124160127.GA24104@n2100.arm.linux.org.uk>
	<AANLkTi=GmYoDYhKGpvzt2vHWSEb2b72cQbQfVc4PANdH@mail.gmail.com>
	<20110124212228.GN24104@n2100.arm.linux.org.uk>
	<AANLkTimReBj7QGw08imBV2JWJGwh-TO5oA+3kiFQZLq4@mail.gmail.com>
	<20110125102351.GA11507@n2100.arm.linux.org.uk>
	<AANLkTikLABG5yWDYcOe12mfy_Hco15k_ByqYX15GH9Cy@mail.gmail.com>
	<20110201133036.GI31216@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=TB+5aw-Yo3-8es3PLFSY=cf1RU7ws=zwv2Gj5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/2/1 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> So, the solutions as I see it are:
>
> 1. If DMAREQCTL = 1, move the burst limiting work-around into the DMA
> ? engine driver, if it really is a problem.
>
> 2. Set DMAREQCTL = 0.
>
> (2) seems to be the most sane solution to me.

Let's go with that as indicated in other mail.

However the DMAREQCTL is an odd beast and I just cannot
wrap my head around it. It certainly isn't there to solve any
software problems, so I need to find some usecase for it.

Generating SDIO traffic with odd bytechunks isn't that easy
though.

Linus Walleij
