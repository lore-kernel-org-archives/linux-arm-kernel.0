From: panand@redhat.com (Pratyush Anand)
Date: Fri, 27 May 2016 16:58:36 +0530
Subject: [PATCH kexec-tools 19/32] arm: add memory ranges debug
In-Reply-To: <E1axXTV-0004in-Sw@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXTV-0004in-Sw@e0050434b2927.dyn.arm.linux.org.uk>
Message-ID: <CAHB_GuqhPgA37LoWn48Oj6vNgQP=enCNUUp-bF1sgk8uHvc-pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 3:52 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> Add the call to dbgprint_mem_range() into the ARM version of
> get_memory_ranges().
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/arch/arm/kexec-arm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kexec/arch/arm/kexec-arm.c b/kexec/arch/arm/kexec-arm.c
> index e47fc00..eeb27b4 100644
> --- a/kexec/arch/arm/kexec-arm.c
> +++ b/kexec/arch/arm/kexec-arm.c
> @@ -70,6 +70,9 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
>         fclose(fp);
>         *range = memory_range;
>         *ranges = memory_ranges;
> +
> +       dbgprint_mem_range("MEMORY RANGES", *range, *ranges);
> +
>         return 0;
>  }
>
> --
> 1.9.1
>
