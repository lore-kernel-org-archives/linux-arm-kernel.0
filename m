From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 May 2012 12:30:11 +0000
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <CAJe_Zhf0=Qnsgsc7U_GbKxc0_6DKj33QWs0UW2giyrVEjPnrvw@mail.gmail.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <4FA94B49.5050500@wwwdotorg.org>
 <CAJe_Zhf0=Qnsgsc7U_GbKxc0_6DKj33QWs0UW2giyrVEjPnrvw@mail.gmail.com>
Message-ID: <201205091230.11474.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 May 2012, Jassi Brar wrote:
> On 8 May 2012 22:05, Stephen Warren <swarren@wwwdotorg.org> wrote:
> >
> > The data doesn't need to be part of the DMA controller node in order for
> > the DMA controller driver to be the entity interpreting it.
> >
> I rather say, if the dma controller driver is the entity going to interpret the
> data, why not provide the data directly through its node at one go?
> 
> There is important difference between providing data via clients
> during runtime vs providing info about every client to the dmac driver
> at one go during its probe.

IMHO the important aspect is what that data contains. The dma engine
device node should only describe what that device looks like in hardware,
but not how it is being used.  If you have two machines that have the
same dma engine, but different devices attached to it, the only
difference in the device tree ought to be in those devices, not in the
parts that are common.
> >> That encoding("channel_id") would be dma
> >> controller specific and if we also manage to contain it within fixed number
> >> of bytes we could also have common helpers for fetching it,
> >
> > I don't think there's any need for it to fit into a fixed number of  bytes
> >
> Yeah, I realized that soon after posting.
> 
> I think I have run out of ways to explain myself better. FWIW, I won't
> object to whatever mechanism folks decide after knowing my concerns.

I think we should try hard to make it possible to describe your hardware
correctly, but we don't need to optimize the syntax for that case if that
means making the common case more complex. I'd rather make the common
case simple and the exception possible using some extension.

	Arnd
