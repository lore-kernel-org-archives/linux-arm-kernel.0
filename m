From: dwalker@fifo99.com (Daniel Walker)
Date: Wed, 11 Apr 2012 11:06:34 -0700
Subject: [PATCH v2 3/4] ARM: mm: truncate memory banks to fit in 4GB
 space for classic MMU
In-Reply-To: <20120411174024.GC24211@n2100.arm.linux.org.uk>
References: <1334154639-13869-1-git-send-email-will.deacon@arm.com>
 <1334154639-13869-4-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.02.1204111038130.16314@xanadu.home>
 <20120411155232.GA24211@n2100.arm.linux.org.uk>
 <20120411162730.GB24211@n2100.arm.linux.org.uk>
 <20120411173849.GA8114@fifo99.com>
 <20120411174024.GC24211@n2100.arm.linux.org.uk>
Message-ID: <20120411180634.GC8114@fifo99.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 06:40:24PM +0100, Russell King - ARM Linux wrote:
> On Wed, Apr 11, 2012 at 10:38:50AM -0700, Daniel Walker wrote:
> > On Wed, Apr 11, 2012 at 05:27:30PM +0100, Russell King - ARM Linux wrote:
> > > While here, I propose to delete these:
> > > 
> > > arch/arm/mach-msm/board-mahimahi.c:     mi->bank[0].start = PHYS_OFFSET;
> > > arch/arm/mach-msm/board-mahimahi.c:     mi->bank[0].node = PHYS_TO_NID(PHYS_OFFSET);
> > > arch/arm/mach-msm/board-mahimahi.c:     mi->bank[0].size = (219*1024*1024);
> > > arch/arm/mach-msm/board-mahimahi.c:     mi->bank[1].start = MSM_HIGHMEM_BASE;
> > > arch/arm/mach-msm/board-mahimahi.c:     mi->bank[1].node = PHYS_TO_NID(MSM_HIGHMEM_BASE);
> > > arch/arm/mach-msm/board-mahimahi.c:     mi->bank[1].size = MSM_HIGHMEM_SIZE;
> > > arch/arm/mach-msm/board-sapphire.c:     mi->bank[0].start = PHYS_OFFSET;
> > > arch/arm/mach-msm/board-sapphire.c:     mi->bank[0].node = PHYS_TO_NID(PHYS_OFFSET);
> > > arch/arm/mach-msm/board-sapphire.c:             mi->bank[0].size = (84*1024*1024);
> > > arch/arm/mach-msm/board-sapphire.c:             mi->bank[0].size = (101*1024*1024);
> > > arch/arm/mach-msm/board-sapphire.c:             mi->bank[0].size = (101*1024*1024);
> > > 
> > > because they haven't been buildable since 7th May 2010 (that's 23 months
> > > ago), and no one has reported any build errors with them.  They're only
> > > receiving updates from other sweeps and nothing more.  This all means no
> > > one is even attempting to build this code.  It's pointless having
> > > unbuildable code in the kernel, and it's nothing more than a useless
> > > maintanence burden.
> > 
> > 
> > It can't be that hard to fix.. I'll look into cleaning it up.
> 
> What's the point of fixing code which isn't being used by anyone?  As I
> said above, it's a maintanence burden and if its not being used it needs
> to be removed.
> 

Aren't there whole are sub-architectures that don't even build ? I think
something that's a work in progress is fine, as long as someone (i.e.
me) plans to get back to it at some point.

I also said that _I_ would make it build .. So someone is going to use
it, and it is going to build.

Daniel
