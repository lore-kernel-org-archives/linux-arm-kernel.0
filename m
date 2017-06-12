From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Mon, 12 Jun 2017 15:51:46 +0530
Subject: [PATCH v3 0/4] Add support for ThunderX2 pmu events using json
 files
In-Reply-To: <ee7fedb0-a981-1f06-06fa-8e76ef502fa2@hisilicon.com>
References: <1494923619-18687-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <ee7fedb0-a981-1f06-06fa-8e76ef502fa2@hisilicon.com>
Message-ID: <CAFpQJXW2=_8pZr=yB7sFn1V2gP__b_vuMiNyr2ELkA3WEqJFxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shaokun,

On Mon, Jun 12, 2017 at 3:19 PM, Zhangshaokun
<zhangshaokun@hisilicon.com> wrote:
> Hi Ganapat
>
> This patchset has been tested on Hisilicon's hip08 board for implementation defined PMU events:
> (1)perf list command is ok;
> (2)perf stat command -e event_name:
> When event number is less than 0x3ff, it is ok;
> if event number is more than 0x3ff, it should be added this patch:
> https://www.spinics.net/lists/arm-kernel/msg583222.html

thanks for testing!

>
> Thanks.
> Shaokun
>
> On 2017/5/16 16:33, Ganapatrao Kulkarni wrote:
>> Extending json/jevent framework for parsing arm64 event files.
>> Adding jevents for ThunderX2 implementation defined PMU events.
>>
>> v3:
>>    - Addressed comments from Will Deacon and Jayachandran C.
>>    - Rebased to 4.12-rc1
>>
>> v2:
>>    - Updated as per Mark Rutland's suggestions.
>>    - Added provision for get_cpuid_str to get cpu id string
>>      from associated cpus of pmu core device.
>>
>> v1: Initial patchset.
>>
>> Ganapatrao Kulkarni (4):
>>   perf utils: passing pmu as a parameter to function get_cpuid_str
>>   perf tools arm64: Add support for get_cpuid_str function.
>>   perf utils: Add helper function is_pmu_core to detect PMU CORE devices
>>   perf vendor events arm64: Add ThunderX2 implementation defined pmu
>>     core events
>>
>>  tools/perf/arch/arm64/util/Build                   |  1 +
>>  tools/perf/arch/arm64/util/header.c                | 59 ++++++++++++++++++++
>>  tools/perf/arch/powerpc/util/header.c              |  2 +-
>>  tools/perf/arch/x86/util/header.c                  |  2 +-
>>  tools/perf/pmu-events/arch/arm64/mapfile.csv       | 15 ++++++
>>  .../arm64/thunderx2/implementation-defined.json    | 62 ++++++++++++++++++++++
>>  tools/perf/util/header.h                           |  3 +-
>>  tools/perf/util/pmu.c                              | 53 +++++++++++++++---
>>  8 files changed, 186 insertions(+), 11 deletions(-)
>>  create mode 100644 tools/perf/arch/arm64/util/header.c
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/mapfile.csv
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json
>>
>

thanks
Ganapat
