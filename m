From: robert.richter@cavium.com (Robert Richter)
Date: Wed, 11 Oct 2017 15:24:31 +0200
Subject: [PATCH v6 4/4] perf vendor events arm64: Add ThunderX2
 implementation defined pmu core events
In-Reply-To: <20171011121926.GC11106@arm.com>
References: <20170824120349.2323-1-ganapatrao.kulkarni@cavium.com>
 <20170824120349.2323-5-ganapatrao.kulkarni@cavium.com>
 <43dcc107-263a-5429-73d4-a5290c6610d6@hisilicon.com>
 <20170829124730.GH17961@rric.localdomain>
 <20171011121926.GC11106@arm.com>
Message-ID: <20171011132431.GL17961@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.10.17 13:19:27, Will Deacon wrote:
> On Tue, Aug 29, 2017 at 02:47:30PM +0200, Robert Richter wrote:
> > Shaokun,
> > 
> > On 29.08.17 17:26:00, Zhangshaokun wrote:
> > > On 2017/8/24 20:03, Ganapatrao Kulkarni wrote:
> > > > This is not a full event list, but a short list of useful events.
> > > > 
> > > > Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> > > > ---
> > > >  tools/perf/pmu-events/arch/arm64/mapfile.csv       | 15 ++++++
> > > >  .../arm64/thunderx2/implementation-defined.json    | 62 ++++++++++++++++++++++
> > > >  2 files changed, 77 insertions(+)
> > > >  create mode 100644 tools/perf/pmu-events/arch/arm64/mapfile.csv
> > > >  create mode 100644 tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json
> > > > 
> > > 
> > > I saw you also used thunderx2 in tools/perf/pmu-events/arch/arm64/, how about John's suggestion
> > > that would use vendor sub-folder?
> > > Of course, appreciate maintainer's comments.
> > 
> > this would just add another level of subdirectories. I rather would
> > prefer to have a per platform dir comparable to what is listed in
> > 
> >  arch/arm64/Kconfig.platforms
> > 
> > This is the same as Ganapat has implemented it.
> 
> FWIW, I agree with Zhangshaokun here that a silicon vendor subdirectory
> would organise things better. It also matches what we do for
> arch/arm64/boot/dts/

A file structure like:

 tools/perf/pmu-events/arch/arm64/cavium/thunderx2/implementation-defined.json

looks quite horible. In contrast to dts dir we will need another
subdir for each platform and will then have two levels of subdirs.
This is also different to other archs where there is no extra vendor
dir.

I haven't checked if implementation allows json files to reside deeper
in the subdir level.

Anyway, it is bike-shedding.

-Robert
