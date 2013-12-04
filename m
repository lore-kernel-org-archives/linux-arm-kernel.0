From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Dec 2013 18:43:45 +0000
Subject: [RFC PATCH] Documentation: devicetree: add description for
 generic bus properties
In-Reply-To: <20131129023554.GA14239@kroah.com>
References: <20131127172806.GC2291@e103592.cambridge.arm.com>
 <20131128203322.GB14689@mithrandir>
 <20131128211009.GA26447@obsidianresearch.com>
 <20131128222232.GF14689@mithrandir>
 <20131128233147.GA19387@obsidianresearch.com>
 <20131129023554.GA14239@kroah.com>
Message-ID: <20131204184345.GA29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 28, 2013 at 06:35:54PM -0800, Greg KH wrote:
> On Thu, Nov 28, 2013 at 04:31:47PM -0700, Jason Gunthorpe wrote:

> > Greg's point makes sense, but the HW guys are not designing things
> > this way for kicks - there are real physics based reasons for some of
> > these choices...

> > eg An all-to-all bus cross bar (eg like Intel's ring bus) is engery
> > expensive compared to a purpose built muxed bus tree. Doing coherency
> > look ups on DMA traffic costs energy, etc.

> Really?  How much power exactly does it take / save?  Yes, hardware
> people think "software is free", but when you can't actually control the
> hardware in the software properly, well, you end up with something like
> itanium...

If you look at the hardware design decisions this stuff tends to be
totally sensible; there's a bunch of factors at play (complexity, area
and isolation tend to be other ones).  There's a lot of the stuff that
we're complaining about where they can reasonably question why this is
so complex for us.  That doesn't mean that everything that it's possible
to do is sensible but there's definitely limitations on the kernel side
here.

> > > code to deal with those descriptions and the hardware they represent. At
> > > some point we need to start pushing some of the complexity back into
> > > hardware so that we can keep a sane code-base.

> > Some of this is a consequence of the push to have the firmware
> > minimal. As soon as you say the kernel has to configure the address
> > map you've created a big complexity for it..

> Why the push to make firmware "minimal"?  What is that "saving"?  You
> just push the complexity from one place to the other, just because ARM
> doesn't seem to have good firmware engineers, doesn't mean they should
> punish their kernel developers :)

These firmwares have tended to be ROMed or otherwise require expensive
validation to change for sometimes sensible reasons, keeping the amount
of code that's painful to change low will tend to make people happier if
a change is needed.  Most people like the risk mitigation.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131204/b70f276d/attachment.sig>
