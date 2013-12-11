From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 Dec 2013 14:10:19 +0000
Subject: [PATCH 1/6] arm64: Add asm/cpu.h
In-Reply-To: <1386767606-6391-1-git-send-email-broonie@kernel.org>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
Message-ID: <20131211141018.GC596@darko.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 01:13:21PM +0000, Mark Brown wrote:
> +struct cpuinfo_arm {
> +	struct cpu	cpu;
> +	u64		cpuid;
> +#ifdef CONFIG_SMP
> +	unsigned int	loops_per_jiffy;
> +#endif
> +};

How is this structure used? I haven't seen the ACPI code doing anything
with struct cpu (though I haven't dug deep enough). Also loops_per_jiffy
is useless, that's related to the delay loop based on the generic timer.

-- 
Catalin
