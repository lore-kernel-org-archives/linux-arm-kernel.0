From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Oct 2017 17:43:10 +0100
Subject: [PATCH v3 13/20] arm64: cpufeature: Enable IESB on exception
 entry/return for firmware-first
In-Reply-To: <20171005191812.5678-14-james.morse@arm.com>
References: <20171005191812.5678-1-james.morse@arm.com>
 <20171005191812.5678-14-james.morse@arm.com>
Message-ID: <20171018164309.ecwsk7qjmkyevos4@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 05, 2017 at 08:18:05PM +0100, James Morse wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b68f5e93baac..29df2a93688c 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -989,6 +989,21 @@ config ARM64_RAS_EXTN
>  	  and access the new registers if the system supports the extension.
>  	  Platform RAS features may additionally depend on firmware support.
>  
> +config ARM64_IESB
> +	bool "Enable Implicit Error Synchronization Barrier (IESB)"
> +	default y
> +	depends on ARM64_RAS_EXTN
> +	help
> +	  ARM v8.2 adds a feature to add implicit error synchronization
> +	  barriers whenever the CPU enters or exits a particular exception
> +	  level.
> +
> +	  On CPUs with this feature and the 'RAS Extensions' feature, we can
> +	  use this to contain detected (but not yet reported) errors to the
> +	  relevant exception level.
> +
> +	  The feature is detected at runtime, selecting this option will
> +	  enable these implicit barriers if the CPU supports the feature.
>  endmenu

What's the use-case for not having this option always enabled?

-- 
Catalin
