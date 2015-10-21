From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 21 Oct 2015 09:50:17 +0100
Subject: [PATCHv4 23/24] arm64: Expose feature registers by emulating MRS
In-Reply-To: <1445261101-22344-24-git-send-email-suzuki.poulose@arm.com>
References: <1445261101-22344-1-git-send-email-suzuki.poulose@arm.com>
 <1445261101-22344-24-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151021085017.GF4801@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 02:25:00PM +0100, Suzuki K. Poulose wrote:
> This patch adds the hook for emulating MRS instruction to
> export the 'user visible' value of supported system registers.
> We emulate only the following id space for system registers:
> 	Op0=0, Op1=0, CRn=0.

[...]

> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 896a821..c44da31 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c

[...]

> @@ -908,3 +910,106 @@ void __init setup_cpu_features(void)
>  		pr_warn("L1_CACHE_BYTES smaller than the Cache Writeback Granule (%d < %d)\n",
>  			L1_CACHE_BYTES, cls);
>  }
> +
> +/*
> + * We emulate only the following system register space.
> + * 	Op0 = 0x3, CRn = 0x0, Op1 = 0x0, CRm = [0 - 7]

nit: ^ whitespace, no need to fix unless respinning the series

[...]

> +/*
> + * With CRm = 0, id should be one of :
> + *	MIDR_EL1
> + *	MPIDR_EL1
> + *  	REVIDR_EL1

nit: ^ whitespace

[...]

Cheers
---Dave
