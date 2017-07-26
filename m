From: zhangshaokun@hisilicon.com (Zhangshaokun)
Date: Wed, 26 Jul 2017 10:49:27 +0800
Subject: [PATCH v4 0/4] Add support for ThunderX2 pmu events using json
 files
In-Reply-To: <20170720055608.5333-1-ganapatrao.kulkarni@cavium.com>
References: <20170720055608.5333-1-ganapatrao.kulkarni@cavium.com>
Message-ID: <703853c0-eab2-df0a-43d4-5d3f26bd61dd@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Ganapat

I have tested patch-v4 on Hisilicon's hip08 board for implementation defined PMU events,
and it works, So
Tested-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Thanks.
Shaokun

On 2017/7/20 13:56, Ganapatrao Kulkarni wrote:
> Extending json/jevent framework for parsing arm64 event files.
> Adding jevents for ThunderX2 implementation defined PMU events.
> 
> v4:
>    - Rebased to 4.13-rc1
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
