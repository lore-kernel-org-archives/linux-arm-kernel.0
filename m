From: daniel@zonque.org (Daniel Mack)
Date: Mon, 16 Feb 2015 12:23:46 +0100
Subject: [PATCH RFC 2/2] ARM: pxa: transition to dmaengine phase 1
In-Reply-To: <CA+E=qVfP=JY5ccUyCat5Thtk6waVng-PsnL7Y4c7_Hj+s8==nw@mail.gmail.com>
References: <1423954053-21760-1-git-send-email-robert.jarzmik@free.fr>
 <1423954053-21760-3-git-send-email-robert.jarzmik@free.fr>
 <CA+E=qVfP=JY5ccUyCat5Thtk6waVng-PsnL7Y4c7_Hj+s8==nw@mail.gmail.com>
Message-ID: <54E1D342.7090005@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/16/2015 12:14 PM, Vasily Khoruzhick wrote:
> What about dropping old PXA DMA code completely? Daniel Mack did port
> for most of PXA drivers to dma engine,
> I've rebased his patches against 3.17 several months ago and fixed
> oopses in pxamci and asoc drivers, but I didn't resubmit whole series
> due to lack of time.

Yes, I did the same locally.

> My 3.17 tree is at [1], I've tested it on pxa270 machine (Zipit Z2),
> and everything works fine so far. I guess it won't be too much work to
> rebase it against linux-3.20.

Rebasing is easy, but there's more to that. We should at least try to
convert all drivers over to dmaengine, otherwise they will just stop
working.

The biggest problem that I currently see is the pxa camera driver, which
also uses an advanced way of descriptor hot-linking at runtime. Last
time I checked, this wasn't possible to achieve with the dma-slave API.
Hence, this driver might need to be completely rewritten, which only
someone with such hardware at hand can work on. Maybe the cyclic DMA
support in mmp-dma already suffices for that. Robert, weren't you
already working on that?


Thanks,
Daniel
