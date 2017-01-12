From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Jan 2017 15:33:15 +0000
Subject: [PATCH] arm64: errata: Provide macro for major and minor cpu
 revisions
In-Reply-To: <20170111121143.9586-1-rrichter@cavium.com>
References: <20170111121143.9586-1-rrichter@cavium.com>
Message-ID: <20170112153315.GC13843@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 01:11:42PM +0100, Robert Richter wrote:
> Definition of cpu ranges are hard to read if the cpu variant is not
> zero. Provide MIDR_CPU_FULL_REV() macro to describe the full hardware
> revision of a cpu including variant and (minor) revision.
> 
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  arch/arm64/include/asm/cputype.h |  3 +++
>  arch/arm64/kernel/cpu_errata.c   | 15 +++++++++------
>  arch/arm64/kernel/cpufeature.c   |  8 +++-----
>  3 files changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index 26a68ddb11c1..983e59cbdd54 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -56,6 +56,9 @@
>  	(0xf			<< MIDR_ARCHITECTURE_SHIFT) | \
>  	((partnum)		<< MIDR_PARTNUM_SHIFT))
>  
> +#define MIDR_CPU_FULL_REV(var, rev) \
> +	(((var)	<< MIDR_VARIANT_SHIFT) | (rev))

Minor nit, but could you rename this to MIDR_CPU_VAR_REV instead please?
The revision field *is* the bottom 4 bits, so "full" rev doesn't really
make a lot of sense.

If you repost with that change, I'll pick it up for 4.11.

Thanks,

Will
