From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 07 Feb 2014 15:44:15 +0100
Subject: [PATCH 1/2] arm64: Add seccomp support
In-Reply-To: <1391767892-5395-2-git-send-email-takahiro.akashi@linaro.org>
References: <1391767892-5395-1-git-send-email-takahiro.akashi@linaro.org>
 <1391767892-5395-2-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <2659759.AA5HtBcWYl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 February 2014 19:11:31 AKASHI Takahiro wrote:
> diff --git a/arch/arm64/include/asm/seccomp.h b/arch/arm64/include/asm/seccomp.h
> new file mode 100644
> index 0000000..3482155
> --- /dev/null
> +++ b/arch/arm64/include/asm/seccomp.h
> @@ -0,0 +1,28 @@
> +/*
> + * arch/arm64/include/asm/seccomp.h
> + *
> + * Copyright (C) 2014 Linaro Limited
> + * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef _ASM_SECCOMP_H
> +#define _ASM_SECCOMP_H
> +
> +#include <asm/unistd.h>
> +
> +#ifdef CONFIG_COMPAT
> +#define __NR_seccomp_read_32           __NR_compat_read
> +#define __NR_seccomp_write_32          __NR_compat_write
> +#define __NR_seccomp_exit_32           __NR_compat_exit
> +#define __NR_seccomp_sigreturn_32      __NR_compat_sigreturn
> +#endif /* CONFIG_COMPAT */
> +
> +#define __NR_seccomp_read              __NR_read
> +#define __NR_seccomp_write             __NR_write
> +#define __NR_seccomp_exit              __NR_exit
> +#define __NR_seccomp_sigreturn         __NR_rt_sigreturn
> +
> +#endif /* _ASM_SECCOMP_H */
> 

This file looks extremely generic and can be shared by every
architecture other than MIPS for all I can tell.

Please add it to include/asm-generic instead of arch/arm64,
and add a line to arch/arm64/include/asm/Kbuild.

	Arnd
