From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Jul 2018 17:00:49 +0100
Subject: [PATCH] arm64: add ARM64-specific support for flatmem
In-Reply-To: <20180706155627.23937-1-nkela@cisco.com>
References: <20180706155627.23937-1-nkela@cisco.com>
Message-ID: <20180706160049.GA27483@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please write a commit message for your patch.

On Fri, Jul 06, 2018 at 08:56:27AM -0700, Nikunj Kela wrote:
> Cc: xe-kernel at external.cisco.com
> Cc: Nikunj Kela <nkela@cisco.com>
> Signed-off-by: Nikunj Kela <nkela@cisco.com>
> ---
>  arch/arm64/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 42c090c..5e791f0 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -775,6 +775,10 @@ config ARCH_SPARSEMEM_DEFAULT
>  config ARCH_SELECT_MEMORY_MODEL
>  	def_bool ARCH_SPARSEMEM_ENABLE
>  
> +config ARCH_FLATMEM_ENABLE
> +	def_bool y
> +	depends on ARM64 && !NUMA

We don't need ARM64 here. I'm also not sure about the def_bool y, this seems
like a pretty niche thing to enable.

Will
