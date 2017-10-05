From: digetx@gmail.com (Dmitry Osipenko)
Date: Thu, 5 Oct 2017 18:53:43 +0300
Subject: [PATCH 1/9] ARM: enable secure platform-only erratas
In-Reply-To: <77ce738c15b992a92bee3a18e5468342fb2dc5ab.1500510157.git.mirq-linux@rere.qmqm.pl>
References: <cover.1500510157.git.mirq-linux@rere.qmqm.pl>
 <77ce738c15b992a92bee3a18e5468342fb2dc5ab.1500510157.git.mirq-linux@rere.qmqm.pl>
Message-ID: <3975c5de-9408-2e5b-51f3-9e4be5951ba0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.07.2017 03:29, Micha? Miros?aw wrote:
> Allow secure-only erratas to be used in multiarch kernel.
> 
> Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
> ---
>  arch/arm/Kconfig | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a208bfe367b5..a1eff866550b 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -696,6 +696,14 @@ config ARCH_MULTI_CPU_AUTO
>  
>  endmenu
>  
> +config ARCH_ASSUME_SECURE_PLATFORM

What about ARCH_SECURE_PLATFORM?

> +	bool "Enable ERRATAs using secure-only registers"
> +	default !ARCH_MULTIPLATFORM
> +	help
> +	  Allow erratas that need access to secure-only registers.
> +
> +	  Beware: Resulting kernel won't boot on a CPU in non-Secure mode.
> +
>  config ARCH_VIRT
>  	bool "Dummy Virtual Machine"
>  	depends on ARCH_MULTI_V7
> @@ -984,7 +992,7 @@ config ARM_ERRATA_430973
>  config ARM_ERRATA_458693
>  	bool "ARM errata: Processor deadlock when a false hazard is created"
>  	depends on CPU_V7
> -	depends on !ARCH_MULTIPLATFORM
> +	depends on ARCH_ASSUME_SECURE_PLATFORM
>  	help
>  	  This option enables the workaround for the 458693 Cortex-A8 (r2p0)
>  	  erratum. For very specific sequences of memory operations, it is
> @@ -998,7 +1006,7 @@ config ARM_ERRATA_458693
>  config ARM_ERRATA_460075
>  	bool "ARM errata: Data written to the L2 cache can be overwritten with stale data"
>  	depends on CPU_V7
> -	depends on !ARCH_MULTIPLATFORM
> +	depends on ARCH_ASSUME_SECURE_PLATFORM
>  	help
>  	  This option enables the workaround for the 460075 Cortex-A8 (r2p0)
>  	  erratum. Any asynchronous access to the L2 cache may encounter a
> @@ -1011,7 +1019,7 @@ config ARM_ERRATA_460075
>  config ARM_ERRATA_742230
>  	bool "ARM errata: DMB operation may be faulty"
>  	depends on CPU_V7 && SMP
> -	depends on !ARCH_MULTIPLATFORM
> +	depends on ARCH_ASSUME_SECURE_PLATFORM
>  	help
>  	  This option enables the workaround for the 742230 Cortex-A9
>  	  (r1p0..r2p2) erratum. Under rare circumstances, a DMB instruction
> @@ -1024,7 +1032,7 @@ config ARM_ERRATA_742230
>  config ARM_ERRATA_742231
>  	bool "ARM errata: Incorrect hazard handling in the SCU may lead to data corruption"
>  	depends on CPU_V7 && SMP
> -	depends on !ARCH_MULTIPLATFORM
> +	depends on ARCH_ASSUME_SECURE_PLATFORM
>  	help
>  	  This option enables the workaround for the 742231 Cortex-A9
>  	  (r2p0..r2p2) erratum. Under certain conditions, specific to the
> @@ -1062,7 +1070,7 @@ config ARM_ERRATA_720789
>  config ARM_ERRATA_743622
>  	bool "ARM errata: Faulty hazard checking in the Store Buffer may lead to data corruption"
>  	depends on CPU_V7
> -	depends on !ARCH_MULTIPLATFORM
> +	depends on ARCH_ASSUME_SECURE_PLATFORM
>  	help
>  	  This option enables the workaround for the 743622 Cortex-A9
>  	  (r2p*) erratum. Under very rare conditions, a faulty
> @@ -1076,7 +1084,7 @@ config ARM_ERRATA_743622
>  config ARM_ERRATA_751472
>  	bool "ARM errata: Interrupted ICIALLUIS may prevent completion of broadcasted operation"
>  	depends on CPU_V7
> -	depends on !ARCH_MULTIPLATFORM
> +	depends on ARCH_ASSUME_SECURE_PLATFORM
>  	help
>  	  This option enables the workaround for the 751472 Cortex-A9 (prior
>  	  to r3p0) erratum. An interrupted ICIALLUIS operation may prevent the
> 
