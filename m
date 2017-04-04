From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 4 Apr 2017 13:29:43 +0100
Subject: [PATCH 0/3] Add support for ThunderX2 pmu events using json files
In-Reply-To: <1491291403-29893-1-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1491291403-29893-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <20170404122943.GC8551@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 04, 2017 at 01:06:40PM +0530, Ganapatrao Kulkarni wrote:
> Extending json/jevent framework for parsing arm64 event files.
> Adding jevents for ThunderX2 implementation defined PMU events.

Thanks for having a look at this!

While I agree this is the right approach generally, I have a couple of
issues with the implementation, which I have commented upon in
subsequent patches.

Thanks,
Mark.

> Ganapatrao Kulkarni (3):
>   perf jevents: Add support to use core pmu name other than cpu
>   perf tools arm64: implement function get_cpuid_str
>   perf tool, arm64, thunderx2: Add implementation defined events for
>     thunderx2
> 
>  tools/perf/arch/arm64/util/Build                   |  1 +
>  tools/perf/arch/arm64/util/header.c                | 51 +++++++++++++++
>  tools/perf/pmu-events/arch/arm64/mapfile.csv       |  2 +
>  .../arm64/thunderx2/implementation-defined.json    | 72 ++++++++++++++++++++++
>  tools/perf/pmu-events/jevents.c                    | 15 +++--
>  tools/perf/pmu-events/jevents.h                    |  3 +-
>  tools/perf/pmu-events/pmu-events.h                 |  1 +
>  tools/perf/util/pmu.c                              |  2 +-
>  8 files changed, 140 insertions(+), 7 deletions(-)
>  create mode 100644 tools/perf/arch/arm64/util/header.c
>  create mode 100644 tools/perf/pmu-events/arch/arm64/mapfile.csv
>  create mode 100644 tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json
> 
> -- 
> 1.8.1.4
> 
