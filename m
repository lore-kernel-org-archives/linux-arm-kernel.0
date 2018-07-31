From: gklkml16@gmail.com (Ganapatrao Kulkarni)
Date: Tue, 31 Jul 2018 20:40:51 +0530
Subject: [PATCH] perf vendor events arm64: Update ThunderX2 implementation
 defined pmu core events
In-Reply-To: <20180731142835.GC4909@kernel.org>
References: <20180731100251.23575-1-ganapatrao.kulkarni@cavium.com>
 <20180731142835.GC4909@kernel.org>
Message-ID: <CAKTKpr7ZLru2wvtarq01p6PqJKQLEhCFtoo=tw45Svh-V_vFag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaldo,

On Tue, Jul 31, 2018 at 7:58 PM, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
> Em Tue, Jul 31, 2018 at 03:32:51PM +0530, Ganapatrao Kulkarni escreveu:
>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>
> Can you please consider to provide an example of such counters being
> used, i.e. with a simple C synthetic test that causes these events to
> take place, then run it via 'perf stat' to show that indeed, they are
> being programmed and read correctly?
>
> Ideally for all of them, but if that becomes too burdensome, for a few
> of them?

It may be tedious for all, certainly I will provide the test
results/log for some of them(as many as possible).

>
> Thanks,
>
> - Arnaldo
>
>> ---
>>  .../arch/arm64/cavium/thunderx2/core-imp-def.json  | 87 +++++++++++++++++++++-
>>  1 file changed, 84 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
>> index bc03c06..752e47e 100644
>> --- a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
>> +++ b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
>> @@ -12,6 +12,21 @@
>>          "ArchStdEvent": "L1D_CACHE_REFILL_WR",
>>      },
>>      {
>> +        "ArchStdEvent": "L1D_CACHE_REFILL_INNER",
>> +    },
>> +    {
>> +        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER",
>> +    },
>> +    {
>> +        "ArchStdEvent": "L1D_CACHE_WB_VICTIM",
>> +    },
>> +    {
>> +        "ArchStdEvent": "L1D_CACHE_WB_CLEAN",
>> +    },
>> +    {
>> +        "ArchStdEvent": "L1D_CACHE_INVAL",
>> +    },
>> +    {
>>          "ArchStdEvent": "L1D_TLB_REFILL_RD",
>>      },
>>      {
>> @@ -24,9 +39,75 @@
>>          "ArchStdEvent": "L1D_TLB_WR",
>>      },
>>      {
>> +        "ArchStdEvent": "L2D_TLB_REFILL_RD",
>> +    },
>> +    {
>> +        "ArchStdEvent": "L2D_TLB_REFILL_WR",
>> +    },
>> +    {
>> +        "ArchStdEvent": "L2D_TLB_RD",
>> +    },
>> +    {
>> +        "ArchStdEvent": "L2D_TLB_WR",
>> +    },
>> +    {
>>          "ArchStdEvent": "BUS_ACCESS_RD",
>> -   },
>> -   {
>> +    },
>> +    {
>>          "ArchStdEvent": "BUS_ACCESS_WR",
>> -   }
>> +    },
>> +    {
>> +        "ArchStdEvent": "MEM_ACCESS_RD",
>> +    },
>> +    {
>> +        "ArchStdEvent": "MEM_ACCESS_WR",
>> +    },
>> +    {
>> +        "ArchStdEvent": "UNALIGNED_LD_SPEC",
>> +    },
>> +    {
>> +        "ArchStdEvent": "UNALIGNED_ST_SPEC",
>> +    },
>> +    {
>> +        "ArchStdEvent": "UNALIGNED_LDST_SPEC",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_UNDEF",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_SVC",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_PABORT",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_DABORT",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_IRQ",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_FIQ",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_SMC",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_HVC",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_TRAP_PABORT",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_TRAP_DABORT",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_TRAP_OTHER",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_TRAP_IRQ",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_TRAP_FIQ",
>> +    }
>>  ]
>> --
>> 2.9.4

thanks
Ganapat
