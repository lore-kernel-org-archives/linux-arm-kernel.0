From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Tue, 28 Jun 2016 16:04:59 +0200
Subject: [PATCH v2 0/5] Cavium ThunderX uncore PMU support
In-Reply-To: <20160628102419.GA5425@arm.com>
References: <cover.1457539621.git.jglauber@cavium.com>
 <20160628102419.GA5425@arm.com>
Message-ID: <20160628140459.GA27541@hardcore>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2016 at 11:24:20AM +0100, Will Deacon wrote:
> Hi Jan,
> 
> On Wed, Mar 09, 2016 at 05:21:02PM +0100, Jan Glauber wrote:
> > This patch series provides access to various counters on the ThunderX SOC.
> > 
> > For details of the uncore implementation see patch #1.
> > 
> > Patches #2-5 add the various ThunderX specific PMUs.
> > 
> > As suggested I've put the files under drivers/perf/uncore. I would
> > prefer this location over drivers/bus because not all of the uncore
> > drivers are bus related.
> 
> What's the status of these patches? Were you planning to send a new
> version?
> 
> Will

Hi Will,

I was half-way through with addressing Mark's review comments when
got side-tracked.

The principle question these patches raised remains open though in my
opinion, how to determine the socket a device belongs to.

There is no first-class interface to ask a device or the firmware
which socket the device lives on.

The options I see are:
A) Using NUMA node information, depends on CONFIG_NUMA
B) Decoding the socket bits of the PCI BAR address
C) Using PCI topology information

A is what I tried, but I agree that depending on CONFIG_NUMA is not a good
solution. B would be easy but looks not very future-proof. So option C
is what is left...

thanks,
Jan
