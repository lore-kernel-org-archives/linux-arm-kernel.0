From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Nov 2011 15:53:34 +0000
Subject: [PATCH 3/5] ARM: vexpress: Add DT support in v2m
In-Reply-To: <1321463271.3137.380.camel@hornet.cambridge.arm.com>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-4-git-send-email-pawel.moll@arm.com>
 <20111116154402.GE2073@localhost.localdomain> <4EC3E446.4030608@gmail.com>
 <1321461458.3137.374.camel@hornet.cambridge.arm.com>
 <4EC3EBEC.3020601@gmail.com>
 <1321463271.3137.380.camel@hornet.cambridge.arm.com>
Message-ID: <20111117155334.GT9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 05:07:51PM +0000, Pawel Moll wrote:
> On Wed, 2011-11-16 at 16:59 +0000, Rob Herring wrote:
> > It has nothing to do with taste and obviously documentation changes over
> > time. I'm going to start naming everything with legacy because someday
> > it all will be...
> > 
> > It's about how you create compatible strings. They should not be
> > generic, but specific to particular hardware version. If you happen to
> > be compatible with older h/w then you can claim compatibility with that
> > older h/w.
> 
> Notice that it's not:
> 
> 	compatible=legacy
> 
> not even:
> 
> 	compatible=arm,legacy
> 
> It's:
> 	
> 	compatible=arm,vexpress-legacy
> 
> A specific variant of Versatile Express hardware. It's just that the
> "legacy" word carries some meaning. Would it looked better if it was
> called:
> 
> 	compatible=arm,vexpress-nalatenskap
> 
> ? (thanks, google translate ;-)

You're totally failing to understand the point.

The point is that when Versatile Express first came out, it had a memory
map.  At this point in time, there was nothing 'legacy' about it, it was
the latest and greatest thing.

If DT support was created at this point, it would have been called
something without 'legacy' in its name.

A year or so on, it's been superseded by something else, and is now called
legacy.  The way DT works, you don't go around renaming stuff because it's
become legacy.  So, the original DT support still stands using whatever
named properties would have been invented at the time.

So, when we create support for it *now*, we should not be creating a DT
file with properties named as 'legacy'.  The fact that it has become
legacy _today_ is irrelevant to DT.

If we follow through the argument that we _should_ name things legacy,
then it follows that we need to constantly patch DT files to rename stuff
to 'legacy' when it's no longer the latest and greatest - and then you
need the right DT file corresponding to the right kernel version.

Again, this is _not_ how DT is supposed to work.  DT is about describing
the hardware, not describing the state of something.  A DT description
of a hardware system created 10 years ago should still work _today_ even
though the hardware system may now be 'legacy'.

So, get rid of that 'legacy' crap in DT naming.  It doesn't belong.  Or
we'll start talling the Cortex-A5 stuff 'legacy' right now as well.
