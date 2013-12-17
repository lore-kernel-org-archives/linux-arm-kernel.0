From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 17 Dec 2013 12:08:32 +0000
Subject: [PATCH 2/4] arm64: Add hwcaps for crypto and CRC32 extensions.
In-Reply-To: <1387227878-30438-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1387227878-30438-1-git-send-email-ard.biesheuvel@linaro.org>
 <1387227878-30438-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20131217120831.GF32118@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 09:04:36PM +0000, Ard Biesheuvel wrote:
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 0bc5e4c..961c961 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -116,6 +116,7 @@ bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
>  static void __init setup_processor(void)
>  {
>  	struct cpu_info *cpu_info;
> +	u64 features, block;
>  
>  	/*
>  	 * locate processor in the list of supported processor
> @@ -136,6 +137,37 @@ static void __init setup_processor(void)
>  
>  	sprintf(init_utsname()->machine, ELF_PLATFORM);
>  	elf_hwcap = 0;
> +
> +	/*
> +	 * ID_AA64ISAR0_EL1 contains 4-bit wide signed feature blocks.
> +	 * The blocks we test below represent incremental functionality
> +	 * for non-negative values. Negative values are reserved.
> +	 */
> +	features = read_cpuid(ID_AA64ISAR0_EL1);

Have you built this?

-- 
Catalin
