From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 13 Jul 2016 09:11:46 -0600
Subject: [PATCH RESEND 2/2] perf tools: adding coresight etm PMU record
 capabilities
In-Reply-To: <578628CB.8020707@intel.com>
References: <1466182922-14426-1-git-send-email-mathieu.poirier@linaro.org>
 <1466182922-14426-3-git-send-email-mathieu.poirier@linaro.org>
 <578628CB.8020707@intel.com>
Message-ID: <CANLsYkx13a1cbGAvvt2PL8mPtOtB6FV_FUNPCDHtjenYBiHKww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 July 2016 at 05:40, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 17/06/16 20:02, Mathieu Poirier wrote:
>> Coresight ETMs are IP blocks used to perform HW assisted tracing
>> on a CPU core.  This patch introduce the required auxiliary API
>> functions allowing the perf core to interact with a tracer.
>>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> ---
>>  MAINTAINERS                         |   3 +
>>  tools/perf/arch/arm/util/Build      |   2 +-
>>  tools/perf/arch/arm/util/auxtrace.c |  54 ++++
>>  tools/perf/arch/arm/util/cs-etm.c   | 559 ++++++++++++++++++++++++++++++++++++
>>  tools/perf/arch/arm/util/cs-etm.h   |  23 ++
>>  tools/perf/arch/arm64/util/Build    |   4 +
>>  tools/perf/util/auxtrace.c          |   1 +
>>  tools/perf/util/auxtrace.h          |   1 +
>>  tools/perf/util/cs-etm.h            |  74 +++++
>>  9 files changed, 720 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/perf/arch/arm/util/auxtrace.c
>>  create mode 100644 tools/perf/arch/arm/util/cs-etm.c
>>  create mode 100644 tools/perf/arch/arm/util/cs-etm.h
>>  create mode 100644 tools/perf/util/cs-etm.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d3451007718b..4fa03b03bfc5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1086,6 +1086,9 @@ F:      Documentation/trace/coresight.txt
>>  F:   Documentation/devicetree/bindings/arm/coresight.txt
>>  F:   Documentation/ABI/testing/sysfs-bus-coresight-devices-*
>>  F:   tools/perf/arch/arm/util/pmu.c
>> +F:   tools/perf/arch/arm/util/auxtrace.c
>> +F:   tools/perf/arch/arm/util/cs_etm.c
>> +F:   tools/perf/arch/arm/util/cs_etm.h
>
> File names have changed from having '_' to '-'

Yes, I will change that.

> Also FWIW there is now tools/perf/util/cs-etm.h

Ok

>
> As last time, there is no decoder, which still begs the question: is there
> anything you can actually do with the perf.data file?

We are proceeding incrementally - this is only the first set in a
suite of upcoming submission.  The whole solution can be found here
[1] and the decoding library, called OpenCSD, here [2].  File
"HOWTO.md" in the latter details how to compile the components in
order to build a working environment.

>
> Otherwise:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>

Thanks for your time,
Mathieu

[1]. https://github.com/Linaro/OpenCSD/commits/perf-opencsd-4.7-rc4
[2]. https://github.com/Linaro/OpenCSD/tree/opencsd-0v003
