From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Fri, 10 Jun 2011 19:08:07 +0100
Subject: [PATCH 00/10] mm: Linux VM Infrastructure to support Memory
	Power Management
In-Reply-To: <20110610175248.GF2230@linux.vnet.ibm.com>
References: <20110528005640.9076c0b1.akpm@linux-foundation.org>
	<20110609185259.GA29287@linux.vnet.ibm.com>
	<BANLkTinxeeSby_+tta8EhzCg3VbD6+=g+g@mail.gmail.com>
	<20110610151121.GA2230@linux.vnet.ibm.com>
	<20110610155954.GA25774@srcf.ucam.org>
	<20110610165529.GC2230@linux.vnet.ibm.com>
	<20110610170535.GC25774@srcf.ucam.org>
	<20110610171939.GE2230@linux.vnet.ibm.com>
	<20110610172307.GA27630@srcf.ucam.org>
	<20110610175248.GF2230@linux.vnet.ibm.com>
Message-ID: <20110610180807.GB28500@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2011 at 10:52:48AM -0700, Paul E. McKenney wrote:
> On Fri, Jun 10, 2011 at 06:23:07PM +0100, Matthew Garrett wrote:
> > I haven't seen too many ARM servers with 256GB of RAM :) I'm mostly 
> > looking at this from an x86 perspective.
> 
> But I have seen ARM embedded systems with CPU power consumption in
> the milliwatt range, which greatly reduces the amount of RAM required
> to get significant power savings from this approach.  Three orders
> of magnitude less CPU power consumption translates (roughly) to three
> orders of magnitude less memory required -- and embedded devices with
> more than 256MB of memory are quite common.

I'm not saying that powering down memory isn't a win, just that in the 
server market we're not even getting unused memory into self refresh at 
the moment. If we can gain that hardware capability then sub-node zoning 
means that we can look at allocating (and migrating?) RAM in such a way 
as to get a lot of the win that we'd gain from actually cutting the 
power, without the added overhead of actually shrinking our working set.

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
