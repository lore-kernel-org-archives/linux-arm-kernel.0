From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 6 Jan 2014 12:43:37 +0000
Subject: L1 & L2 cache flush sequence on CortexA5 MPcore w.r.t low power
 modes
In-Reply-To: <87ha9yqgpb.fsf@iki.fi>
References: <CAF0TxboSEZuHO6mo-F=os9cvNCyAfVjs3j=SSLjgC7DV6Q_jow@mail.gmail.com>
 <20120514155022.GA3792@e102568-lin.cambridge.arm.com>
 <20120514155859.GA13860@n2100.arm.linux.org.uk>
 <20120514162150.GA4654@e102568-lin.cambridge.arm.com>
 <87ha9yqgpb.fsf@iki.fi>
Message-ID: <20140106124337.GB9863@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 24, 2013 at 05:52:48PM +0000, Antti Miettinen wrote:
> Sorry to still bring up an old thread, but this still bothers me..
> 
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> > [..] dirty cache lines can be migrated across
> > processors caches. [..]
> 
> What are the conditions under which this can happen? Which CPUs in
> reality migrate dirty lines between caches? And C==0 does prevent
> migrations as well as local allocations?

It happens if a cache miss is for a cache line that is dirty on another CPU
that is part of the coherency domain, the line is just moved from one L1
to the local L1.

Yes, C bit cleared prevents allocations so it prevents migrations too.

Lorenzo
