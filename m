From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Aug 2013 14:09:32 +0100
Subject: [PATCH v4 1/1] ASoc: kirkwood: add DT support to the mvebu
 audio subsystem
In-Reply-To: <20130809113940.GY6427@sirena.org.uk>
References: <20130808132201.2610aef3@armhf> <5204A716.6070507@gmail.com>
 <20130809091953.GO6427@sirena.org.uk> <5204B7A6.9050907@gmail.com>
 <20130809094340.GO23006@n2100.arm.linux.org.uk> <5204CC04.4000401@gmail.com>
 <20130809113940.GY6427@sirena.org.uk>
Message-ID: <20130809130932.GS23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 12:39:40PM +0100, Mark Brown wrote:
> So extend Morimoto-san's work on the simple card for this - that's what
> it's there for, it's doing exactly this job for non-DT systems but it
> just didn't get DT support added yet.  All the trivial cards should end
> up using this.

It's quite rediculous to request that the simple card stuff is expanded at
this time, when you're also telling us that we must use DPCM for Kirkwood,
but DPCM is not yet in a working state in mainline.  We don't yet know
whether that's because of something the core is doing wrong or whether
that's because something that I'm doing wrong.  The reason we don't know
that is because the _only_ person who knows anything about this is Liam,
and as you have said, Liam is away on vacation.

All that we presently know is that DPCM is supposed to be "something like
this".  However, when we do that, it doesn't work, which means we can't
be certain what the end result is supposed to look like.  It may be that
Liam has changed some of the design decisions with DPCM.

We know that various things are missing - like the .pcm_playback member in
the DAI link.  That points to Liam having additional patches to the core
code in his tree to make DPCM work.  That could impact our scenario here,
and how the "simple" card should be implemented.

So, what you're asking is for us to extend the design of something in a
way that we know very little about how to make work.

To that I say: No.  Let's wait for Liam to return from vacation so that
this can be sorted out properly with someone who knows this code.
