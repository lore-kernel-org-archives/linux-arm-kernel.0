From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 12 Mar 2010 08:44:31 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <20100310035249.GB17693@linux-sh.org>
References: <20100303215437.GF2579@ucw.cz>
	<1267709756.6526.380.camel@e102109-lin.cambridge.arm.com>
	<20100304135128.GA12191@atrey.karlin.mff.cuni.cz>
	<1267712512.31654.176.camel@mulgrave.site>
	<1267716578.6526.483.camel@e102109-lin.cambridge.arm.com>
	<20100304154103.GA9384@linux-sh.org>
	<1267726049.6526.543.camel@e102109-lin.cambridge.arm.com>
	<1267738660.22204.77.camel@pasglop>
	<20100305011745.GC26618@linux-sh.org>
	<1267764295.22204.102.camel@pasglop>
	<20100310035249.GB17693@linux-sh.org>
Message-ID: <1268343871.22204.709.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-03-10 at 12:52 +0900, Paul Mundt wrote:
> Well, it does start to get a bit painful with sparsemem section or
> NUMA
> node IDs also digging in to the page flags on 32-bit.. the benefits
> would
> have to be pretty compelling to offset the pain. 

Unless we play a dangerous trick and re-use another flag that isn't
meaningful for allocated pages... maybe PG_buddy ? Or do I miss
something about that guy semantics ?

Cheers,
Ben.
