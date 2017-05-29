From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Mon, 29 May 2017 08:49:42 +0530
Subject: [PATCH v3 0/4] Add support for ThunderX2 pmu events using json
 files
In-Reply-To: <1494923619-18687-1-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1494923619-18687-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <CAFpQJXXRiUnGCkmbdDySEknGfSdaR40xdUY8F+hvwegeH5P5-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Any further review comments on this patch series?
can it go in 4.13?

On Tue, May 16, 2017 at 2:03 PM, Ganapatrao Kulkarni
<ganapatrao.kulkarni@cavium.com> wrote:
> Extending json/jevent framework for parsing arm64 event files.
> Adding jevents for ThunderX2 implementation defined PMU events.
>
> v3:
>    - Addressed comments from Will Deacon and Jayachandran C.
>    - Rebased to 4.12-rc1
>
> v2:
>    - Updated as per Mark Rutland's suggestions.
>    - Added provision for get_cpuid_str to get cpu id string
>      from associated cpus of pmu core device.
>
> v1: Initial patchset.
>
> Ganapatrao Kulkarni (4):
>   perf utils: passing pmu as a parameter to function get_cpuid_str
>   perf tools arm64: Add support for get_cpuid_str function.
>   perf utils: Add helper function is_pmu_core to detect PMU CORE devices
>   perf vendor events arm64: Add ThunderX2 implementation defined pmu
>     core events
>
>  tools/perf/arch/arm64/util/Build                   |  1 +
>  tools/perf/arch/arm64/util/header.c                | 59 ++++++++++++++++++++
>  tools/perf/arch/powerpc/util/header.c              |  2 +-
>  tools/perf/arch/x86/util/header.c                  |  2 +-
>  tools/perf/pmu-events/arch/arm64/mapfile.csv       | 15 ++++++
>  .../arm64/thunderx2/implementation-defined.json    | 62 ++++++++++++++++++++++
>  tools/perf/util/header.h                           |  3 +-
>  tools/perf/util/pmu.c                              | 53 +++++++++++++++---
>  8 files changed, 186 insertions(+), 11 deletions(-)
>  create mode 100644 tools/perf/arch/arm64/util/header.c
>  create mode 100644 tools/perf/pmu-events/arch/arm64/mapfile.csv
>  create mode 100644 tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json
>
> --
> 1.8.1.4
>

thanks
Ganapat
