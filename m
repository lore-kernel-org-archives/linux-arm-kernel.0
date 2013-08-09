From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Aug 2013 19:25:16 +0100
Subject: [PATCH v4 1/1] ASoc: kirkwood: add DT support to the mvebu
 audio subsystem
In-Reply-To: <20130809180058.GM6427@sirena.org.uk>
References: <20130808132201.2610aef3@armhf> <5204A716.6070507@gmail.com>
 <20130809091953.GO6427@sirena.org.uk> <5204B7A6.9050907@gmail.com>
 <20130809094340.GO23006@n2100.arm.linux.org.uk> <5204CC04.4000401@gmail.com>
 <20130809113940.GY6427@sirena.org.uk>
 <20130809130932.GS23006@n2100.arm.linux.org.uk>
 <20130809180058.GM6427@sirena.org.uk>
Message-ID: <20130809182516.GT23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 07:00:58PM +0100, Mark Brown wrote:
> On Fri, Aug 09, 2013 at 02:09:32PM +0100, Russell King - ARM Linux wrote:
> > On Fri, Aug 09, 2013 at 12:39:40PM +0100, Mark Brown wrote:
> 
> > > So extend Morimoto-san's work on the simple card for this - that's what
> > > it's there for, it's doing exactly this job for non-DT systems but it
> > > just didn't get DT support added yet.  All the trivial cards should end
> > > up using this.
> 
> > It's quite rediculous to request that the simple card stuff is expanded at
> > this time, when you're also telling us that we must use DPCM for Kirkwood,
> 
> That's the place to put the sort of shared infrastructure for trivial
> cards that Sebastian said he wanted to see - if you guys are saying that
> the machines should all be able to use a trivial binding with shared
> code that's where that code should be.

Sigh, you completely miss the point.

What all three of us are ultimately after is a DT description for the
kirkwood stuff which covers all its use cases.  The use case which all
three of us have in common is the Cubox, which is the one which needs
the spdif stuff to work.

Now, what you've said to date is:

1. you want kirkwood to use DPCM.
2. you want kirkwood using people to use the simple card stuff with the
   kirkwood driver you want to use DPCM.

To make it work with DPCM, we first need to know what DPCM requires,
which means we either have to have the knowledge of DPCM and/or have a
working implementation.  We don't have either of those yet.

So, I again state plainly that what you're asking is for people to come
up with a DT description for a DPCM implementation when we haven't yet
got a working DPCM implementation, even without DT.

It is this which I assert is a completely rediculous request at this
moment in time for the reasons stated in my previous email and repeated
in this email.
