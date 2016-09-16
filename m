From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Fri, 16 Sep 2016 10:39:01 +0200
Subject: [PATCH v2 0/5] Cavium ThunderX uncore PMU support
In-Reply-To: <20160916075523.GJ3380@arm.com>
References: <cover.1457539621.git.jglauber@cavium.com>
 <20160628102419.GA5425@arm.com> <20160628140459.GA27541@hardcore>
 <20160704101132.GC1639@arm.com> <20160916075523.GJ3380@arm.com>
Message-ID: <20160916083901.GC3069@hardcore>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2016 at 08:55:24AM +0100, Will Deacon wrote:
> Hi Jan,
> 
> On Mon, Jul 04, 2016 at 11:11:32AM +0100, Will Deacon wrote:
> > On Tue, Jun 28, 2016 at 04:04:59PM +0200, Jan Glauber wrote:
> > > On Tue, Jun 28, 2016 at 11:24:20AM +0100, Will Deacon wrote:
> > > > On Wed, Mar 09, 2016 at 05:21:02PM +0100, Jan Glauber wrote:
> > > > > This patch series provides access to various counters on the ThunderX SOC.
> > > > > 
> > > > > For details of the uncore implementation see patch #1.
> > > > > 
> > > > > Patches #2-5 add the various ThunderX specific PMUs.
> > > > > 
> > > > > As suggested I've put the files under drivers/perf/uncore. I would
> > > > > prefer this location over drivers/bus because not all of the uncore
> > > > > drivers are bus related.
> > > > 
> > > > What's the status of these patches? Were you planning to send a new
> > > > version?
> > >
> > > I was half-way through with addressing Mark's review comments when
> > > got side-tracked.
> > > 
> > > The principle question these patches raised remains open though in my
> > > opinion, how to determine the socket a device belongs to.
> > > 
> > > There is no first-class interface to ask a device or the firmware
> > > which socket the device lives on.
> > > 
> > > The options I see are:
> > > A) Using NUMA node information, depends on CONFIG_NUMA
> > > B) Decoding the socket bits of the PCI BAR address
> > > C) Using PCI topology information
> > > 
> > > A is what I tried, but I agree that depending on CONFIG_NUMA is not a good
> > > solution. B would be easy but looks not very future-proof. So option C
> > > is what is left...
> > 
> > Sorry to go full circle on this, but "depends on NUMA" sounds better
> > than deriving NUMA topology from PCI to me. The only worry I have is if
> > the NUMA information ends up being insufficient in the long-term, and we
> > end up with a mixture of the three options above in order to figure out
> > the PMU topology.
> > 
> > As long as you're happy that the PMU:NUMA topology remains 1:1, then I
> > have no objections. The moment you need extra hacks on the side, we should
> > probably drop the NUMA dependency altogether and figure it out some other
> > way.
> 
> Any news on this series, or did I miss a v3? I was hoping to have this in
> for 4.9, but it seems to have stalled :(
> 
> Will

No news, I'm afraid it is stalled on my side :( I'll try to get back to
it, but not for 4.9.

Jan
