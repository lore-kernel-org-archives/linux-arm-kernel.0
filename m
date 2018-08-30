From: seanvk.dev@oregontracks.org (Sean V Kelley)
Date: Wed, 29 Aug 2018 21:14:00 -0700
Subject: [PATCH] perf vendor events arm64: Add to core JSON events for eMAG
In-Reply-To: <c2432492-2a58-205b-a1a4-9cc10d833a3f@redhat.com>
References: <20180823202250.30797-1-seanvk.dev@oregontracks.org>
 <CAAbOPF1h1S1U2R-xxeYAH=CimZdYjOYUxaL9GDQ7yS5T6W7dpA@mail.gmail.com>
 <c2432492-2a58-205b-a1a4-9cc10d833a3f@redhat.com>
Message-ID: <A010BE97-6C96-4BE5-8CFE-83FC03B93784@oregontracks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, Aug 28, 2018 at 11:55 AM William Cohen <wcohen@redhat.com> wrote:
> On 08/28/2018 01:21 PM, Sean V Kelley wrote:
> > 
> > 
> > On Thu, Aug 23, 2018 at 1:23 PM Sean V Kelley <seanvk.dev at oregontracks.org <mailto:seanvk.dev@oregontracks.org>> wrote:
> > 
> >     Adds the remainder of the supported ARMv8 recommended IMPLEMENTATION
> >     DEFINED events for the Ampere Computing eMAG file.
> > 
> > 
> > Just checking in?  Perhaps John, William or Will could take a look if you have time? 
> > 
> > Thanks,
> > 
> > Sean
> 
> Hi,
> 
> Is there some public manual that lists the performance events for the Ampere eMAG?  As mentioned that some unavailable events were incorrectly added to the lists for the processor.  Having a reference for this would allow checking for those types of problems.
> 
Hi,

Yes, the intent is to get the public manual published and easily accessible from a link.  And I agree it's an essential reference for patches now and when the hardware is fully available.
 
> 
> One suggestions would be to split the events into multiple JSON files like the x86 and arm cortex 53 processors, so related events grouped into meaningful functional groups rather than just one long alphabetical list.

Thanks I will take a look.

Sean

 

Otherwise the patch looks reasonable.

-William Cohen
> 
> 
>  
> 
>     Cc: Arnaldo Carvalho de Melo <acme at kernel.org <mailto:acme@kernel.org>>
>     Cc: Alexander Shishkin <alexander.shishkin at linux.intel.com <mailto:alexander.shishkin@linux.intel.com>>
>     Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni at cavium.com <mailto:ganapatrao.kulkarni@cavium.com>>
>     Cc: Jiri Olsa <jolsa at redhat.com <mailto:jolsa@redhat.com>>
>     Cc: Namhyung Kim <namhyung at kernel.org <mailto:namhyung@kernel.org>>
>     Cc: Peter Zijlstra <peterz at infradead.org <mailto:peterz@infradead.org>>
>     Cc: Will Deacon <will.deacon at arm.com <mailto:will.deacon@arm.com>>
>     Cc: William Cohen <wcohen at redhat.com <mailto:wcohen@redhat.com>>
>     Cc: linux-arm-kernel at lists.infradead.org <mailto:linux-arm-kernel@lists.infradead.org>
> 
>     Signed-off-by: Sean V Kelley <seanvk.dev at oregontracks.org <mailto:seanvk.dev@oregontracks.org>>
>     ---
>      .../arch/arm64/ampere/emag/core-imp-def.json  | 150 +++++++++++++++++-
>      1 file changed, 144 insertions(+), 6 deletions(-)
> 
>     diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json
>     index bc03c06c3918..d95202dbe2b2 100644
>     --- a/tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json
>     +++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json
>     @@ -9,7 +9,7 @@
>              "ArchStdEvent": "L1D_CACHE_REFILL_RD",
>          },
>          {
>     -        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
>     +        "ArchStdEvent": "L1D_CACHE_INVAL",
>          },
>          {
>              "ArchStdEvent": "L1D_TLB_REFILL_RD",
>     @@ -18,15 +18,153 @@
>              "ArchStdEvent": "L1D_TLB_REFILL_WR",
>          },
>          {
>     -        "ArchStdEvent": "L1D_TLB_RD",
>     +        "ArchStdEvent": "L2D_CACHE_RD",
>          },
>          {
>     -        "ArchStdEvent": "L1D_TLB_WR",
>     +        "ArchStdEvent": "L2D_CACHE_WR",
>     +    },
>     +    {
>     +        "ArchStdEvent": "L2D_CACHE_REFILL_RD",
>     +    },
>     +    {
>     +        "ArchStdEvent": "L2D_CACHE_REFILL_WR",
>     +    },
>     +    {
>     +        "ArchStdEvent": "L2D_CACHE_WB_VICTIM",
>     +    },
>     +    {
>     +        "ArchStdEvent": "L2D_CACHE_WB_CLEAN",
>     +    },
>     +    {
>     +        "ArchStdEvent": "L2D_CACHE_INVAL",
>          },
>          {
>              "ArchStdEvent": "BUS_ACCESS_RD",
>     -   },
>     -   {
>     +    },
>     +    {
>              "ArchStdEvent": "BUS_ACCESS_WR",
>     -   }
>     +    },
>     +    {
>     +        "ArchStdEvent": "BUS_ACCESS_SHARED",
>     +    },
>     +    {
>     +        "ArchStdEvent": "BUS_ACCESS_NOT_SHARED",
>     +    },
>     +    {
>     +        "ArchStdEvent": "BUS_ACCESS_NORMAL",
>     +    },
>     +    {
>     +        "ArchStdEvent": "BUS_ACCESS_PERIPH",
>     +    },
>     +    {
>     +        "ArchStdEvent": "MEM_ACCESS_RD",
>     +    },
>     +    {
>     +        "ArchStdEvent": "MEM_ACCESS_WR",
>     +    },
>     +    {
>     +        "ArchStdEvent": "UNALIGNED_LD_SPEC",
>     +    },
>     +    {
>     +        "ArchStdEvent": "UNALIGNED_ST_SPEC",
>     +    },
>     +    {
>     +        "ArchStdEvent": "UNALIGNED_LDST_SPEC",
>     +    },
>     +    {
>     +        "ArchStdEvent": "LDREX_SPEC",
>     +    },
>     +    {
>     +        "ArchStdEvent": "STREX_PASS_SPEC",
>     +    },
>     +    {
>     +        "ArchStdEvent": "STREX_FAIL_SPEC",
>     +    },
>     +    {
>     +        "ArchStdEvent": "STREX_SPEC",
>     +    },
>     +    {
>     +        "ArchStdEvent": "LD_SPEC",
>     +    },
>     +    {
>     +        "ArchStdEvent": "ST_SPEC",
>     +    },
>     +    {
>     +        "ArchStdEvent": "LDST_SPEC",
>     +    },
>     +    {
>     +        "ArchStdEvent": "DP_SPEC",
>     +    },
>     +    {
>     +        "ArchStdEvent": "ASE_SPEC",
>     +    },
>     +    {
>     +        "ArchStdEvent": "VFP_SPEC",
>     +    },
>     +    {
>     +        "ArchStdEvent": "PC_WRITE_SPEC",
>     +    },
>     +    {
>     +        "ArchStdEvent": "CRYPTO_SPEC",
>     +    },
>     +    {
>     +        "ArchStdEvent": "BR_IMMED_SPEC",
>     +    },
>     +    {
>     +        "ArchStdEvent": "BR_RETURN_SPEC",
>     +    },
>     +    {
>     +        "ArchStdEvent": "BR_INDIRECT_SPEC",
>     +    },
>     +    {
>     +        "ArchStdEvent": "ISB_SPEC",
>     +    },
>     +    {
>     +        "ArchStdEvent": "DSB_SPEC",
>     +    },
>     +    {
>     +        "ArchStdEvent": "DMB_SPEC",
>     +    },
>     +    {
>     +        "ArchStdEvent": "EXC_UNDEF",
>     +    },
>     +    {
>     +        "ArchStdEvent": "EXC_SVC",
>     +    },
>     +    {
>     +        "ArchStdEvent": "EXC_PABORT",
>     +    },
>     +    {
>     +        "ArchStdEvent": "EXC_DABORT",
>     +    },
>     +    {
>     +        "ArchStdEvent": "EXC_IRQ",
>     +    },
>     +    {
>     +        "ArchStdEvent": "EXC_FIQ",
>     +    },
>     +    {
>     +        "ArchStdEvent": "EXC_HVC",
>     +    },
>     +    {
>     +        "ArchStdEvent": "EXC_TRAP_PABORT",
>     +    },
>     +    {
>     +        "ArchStdEvent": "EXC_TRAP_DABORT",
>     +    },
>     +    {
>     +        "ArchStdEvent": "EXC_TRAP_OTHER",
>     +    },
>     +    {
>     +        "ArchStdEvent": "EXC_TRAP_IRQ",
>     +    },
>     +    {
>     +        "ArchStdEvent": "EXC_TRAP_FIQ",
>     +    },
>     +    {
>     +        "ArchStdEvent": "RC_LD_SPEC",
>     +    },
>     +    {
>     +        "ArchStdEvent": "RC_ST_SPEC",
>     +    },
>      ]
>     -- 
>     2.17.1
> 
