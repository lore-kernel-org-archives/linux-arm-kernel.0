From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Wed, 4 Feb 2015 05:14:20 -0800
Subject: [rcu] [ INFO: suspicious RCU usage. ]
In-Reply-To: <20150204130018.GG8656@n2100.arm.linux.org.uk>
References: <20150201025922.GA16820@wfg-t540p.sh.intel.com>
 <1422957702.17540.1.camel@AMDC1943>
 <20150203162704.GR19109@linux.vnet.ibm.com>
 <1423049947.19547.6.camel@AMDC1943>
 <20150204130018.GG8656@n2100.arm.linux.org.uk>
Message-ID: <20150204131420.GC5370@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 04, 2015 at 01:00:18PM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 04, 2015 at 12:39:07PM +0100, Krzysztof Kozlowski wrote:
> > +Cc some ARM people
> 
> I wish that people would CC this list with problems seen on ARM.  I'm
> minded to just ignore this message because of this in the hope that by
> doing so, people will learn something...
> 
> > > Another thing I could do would be to have an arch-specific Kconfig
> > > variable that made ARM responsible for informing RCU that the CPU
> > > was departing, which would allow a call to as follows to be placed
> > > immediately after the complete():
> > > 
> > > rcu_cpu_notify(NULL, CPU_DYING_IDLE, (void *)(long)smp_processor_id());
> > > 
> > > Note:  This absolutely requires that the rcu_cpu_notify() -always-
> > > be allowed to execute!!!  This will not work if there is -any- possibility
> > > of __cpu_die() powering off the outgoing CPU before the call to
> > > rcu_cpu_notify() returns.
> 
> Exactly, so that's not going to be possible.  The completion at that
> point marks the point at which power _could_ be removed from the CPU
> going down.

OK, sounds like a polling loop is required.

							Thanx, Paul
