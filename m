From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Jul 2018 18:06:17 +0100
Subject: [PATCH v2] arm64: add ARM64-specific support for flatmem
In-Reply-To: <20180706170215.56116-1-nkela@cisco.com>
References: <20180706170215.56116-1-nkela@cisco.com>
Message-ID: <20180706170617.GB4961@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2018 at 10:02:15AM -0700, Nikunj Kela wrote:
> Flatmem is useful in reducing kernel memory usage.
> One usecase is in kdump kernel. We are able to save
> ~14M by moving to flatmem scheme.
> 
> Cc: xe-kernel at external.cisco.com
> Cc: Nikunj Kela <nkela@cisco.com>
> Signed-off-by: Nikunj Kela <nkela@cisco.com>
> ---
>  arch/arm64/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 42c090c..96ab9a7 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -775,6 +775,10 @@ config ARCH_SPARSEMEM_DEFAULT
>  config ARCH_SELECT_MEMORY_MODEL
>  	def_bool ARCH_SPARSEMEM_ENABLE
>  
> +config ARCH_FLATMEM_ENABLE
> +	def_bool y
> +	depends on !NUMA

I still don't understand what this has to do with NUMA. SPARSEMEM is still
going to be what you want on a non-NUMA system with large holes in the
physical memory map, no?

Will
