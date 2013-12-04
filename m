From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Dec 2013 20:27:28 +0000
Subject: [RFC PATCH] Documentation: devicetree: add description for
 generic bus properties
In-Reply-To: <20131204190312.GA5070@kroah.com>
References: <20131127172806.GC2291@e103592.cambridge.arm.com>
 <20131128203322.GB14689@mithrandir>
 <20131128211009.GA26447@obsidianresearch.com>
 <20131128222232.GF14689@mithrandir>
 <20131128233147.GA19387@obsidianresearch.com>
 <20131129023554.GA14239@kroah.com>
 <20131204184345.GA29268@sirena.org.uk>
 <20131204190312.GA5070@kroah.com>
Message-ID: <20131204202728.GF29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 11:03:12AM -0800, Greg KH wrote:
> On Wed, Dec 04, 2013 at 06:43:45PM +0000, Mark Brown wrote:

> > If you look at the hardware design decisions this stuff tends to be
> > totally sensible; there's a bunch of factors at play (complexity, area
> > and isolation tend to be other ones).  There's a lot of the stuff that
> > we're complaining about where they can reasonably question why this is
> > so complex for us.  That doesn't mean that everything that it's possible
> > to do is sensible but there's definitely limitations on the kernel side
> > here.

> The main reason it's so "complex" is the drive for people to have a "one
> kernel image for multiple systems" and hence the need to have DT handle
> all of this.  I don't think that requirement has been pushed back on the
> hardware engineers yet, and they are still thinking that a custom image
> per chip is ok.

No, the single system image stuff is orthogonal here and is basically
irrelevant for many use cases - it's essential for servers and so on but
most consumer electronics guys pretty much don't care and this stuff is
as much a problem for them as anyone else.  We've always struggled with
these things even when building for specific hardware, DT is just
another way to write the data structure here.  When people are talking
about figuring out the DT first here what they're taking about is as
much working out what we need to abstract first as anything else.

This isn't a million miles away from the stuff we've dealt with using
probe deferral in terms of fitting into the device model, at least at a
high level, though it is harder to sidestep the issues here.

> > These firmwares have tended to be ROMed or otherwise require expensive
> > validation to change for sometimes sensible reasons, keeping the amount
> > of code that's painful to change low will tend to make people happier if
> > a change is needed.  Most people like the risk mitigation.

> I love it how it's so easy to make the kernel be the part of the whole
> system stack that is simpler to change than any other :)

Dammn open source license :)

> I'm all for making Linux be the "firmware" and deal with these very
> low-level issues directly, but again, this drives in the face of your
> self-stated goal of "one image per architecture" for the kernel.  You
> kind of can't have it both ways it seems, so someone needs to make up
> their mind as to what it's going to be...

I think you're confusing me with someone else...  in any case, I don't
see why there should be any conflict here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131204/2c2c9d03/attachment-0001.sig>
