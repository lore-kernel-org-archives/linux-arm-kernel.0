From: john.garry@huawei.com (John Garry)
Date: Thu, 24 Aug 2017 12:08:47 +0100
Subject: [PATCH v5 0/4] Add support for ThunderX2 pmu events using json
 files
In-Reply-To: <CAKTKpr6KB3VQ0bg-nA02T2-o9D1WbqS9UAinCN7YYwVd=MhyWg@mail.gmail.com>
References: <20170816071048.26087-1-ganapatrao.kulkarni@cavium.com>
 <CAKTKpr79hBBGfkVnKS+XsSOAwR9G1=F04OH0UBE3J8EX_w3L5A@mail.gmail.com>
 <4900f29c-aea5-9792-ee4b-adbf942eb361@huawei.com>
 <CAKTKpr6KB3VQ0bg-nA02T2-o9D1WbqS9UAinCN7YYwVd=MhyWg@mail.gmail.com>
Message-ID: <42ca65f2-35bf-4ea4-47ec-9e19ac954466@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/08/2017 08:23, Ganapatrao Kulkarni wrote:
> Hi John,
>
> On Wed, Aug 23, 2017 at 2:52 PM, John Garry <john.garry@huawei.com> wrote:
>> On 22/08/2017 05:21, Ganapatrao Kulkarni wrote:
>>>
>>> Hi Arnaldo, Will,
>>>
>>> are there any comments on this series?
>>>
>>
>> Hi Ganapatrao,
>>
>> Is it possible to have vendor sub-folder in tools/perf/pmu-events/arch/arm64
>> folder (like arm64 device tree files)? We (HiSilicon) want to add support
>> for our hip08 SoC, and I don't think "hip08" or "<internal code name for
>> core>" are good arch sub-folder names.
>
> at present the directory structure is in-line with as done for x86 and powerpc.
> there can be separate patchset to have directory hierarchy as
> suggested by you, if every one agrees on it!

Fine.

BTW, Shaokun has a json file for our hip08 platform waiting, based on 
this current patchset. We can send it now if anyone wants to see another 
arm64 json.

Much appreciated,
John

>
>>
>> I am not sure if this way discussed before, but the changelog does not
>> mention it. And I think that we had the same location for thunderx2 in v1
>> series.
>>
>> We should also consider that in theory the events could change per SoC using
>> the same custom ARMv8 custom implementation.
>>
>> Thanks,
>> John
>>
>>>
>>> On Wed, Aug 16, 2017 at 12:40 PM, Ganapatrao Kulkarni
>>> <ganapatrao.kulkarni@cavium.com> wrote:
>>>>
>>>> Extending json/jevent framework for parsing arm64 event files.
>>>> Adding jevents for ThunderX2 implementation defined PMU events.
>>>>
>>>> v5:
>>>>    - Addressed comments from Arnaldo.
>>>>    - Rebased to 4.13-rc5
>>>>
>>>> v4:
>>>>    - Rebased to 4.13-rc1
>>>>
>>>> v3:
>>>>    - Addressed comments from Will Deacon and Jayachandran C.
>>>>    - Rebased to 4.12-rc1
>>>>
>>>> v2:
>>>>    - Updated as per Mark Rutland's suggestions.
>>>>    - Added provision for get_cpuid_str to get cpu id string
>>>>      from associated cpus of pmu core device.
>>>>
>>>> v1: Initial patchset.
>>>>
>>>> Ganapatrao Kulkarni (4):
>>>>   perf utils: passing pmu as a parameter to function get_cpuid_str
>>>>   perf tools arm64: Add support for get_cpuid_str function.
>>>>   perf utils: Add helper function is_pmu_core to detect PMU CORE devices
>>>>   perf vendor events arm64: Add ThunderX2 implementation defined pmu
>>>>     core events
>>>>
>>>>  tools/perf/arch/arm64/util/Build                   |  1 +
>>>>  tools/perf/arch/arm64/util/header.c                | 61
>>>> +++++++++++++++++++++
>>>>  tools/perf/arch/powerpc/util/header.c              |  2 +-
>>>>  tools/perf/arch/x86/util/header.c                  |  2 +-
>>>>  tools/perf/pmu-events/arch/arm64/mapfile.csv       | 15 ++++++
>>>>  .../arm64/thunderx2/implementation-defined.json    | 62
>>>> ++++++++++++++++++++++
>>>>  tools/perf/util/header.h                           |  3 +-
>>>>  tools/perf/util/pmu.c                              | 53
>>>> +++++++++++++++---
>>>>  8 files changed, 188 insertions(+), 11 deletions(-)
>>>>  create mode 100644 tools/perf/arch/arm64/util/header.c
>>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/mapfile.csv
>>>>  create mode 100644
>>>> tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json
>>>>
>>>> --
>>>> 2.9.4
>>>>
>>>
>>> thanks
>>> Ganapat
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>>> .
>>>
>>
>>
>
> thanks
> Ganapat
>
> .
>
