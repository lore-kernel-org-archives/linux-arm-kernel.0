From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 Jan 2016 10:23:14 +0000
Subject: [v3,11/41] mips: reuse asm-generic/barrier.h
In-Reply-To: <20160126233733.GZ4503@linux.vnet.ibm.com>
References: <20160114212913.GF3818@linux.vnet.ibm.com>
 <569814F2.50801@imgtec.com>
 <20160114225510.GJ3818@linux.vnet.ibm.com>
 <20160115102431.GB2131@arm.com>
 <20160115175401.GW3818@linux.vnet.ibm.com>
 <20160115192845.GA12510@linux.vnet.ibm.com>
 <20160125144133.GB22927@arm.com>
 <20160126010646.GH4503@linux.vnet.ibm.com>
 <20160126121010.GD21553@arm.com>
 <20160126233733.GZ4503@linux.vnet.ibm.com>
Message-ID: <20160127102313.GC2390@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 03:37:33PM -0800, Paul E. McKenney wrote:
> On Tue, Jan 26, 2016 at 12:10:10PM +0000, Will Deacon wrote:
> > On Mon, Jan 25, 2016 at 05:06:46PM -0800, Paul E. McKenney wrote:
> > > PPC WRCnf+addrs
> > > ""
> > > {
> > > 0:r2=x; 0:r3=y;
> > > 1:r2=x; 1:r3=y;
> > > 2:r2=x; 2:r3=y;
> > > c=a; d=b; x=c; y=d;
> > > }
> > >  P0           | P1            | P2            ;
> > >  stw r3,0(r2) | lwz r8,0(r2)  | lwz r8,0(r3)  ;
> > >               | stw r2,0(r8)  | lwz r9,0(r8)  ;
> > > exists
> > > (1:r8=y /\ 2:r8=x /\ 2:r9=c)
> > 
> > Agreed.
> 
> OK, thank you!  Would you agree that it would be good to replace the
> current xor-based fake-dependency litmus tests with tests having real
> dependencies?

Yes, because it would look a lot more like real (kernel) code.

Will
