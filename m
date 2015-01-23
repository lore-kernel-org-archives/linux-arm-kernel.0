From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Jan 2015 17:16:29 +0000
Subject: [PATCHv3 0/3] Handle SETEND for AArch32 tasks
In-Reply-To: <1421844191-9263-1-git-send-email-suzuki.poulose@arm.com>
References: <1421844191-9263-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20150123171628.GG9557@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 12:43:08PM +0000, Suzuki K. Poulose wrote:
> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
> 
> This series add support for controlling the 'setend' instruction,
> which is deprecated in ARMv8, using the legacy instruction emulation
> framework, introduced by Punit Agrawal.
> 
> Changes since V2:
>  - Move ID_AA64MMFR0_EL1 bit definitions to asm/cputype.h
>  - Use mask/value pair for the features in ID_AA64MMFR0_EL1
>  - Better documentation about the hardware support limitaion under
>    Documentation and the Kconfig help
>  - Restore the original 'set_hw_mode' API, with wrappers to invoke
>    the set_hw_mode for on_each_cpu() variants.
>  - Print a warning when we detect an incompatibility for a registered
>    insn_emulation hook on a hotplugged CPU.
> 
> Changes since V1:
>  - Added a patch to keep track of the mixed endian support and register
>    the setend emulation only if all the active CPUs supports mixed endian.
>  - Fail hotplug operation if the CPU doesn't support a feature
>    required by insn_emulation.
>  - Signal handler runs in native endian

I queued these patches for 3.20 (and included Punit's suggestion as
well). They should appear in linux-next later today.

Cc'ing Greg H @ Google since they are the main users of the emulation
code. If you see any problem, please let us know.

Thanks.

-- 
Catalin
