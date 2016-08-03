From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 3 Aug 2016 10:27:36 -0700
Subject: Support for configurable PCIe endpoint
In-Reply-To: <2460140.yVuTYYqBTX@wuerfel>
References: <57A18927.9070003@ti.com> <20160803094747.GA10170@infradead.org>
 <2460140.yVuTYYqBTX@wuerfel>
Message-ID: <20160803172736.GA12989@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 03, 2016 at 06:03:54PM +0200, Arnd Bergmann wrote:
> drivers/ntb seems like a reasonable start, while an alternative
> approach that we have discussed in the past would be based on top
> of virtio, so we could use the existing front-end drivers (net, block,
> v9fs, console, ...).

I don't really think either is a good aproach for the lowest level
interface.  To be useful the EP driver needs to be able to implement
any (reasonable) thing a PCIe device could do.  Both NTB and virtio
can sit on top of that, though.
