From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 20 Apr 2016 14:34:56 +0100
Subject: [PATCH v5 3/7] arm64/perf: Changed events naming as per ARM ARM
In-Reply-To: <1461092062-7484-4-git-send-email-ashoks@broadcom.com>
References: <1461092062-7484-1-git-send-email-ashoks@broadcom.com>
 <1461092062-7484-4-git-send-email-ashoks@broadcom.com>
Message-ID: <20160420133456.GJ11453@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 11:54:18AM -0700, Ashok Kumar wrote:
> changed all the events name definition as per ARM ARM
> naming convention.

Please note which document you got these from (I assume the ARM ARM),
complete with the ARM document number (e.g. ARM DDI 0487A.i for revision
A.i). That gives us a consistent point of reference, which is helpful
for review and in case these names have cahnged (or change in future).

I've verified that the renaming of architected events now leaves them
named as per the ARM ARM. I see that we don't have the full list of
IMPDEF events, but that's a matter for another patch.

It might also be worth explicitly noting the correction of the l21/l2i
typo, as that looks a little odd otherwise.

>  /* ARMv8 Cortex-A53 specific event types. */
>  #define ARMV8_A53_PERFCTR_PREFETCH_LINEFILL			0xC2
>  
>  /* ARMv8 Cavium ThunderX specific event types. */
> -#define ARMV8_THUNDER_PERFCTR_L1_DCACHE_MISS_ST			0xE9
> -#define ARMV8_THUNDER_PERFCTR_L1_DCACHE_PREF_ACCESS		0xEA
> -#define ARMV8_THUNDER_PERFCTR_L1_DCACHE_PREF_MISS		0xEB
> -#define ARMV8_THUNDER_PERFCTR_L1_ICACHE_PREF_ACCESS		0xEC
> -#define ARMV8_THUNDER_PERFCTR_L1_ICACHE_PREF_MISS		0xED
> +#define ARMV8_THUNDER_PERFCTR_L1D_CACHE_MISS_ST			0xE9
> +#define ARMV8_THUNDER_PERFCTR_L1D_CACHE_PREF_ACCESS		0xEA
> +#define ARMV8_THUNDER_PERFCTR_L1D_CACHE_PREF_MISS		0xEB
> +#define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_ACCESS		0xEC
> +#define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_MISS		0xED

I'm not sure of the value of renaming these. I would think these should
match whatever is in the documentation for Cortex-A53 and ThunderX
respectively (and there's the obvious PREFETCH/PREF difference
remaining).

However, I'll leave that to Will.

Other than that, this looks good to me:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks for putting this together!

Mark.
