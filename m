From: john.garry@huawei.com (John Garry)
Date: Tue, 28 Aug 2018 18:35:29 +0100
Subject: [PATCH] perf vendor events arm64: Add to core JSON events for eMAG
In-Reply-To: <20180823202250.30797-1-seanvk.dev@oregontracks.org>
References: <20180823202250.30797-1-seanvk.dev@oregontracks.org>
Message-ID: <574a7b6c-e9db-a1fb-7a0a-5bfc8dbe2b7b@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/08/2018 21:22, Sean V Kelley wrote:
> Adds the remainder of the supported ARMv8 recommended IMPLEMENTATION
> DEFINED events for the Ampere Computing eMAG file.
>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: William Cohen <wcohen@redhat.com>
> Cc: linux-arm-kernel at lists.infradead.org
>
> Signed-off-by: Sean V Kelley <seanvk.dev@oregontracks.org>
> ---
>  .../arch/arm64/ampere/emag/core-imp-def.json  | 150 +++++++++++++++++-
>  1 file changed, 144 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json
> index bc03c06c3918..d95202dbe2b2 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json
> @@ -9,7 +9,7 @@
>          "ArchStdEvent": "L1D_CACHE_REFILL_RD",
>      },
>      {
> -        "ArchStdEvent": "L1D_CACHE_REFILL_WR",

You seem to be removing event support here, which is not consistent with 
the commit log. Please explain.

> +        "ArchStdEvent": "L1D_CACHE_INVAL",
>      },
>      {
>          "ArchStdEvent": "L1D_TLB_REFILL_RD",
> @@ -18,15 +18,153 @@
>          "ArchStdEvent": "L1D_TLB_REFILL_WR",
>      },
>      {
> -        "ArchStdEvent": "L1D_TLB_RD",
> +        "ArchStdEvent": "L2D_CACHE_RD",
>      },
>      {
> -        "ArchStdEvent": "L1D_TLB_WR",
> +        "ArchStdEvent": "L2D_CACHE_WR",
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_REFILL_RD",
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_REFILL_WR",
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_WB_VICTIM",
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_WB_CLEAN",
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_INVAL",
>      },
>      {
>          "ArchStdEvent": "BUS_ACCESS_RD",
> -   },
> -   {
> +    },
> +    {
>          "ArchStdEvent": "BUS_ACCESS_WR",
> -   }
> +    },
> +    {
> +        "ArchStdEvent": "BUS_ACCESS_SHARED",
> +    },
> +    {
> +        "ArchStdEvent": "BUS_ACCESS_NOT_SHARED",
> +    },
> +    {
> +        "ArchStdEvent": "BUS_ACCESS_NORMAL",
> +    },
> +    {
> +        "ArchStdEvent": "BUS_ACCESS_PERIPH",
> +    },
> +    {
> +        "ArchStdEvent": "MEM_ACCESS_RD",
> +    },
> +    {
> +        "ArchStdEvent": "MEM_ACCESS_WR",
> +    },
> +    {
> +        "ArchStdEvent": "UNALIGNED_LD_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "UNALIGNED_ST_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "UNALIGNED_LDST_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "LDREX_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "STREX_PASS_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "STREX_FAIL_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "STREX_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "LD_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "ST_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "LDST_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "DP_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "VFP_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "PC_WRITE_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "CRYPTO_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "BR_IMMED_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "BR_RETURN_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "BR_INDIRECT_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "ISB_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "DSB_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "DMB_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_UNDEF",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_SVC",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_PABORT",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_DABORT",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_IRQ",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_FIQ",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_HVC",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_PABORT",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_DABORT",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_OTHER",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_IRQ",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_FIQ",
> +    },
> +    {
> +        "ArchStdEvent": "RC_LD_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "RC_ST_SPEC",
> +    },
>  ]
>
