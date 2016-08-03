From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Aug 2016 21:38:23 +0200
Subject: Support for configurable PCIe endpoint
In-Reply-To: <20160803172736.GA12989@infradead.org>
References: <57A18927.9070003@ti.com> <2460140.yVuTYYqBTX@wuerfel>
 <20160803172736.GA12989@infradead.org>
Message-ID: <8897954.gERmznGCsN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 3, 2016 10:27:36 AM CEST Christoph Hellwig wrote:
> On Wed, Aug 03, 2016 at 06:03:54PM +0200, Arnd Bergmann wrote:
> > drivers/ntb seems like a reasonable start, while an alternative
> > approach that we have discussed in the past would be based on top
> > of virtio, so we could use the existing front-end drivers (net, block,
> > v9fs, console, ...).
> 
> I don't really think either is a good aproach for the lowest level
> interface.  To be useful the EP driver needs to be able to implement
> any (reasonable) thing a PCIe device could do.  Both NTB and virtio
> can sit on top of that, though.

Good point. NTB tries to be the low-level interface, but I guess
you are right that it really isn't (I have not looked in a long
time, maybe Jon can comment).

While virtio transport over PCI would be great as the way to
implement a lot of things on top of endpoint devices, it can't
be the lowest level in the stack (see drivers/remoteproc) and
building it on top of something that is useful for other things
sounds like a good idea.

	Arnd
