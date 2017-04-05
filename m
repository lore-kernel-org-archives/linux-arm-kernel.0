From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Wed, 5 Apr 2017 14:42:39 +0530
Subject: [PATCH 3/3] perf tool, arm64, thunderx2: Add implementation
 defined events for ThunderX2
In-Reply-To: <20170404122828.GB8551@leverpostej>
References: <1491291403-29893-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <1491291403-29893-4-git-send-email-ganapatrao.kulkarni@cavium.com>
 <20170404122828.GB8551@leverpostej>
Message-ID: <CAFpQJXWTQ=gX63NHPoUST0oU9cP4xo+2fdr-p7ifhvJ6x-ih+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 4, 2017 at 5:58 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Apr 04, 2017 at 01:06:43PM +0530, Ganapatrao Kulkarni wrote:
>> This is not a full event list, but a short list of useful events.
>>
>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>> ---
>>  tools/perf/pmu-events/arch/arm64/mapfile.csv       |  2 +
>>  .../arm64/thunderx2/implementation-defined.json    | 72 ++++++++++++++++++++++
>>  2 files changed, 74 insertions(+)
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/mapfile.csv
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json
>>
>> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
>> new file mode 100644
>> index 0000000..ba30e43
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
>> @@ -0,0 +1,2 @@
>> +Family-model,Version,Filename,EventType
>> +0x00000000420f5161,v1,thunderx2,core
>> diff --git a/tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json b/tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json
>> new file mode 100644
>> index 0000000..360e084
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json
>> @@ -0,0 +1,72 @@
>> +[
>> +    {
>> +        "PublicDescription": "Attributable Level 1 data cache access, read",
>> +        "EventCode": "0x40",
>> +        "EventName": "l1d_cache_access_read",
>> +        "BriefDescription": "l1d cache access, read",
>> +     "CPU" :"armv8_pmuv3_0"
>
> Please let's not hard-code the name like this. Surely we can get rid of this?
>
> The kernel doesn't currently name PMUs as armv8_pmuv3_*, and as that can
> differ across DT/ACPI and in big.LITTLE, I don't think it makes sense to
> try to rely one particular string regardless.

This string/name is fixed for a platform. having name here is essential to
know which devices among pmu (armv8_pmuv3_0, breakpoint, software)
devices, these jevents to be added.
also this json file is specific to a arch/soc/board, it is not a
generic file to be common.


>
> Thanks,
> Mark.

thanks
Ganapat
