From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 9 Jul 2015 17:31:56 +0100
Subject: [PATCH v4] arm64:Modify the dump mem for 64 bit addresses
In-Reply-To: <1436421634-34275-1-git-send-email-maninder1.s@samsung.com>
References: <1436421634-34275-1-git-send-email-maninder1.s@samsung.com>
Message-ID: <20150709163156.GF20855@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 09, 2015 at 11:30:34AM +0530, Maninder Singh wrote:
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 1ef2940..97e6208 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -52,11 +52,12 @@ int show_unhandled_signals = 1;
>   * Dump out the contents of some memory nicely...
>   */
>  static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
> -		     unsigned long top)
> +		     unsigned long top, bool wide)
>  {
>  	unsigned long first;
>  	mm_segment_t fs;
>  	int i;
> +	unsigned int width = wide ? 4 : 8;

I was thinking the other way around, i.e. wide means 64-bit, narrow
32-bit.

Anyway, just rename "wide" to "compat" here, it makes even more sense.
The rest of the patch looks fine:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Will can pick it up for 4.3.

Thanks.

-- 
Catalin
