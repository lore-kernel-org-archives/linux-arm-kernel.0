From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Aug 2012 13:56:05 +0000
Subject: [PATCH v2 08/31] arm64: CPU support
In-Reply-To: <1344966752-16102-9-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-9-git-send-email-catalin.marinas@arm.com>
Message-ID: <201208151356.05416.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 August 2012, Catalin Marinas wrote:

> diff --git a/arch/arm64/include/asm/procinfo.h b/arch/arm64/include/asm/procinfo.h
> new file mode 100644
> index 0000000..81fece9
> --- /dev/null
> +++ b/arch/arm64/include/asm/procinfo.h
> @@ -0,0 +1,44 @@
> +/*
> + * Based on arch/arm/include/asm/procinfo.h
> + *
> + * Copyright (C) 1996-1999 Russell King
> + * Copyright (C) 2012 ARM Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#ifndef __ASM_PROCINFO_H
> +#define __ASM_PROCINFO_H
> +
> +#ifdef __KERNEL__
> +
> +/*
> + * Note!  struct processor is always defined if we're
> + * using MULTI_CPU, otherwise this entry is unused,
> + * but still exists.
> + *
> + * NOTE! The following structure is defined by assembly
> + * language, NOT C code.  For more information, check:
> + *  arch/arm/mm/proc-*.S and arch/arm/kernel/head.S
> + */
> +struct proc_info_list {
> +	unsigned int		cpu_val;
> +	unsigned int		cpu_mask;
> +	unsigned long		__cpu_flush;		/* used by head.S */
> +	const char		*cpu_name;
> +};
> +
> +#else	/* __KERNEL__ */
> +#include <asm/elf.h>
> +#warning "Please include asm/elf.h instead"
> +#endif	/* __KERNEL__ */
> +#endif

I think you forgot to remove this file when you removed MULTI_CPU.

	Arnd
