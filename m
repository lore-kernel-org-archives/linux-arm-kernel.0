From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 7 May 2012 15:15:52 +0100
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <201205071319.48768.arnd@arndb.de>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205071121.53302.arnd@arndb.de>
 <20120507112956.GJ4415@opensource.wolfsonmicro.com>
 <201205071319.48768.arnd@arndb.de>
Message-ID: <20120507141551.GE17002@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2012 at 01:19:48PM +0000, Arnd Bergmann wrote:
> On Monday 07 May 2012, Mark Brown wrote:

> > You'd never expect any collisions to need arbitrating, it's purely about
> > telling the function driver where to find the IP without having to open
> > code this.  Anything which is actually shared would be handled in the
> > MFD core for the device normally, or with some other API like genirq.

> The patch that we are discussing adds a call to 'request_region' --
> that is the arbitration interface and that is what is causing the
> conflicts.

Oh dear - that's clearly broken, I'd not actually read the original
patch just the thread that followed.

> Using a 'struct resource' of type IORESOURCE_IO to pass information
> about non-PIO registers to child devices is inconsistent, ugly and
> confusing, but I agree it doesn't actually result in bugs. The problems

I actually don't find it at all confusing, but I think that's mostly
because at a high level I look at _IO as being about a register space
and this is just a different register space.

> start when you use those resources in combination with request_region,
> request_resource and ioport_map.

Right, yes - that's clearly never going to work.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120507/840207e1/attachment-0001.sig>
