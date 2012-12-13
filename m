From: steve.capper@arm.com (Steve Capper)
Date: Thu, 13 Dec 2012 13:13:25 +0000
Subject: [RFC PATCH 1/3] ARM: mm: Add discontiguous memory support.
In-Reply-To: <20121212180121.GB14363@n2100.arm.linux.org.uk>
References: <1355334049-10247-1-git-send-email-steve.capper@arm.com>
 <1355334049-10247-2-git-send-email-steve.capper@arm.com>
 <20121212180121.GB14363@n2100.arm.linux.org.uk>
Message-ID: <20121213131324.GA2154@e103986-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 06:01:21PM +0000, Russell King - ARM Linux wrote:
> On Wed, Dec 12, 2012 at 05:40:47PM +0000, Steve Capper wrote:
> > This patch adds support for discontiguous memory, with a view to
> > each discontiguous block being assigned to a NUMA node (in a future
> > patch).
> > 
> > Discontiguous memory should only be used to back NUMA on systems
> > where sparse memory is not available.
> 
> Err, we had this, and then we ripped it all out.  Do we have any NUMA ARM
> systems?  I don't think we do.

Hi Russell,
There aren't any ARM NUMA systems out at the moment, but the Linux NUMA
subsystem can be used to group cores that share an L2 cache together into the
same node. This can then potentially reduce the L3 traffic required to run
certain tasks, as the scheduler has a notion of memory topology that matches
the cache topology. (An example platform where this can be beneficial is the TC2).

Best,
-- 
Steve
