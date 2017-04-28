From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Fri, 28 Apr 2017 14:49:49 +0530
Subject: [PATCH v2 1/4] perf utils: passing pmu as a parameter to function
 get_cpuid_str
In-Reply-To: <20170428090808.GA84977@localhost>
References: <1493355227-31492-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <1493355227-31492-2-git-send-email-ganapatrao.kulkarni@cavium.com>
 <20170428090808.GA84977@localhost>
Message-ID: <CAFpQJXV_RTsdHwVF76EGcANYqU+oeuTQfx0oX0LtOwVe_s=NjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 28, 2017 at 2:38 PM, Jayachandran C
<jnair@caviumnetworks.com> wrote:
> On Fri, Apr 28, 2017 at 10:23:44AM +0530, Ganapatrao Kulkarni wrote:
>> cpuid string will not be same on all CPUs on heterogeneous
>> platforms like ARM's big.LITTLE, adding provision(using pmu->cpus)
>> to find cpuid string from associated CPUs of PMU CORE device.
>>
>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>> ---
>>  tools/perf/arch/powerpc/util/header.c |  3 ++-
>>  tools/perf/arch/x86/util/header.c     |  4 +++-
>>  tools/perf/util/header.h              |  3 ++-
>>  tools/perf/util/pmu.c                 | 10 ++++++----
>>  4 files changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
>> index 9aaa6f5..9a70cc1 100644
>> --- a/tools/perf/arch/powerpc/util/header.c
>> +++ b/tools/perf/arch/powerpc/util/header.c
>> @@ -34,10 +34,11 @@
>>  }
>>
>>  char *
>> -get_cpuid_str(void)
>> +get_cpuid_str(struct perf_pmu *pmu)
>>  {
>>       char *bufp;
>>
>> +     do { if (pmu) {} } while (0);
>
> If this is to avoid warnings, can you use __maybe_unused here?

thanks, i will do.
>
> JC.

thanks
Ganapat
