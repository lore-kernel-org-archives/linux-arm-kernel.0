From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Nov 2018 18:22:34 +0000
Subject: [PATCH V3 5/5] arm64: mm: Allow forcing all userspace addresses
 to 52-bit
In-Reply-To: <20181114133920.7134-6-steve.capper@arm.com>
References: <20181114133920.7134-1-steve.capper@arm.com>
 <20181114133920.7134-6-steve.capper@arm.com>
Message-ID: <20181123182233.GL3360@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2018 at 01:39:20PM +0000, Steve Capper wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index eab02d24f5d1..17d363e40c4d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1165,6 +1165,20 @@ config ARM64_CNP
>  	  at runtime, and does not affect PEs that do not implement
>  	  this feature.
>  
> +config ARM64_FORCE_52BIT
> +	bool "Force 52-bit virtual addresses for userspace"
> +	default n

No need for "default n"

> +	depends on ARM64_52BIT_VA && EXPERT

As long as it's for debug only and depends on EXPERT, it's fine by me.

-- 
Catalin
