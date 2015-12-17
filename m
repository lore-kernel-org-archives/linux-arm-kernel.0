From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Dec 2015 14:05:24 +0000
Subject: [PATCH v6 11/20] arm64:ilp32: support core dump generation for
 ILP32
In-Reply-To: <1450215766-14765-12-git-send-email-ynorov@caviumnetworks.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <1450215766-14765-12-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20151217140524.GE25232@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 12:42:37AM +0300, Yury Norov wrote:
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index 8786ca5..4e2e3c0 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
[...]
> +/*
> + * struct elf_prstatus is defined in include/uapi/linux/elfcore.h,
> + * and has different sise for supported ABIs
> + */
> +#define PRSTATUS_SIZE(S)		(is_a32_compat_task() ? 124 : (is_ilp32_compat_task() ? 352 : 392))

It's the *third* time I ask this: can you not use some sizeof instead of
the magic numbers?

-- 
Catalin
