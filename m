From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 23 Nov 2015 10:19:45 +0000
Subject: [PATCH 1/2] arch: consolidate CONFIG_STRICT_DEVM in
 lib/Kconfig.debug
In-Reply-To: <20151122035702.9313.52457.stgit@dwillia2-desk3.jf.intel.com>
References: <20151122035702.9313.52457.stgit@dwillia2-desk3.jf.intel.com>
Message-ID: <20151123101944.GA32300@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 21, 2015 at 07:57:02PM -0800, Dan Williams wrote:
> diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
> index 04fb73b973f1..e13c4bf84d9e 100644
> --- a/arch/arm64/Kconfig.debug
> +++ b/arch/arm64/Kconfig.debug
> @@ -14,20 +14,6 @@ config ARM64_PTDUMP
>  	  kernel.
>  	  If in doubt, say "N"
>  
> -config STRICT_DEVMEM
> -	bool "Filter access to /dev/mem"
> -	depends on MMU
> -	help
> -	  If this option is disabled, you allow userspace (root) access to all
> -	  of memory, including kernel and userspace memory. Accidental
> -	  access to this is obviously disastrous, but specific access can
> -	  be used by people debugging the kernel.
> -
> -	  If this option is switched on, the /dev/mem file only allows
> -	  userspace access to memory mapped peripherals.
> -
> -	  If in doubt, say Y.
> -
>  config PID_IN_CONTEXTIDR
>  	bool "Write the current PID to the CONTEXTIDR register"
>  	help

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
