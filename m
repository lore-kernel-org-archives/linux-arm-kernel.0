From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Apr 2016 17:03:50 +0100
Subject: [PATCH v2 0/5] Cavium ThunderX uncore PMU support
In-Reply-To: <20160419103510.GA5499@wintermute>
References: <cover.1457539621.git.jglauber@cavium.com>
 <CAEiAFz3eCsX3VoNus_Rq+En5zuB8fAxNCbC3ktw2NqLKwC=_kA@mail.gmail.com>
 <20160419103510.GA5499@wintermute>
Message-ID: <20160419160350.GE20991@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 12:35:10PM +0200, Jan Glauber wrote:
> Mark,
> 
> are these patches still queued or should I repost them?

Apologies for the delay. I've just given these a review.

I note an awful lot of duplication over patches 2-5. The pmu::add
implementations are practically identical, and I suspect can be shared
without much difficulty. Please try to address that unnecessary
duplication.

My comments on patches 2 and 3 larely apply to 4 and 5, so I haven't
reviewed those individually.

Thanks,
Mark.


> 
> --Jan
> 
> On Mon, Apr 04, 2016 at 01:03:13PM +0200, Jan Glauber wrote:
> > Hi Mark,
> > 
> > can you have a look at these patches?
> > 
> > Thanks,
> > Jan
> > 
> > 2016-03-09 17:21 GMT+01:00 Jan Glauber <jglauber@cavium.com>:
> > 
> >     This patch series provides access to various counters on the ThunderX SOC.
> > 
> >     For details of the uncore implementation see patch #1.
> > 
> >     Patches #2-5 add the various ThunderX specific PMUs.
> > 
> >     As suggested I've put the files under drivers/perf/uncore. I would
> >     prefer this location over drivers/bus because not all of the uncore
> >     drivers are bus related.
> > 
> >     Changes to v1:
> >     - Added NUMA support
> >     - Fixed CPU hotplug by pmu migration
> >     - Moved files to drivers/perf/uncore
> >     - Removed OCX FRC and LNE drivers, these will fit better into a edac driver
> >     - improved comments abount overflow interrupts
> >     - removed max device limit
> >     - trimmed include files
> > 
> >     Feedback welcome!
> >     Jan
> > 
> >     -------------------------------------------------
> > 
> >     Jan Glauber (5):
> >     ? arm64/perf: Basic uncore counter support for Cavium ThunderX
> >     ? arm64/perf: Cavium ThunderX L2C TAD uncore support
> >     ? arm64/perf: Cavium ThunderX L2C CBC uncore support
> >     ? arm64/perf: Cavium ThunderX LMC uncore support
> >     ? arm64/perf: Cavium ThunderX OCX TLK uncore support
> > 
> >     ?drivers/perf/Makefile? ? ? ? ? ? ? ? ? ? ? ?|? ?1 +
> >     ?drivers/perf/uncore/Makefile? ? ? ? ? ? ? ? |? ?5 +
> >     ?drivers/perf/uncore/uncore_cavium.c? ? ? ? ?| 314 +++++++++++++++
> >     ?drivers/perf/uncore/uncore_cavium.h? ? ? ? ?|? 95 +++++
> >     ?drivers/perf/uncore/uncore_cavium_l2c_cbc.c | 237 +++++++++++
> >     ?drivers/perf/uncore/uncore_cavium_l2c_tad.c | 600
> >     ++++++++++++++++++++++++++++
> >     ?drivers/perf/uncore/uncore_cavium_lmc.c? ? ?| 196 +++++++++
> >     ?drivers/perf/uncore/uncore_cavium_ocx_tlk.c | 380 ++++++++++++++++++
> >     ?8 files changed, 1828 insertions(+)
> >     ?create mode 100644 drivers/perf/uncore/Makefile
> >     ?create mode 100644 drivers/perf/uncore/uncore_cavium.c
> >     ?create mode 100644 drivers/perf/uncore/uncore_cavium.h
> >     ?create mode 100644 drivers/perf/uncore/uncore_cavium_l2c_cbc.c
> >     ?create mode 100644 drivers/perf/uncore/uncore_cavium_l2c_tad.c
> >     ?create mode 100644 drivers/perf/uncore/uncore_cavium_lmc.c
> >     ?create mode 100644 drivers/perf/uncore/uncore_cavium_ocx_tlk.c
> >    
> >     --
> >     1.9.1
> > 
> > 
> > 
> 
