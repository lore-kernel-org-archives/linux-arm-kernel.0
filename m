From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 1 Oct 2014 14:22:03 +0100
Subject: [PATCH 16/24] ARM64:ILP32: Support core dump for ILP32
In-Reply-To: <1409779158-30963-17-git-send-email-apinski@cavium.com>
References: <1409779158-30963-1-git-send-email-apinski@cavium.com>
 <1409779158-30963-17-git-send-email-apinski@cavium.com>
Message-ID: <20141001132202.GL12702@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 03, 2014 at 10:19:10PM +0100, Andrew Pinski wrote:
> +/*
> + * If ILP32 is turned on, we want to define the compat_elf_greg_t to the non compat
> + * one and define PR_REG_SIZE/PRSTATUS_SIZE/SET_PR_FPVALID so we pick up the correct
> + * ones for AARCH32.
> + */
> +#ifdef CONFIG_ARM64_ILP32
> +typedef elf_greg_t			compat_elf_greg_t;
> +typedef elf_gregset_t			compat_elf_gregset_t;
> +#define COMPAT_PR_REG_SIZE(S)		(is_a32_compat_task() ? 72 : 272)
> +#define COMPAT_PRSTATUS_SIZE(S)		(is_a32_compat_task() ? 124 : 352)

Could you not use some sizeof() here instead of these magic numbers?

-- 
Catalin
