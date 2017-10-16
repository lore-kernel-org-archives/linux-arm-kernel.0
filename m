From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 16 Oct 2017 11:17:37 +0100
Subject: [PATCH v3 04/13] arm64: alternatives: use tpidr_el2 on VHE hosts
In-Reply-To: <20170922182614.27885-5-james.morse@arm.com>
References: <20170922182614.27885-1-james.morse@arm.com>
 <20170922182614.27885-5-james.morse@arm.com>
Message-ID: <20171016101736.fkaikxflyc46zczf@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 22, 2017 at 07:26:05PM +0100, James Morse wrote:
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 29adab8138c3..8f2d0f7d193b 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -193,5 +193,6 @@ static inline void spin_lock_prefetch(const void *ptr)
>  
>  int cpu_enable_pan(void *__unused);
>  int cpu_enable_cache_maint_trap(void *__unused);
> +int cpu_copy_el2regs(void *__unused);
>  
>  #endif /* __ASM_PROCESSOR_H */
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index cd52d365d1f0..8e4c7da2b126 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
[...]
> +int cpu_copy_el2regs(void *__unused)

Can this be static? I couldn't find it used anywhere else apart from
cpufeature.c

-- 
Catalin
