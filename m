From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 22 May 2013 12:49:36 -0400
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on
 Armada 370/XP
In-Reply-To: <20130522184250.1d5f2f10@skate>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305221633.46705.arnd@arndb.de> <20130522170643.54a2b9d2@skate>
 <201305221735.11815.arnd@arndb.de> <20130522180842.7edcc3ee@skate>
 <20130522163557.GC27348@1wt.eu> <20130522184250.1d5f2f10@skate>
Message-ID: <20130522164936.GE31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Thomas,

On Wed, May 22, 2013 at 06:42:50PM +0200, Thomas Petazzoni wrote:
> On Wed, 22 May 2013 18:35:57 +0200, Willy Tarreau wrote:
> > On Wed, May 22, 2013 at 06:08:42PM +0200, Thomas Petazzoni wrote:
> > > Conclusion: you can't classify on one side boards that are at 0xd0 and
> > > boards that are at 0xf1. It depends on *which* bootloader each
> > > particular instance of those boards will be using. Will it be a
> > > bootloader that complies with the "old" protocol (CP15 bit cleared and
> > > registers at 0xd0) or the "new" protocol (CP15 bit set and registers at
> > > 0xf1).
> > 
> > Just a point I'm thinking about, is it possible to detect the boot loader's
> > mode via ATAGs ? ATAGs are present very early as well (but maybe too late
> > already).
> 
> As far as I know, a DT-capable bootloader doesn't pass any ATAG. The
> ARM register that was used to pass the pointer to the ATAGS is now used
> to pass the pointer to the DTB in memory.

So we could look for the ATAG magic or the dtb magic at that address,
then we know if we have an old or new bootloader...

thx,

Jason.
