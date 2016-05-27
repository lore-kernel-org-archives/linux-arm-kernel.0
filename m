From: panand@redhat.com (Pratyush Anand)
Date: Fri, 27 May 2016 17:05:20 +0530
Subject: [PATCH kexec-tools 29/32] arm: add debug of reserved and coredump
 memory ranges
In-Reply-To: <E1axXUL-0004jm-W0@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXUL-0004jm-W0@e0050434b2927.dyn.arm.linux.org.uk>
Message-ID: <CAHB_Guqj8p07CM9mJTHDYDVC2s+6sLQn30JP8qBxOig8rV_RrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 3:53 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> Add debug of the reserved and coredump memory ranges for validation.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/arch/arm/crashdump-arm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
> index 25fdbe9..2dc8846 100644
> --- a/kexec/arch/arm/crashdump-arm.c
> +++ b/kexec/arch/arm/crashdump-arm.c
> @@ -158,6 +158,10 @@ static int crash_get_memory_ranges(void)
>                 return -1;
>         }
>
> +       dbgprint_mem_range("Reserved memory ranges",
> +                          crash_reserved_rgns.ranges,
> +                          crash_reserved_rgns.size);
> +
>         /*
>          * Exclude all reserved memory from the usable memory regions.
>          * We want to avoid dumping the crashkernel region itself.  Note
> @@ -179,6 +183,9 @@ static int crash_get_memory_ranges(void)
>          */
>         mem_regions_sort(&usablemem_rgns);
>
> +       dbgprint_mem_range("Coredump memory ranges",
> +                          usablemem_rgns.ranges, usablemem_rgns.size);
> +
>         return 0;
>  }
>
> --
> 1.9.1
>
