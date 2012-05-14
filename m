From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 14 May 2012 15:51:16 -0400 (EDT)
Subject: [PATCH] Removal of last remaining useless system.h includes
In-Reply-To: <20120514114503.GC10453@n2100.arm.linux.org.uk>
References: <20120514114503.GC10453@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1205141550340.1640@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 May 2012, Russell King - ARM Linux wrote:

> mach/system.h is no longer included by anything that matters.  Most of
> the includes have already gone, and we're left with just four platforms
> which still have them (for various reasons.)  Let's remove them as
> they're now unused.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
> This is more a reminder for those maintainers who still haven't responded
> to the work from about five months ago reworking the ARM restart support,
> and who need to do some work to get restart support working again for
> their platforms.
> 
>  arch/arm/mach-gemini/include/mach/system.h   |   23 -----------------------
>  arch/arm/mach-msm/board-sapphire.c           |    1 -
>  arch/arm/mach-msm/include/mach/system.h      |   19 -------------------
>  arch/arm/mach-msm/proc_comm.c                |    1 -
>  arch/arm/mach-msm/smd.c                      |    1 -
>  arch/arm/mach-shmobile/include/mach/system.h |   11 -----------
>  arch/arm/mach-vt8500/include/mach/system.h   |   13 -------------
>  7 files changed, 0 insertions(+), 69 deletions(-)
> 
> diff --git a/arch/arm/mach-gemini/include/mach/system.h b/arch/arm/mach-gemini/include/mach/system.h
> deleted file mode 100644
> index a33b5a1..0000000
> --- a/arch/arm/mach-gemini/include/mach/system.h
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -/*
> - *  Copyright (C) 2001-2006 Storlink, Corp.
> - *  Copyright (C) 2008-2009 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - */
> -#ifndef __MACH_SYSTEM_H
> -#define __MACH_SYSTEM_H
> -
> -#include <linux/io.h>
> -#include <mach/hardware.h>
> -#include <mach/global_reg.h>
> -
> -static inline void arch_reset(char mode, const char *cmd)
> -{
> -	__raw_writel(RESET_GLOBAL | RESET_CPU1,
> -		     IO_ADDRESS(GEMINI_GLOBAL_BASE) + GLOBAL_RESET);
> -}
> -
> -#endif /* __MACH_SYSTEM_H */
> diff --git a/arch/arm/mach-msm/board-sapphire.c b/arch/arm/mach-msm/board-sapphire.c
> index 4a8ea0d..1270fba 100644
> --- a/arch/arm/mach-msm/board-sapphire.c
> +++ b/arch/arm/mach-msm/board-sapphire.c
> @@ -27,7 +27,6 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
>  #include <asm/mach/flash.h>
> -#include <mach/system.h>
>  #include <mach/vreg.h>
>  #include <mach/board.h>
>  
> diff --git a/arch/arm/mach-msm/include/mach/system.h b/arch/arm/mach-msm/include/mach/system.h
> deleted file mode 100644
> index f5fb2ec..0000000
> --- a/arch/arm/mach-msm/include/mach/system.h
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -/* arch/arm/mach-msm/include/mach/system.h
> - *
> - * Copyright (C) 2007 Google, Inc.
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - */
> -
> -/* low level hardware reset hook -- for example, hitting the
> - * PSHOLD line on the PMIC to hard reset the system
> - */
> -extern void (*msm_hw_reset_hook)(void);
> diff --git a/arch/arm/mach-msm/proc_comm.c b/arch/arm/mach-msm/proc_comm.c
> index 9980dc7..8f1eecd 100644
> --- a/arch/arm/mach-msm/proc_comm.c
> +++ b/arch/arm/mach-msm/proc_comm.c
> @@ -19,7 +19,6 @@
>  #include <linux/io.h>
>  #include <linux/spinlock.h>
>  #include <mach/msm_iomap.h>
> -#include <mach/system.h>
>  
>  #include "proc_comm.h"
>  
> diff --git a/arch/arm/mach-msm/smd.c b/arch/arm/mach-msm/smd.c
> index 657be73..3db429d 100644
> --- a/arch/arm/mach-msm/smd.c
> +++ b/arch/arm/mach-msm/smd.c
> @@ -30,7 +30,6 @@
>  #include <linux/delay.h>
>  
>  #include <mach/msm_smd.h>
> -#include <mach/system.h>
>  
>  #include "smd_private.h"
>  #include "proc_comm.h"
> diff --git a/arch/arm/mach-shmobile/include/mach/system.h b/arch/arm/mach-shmobile/include/mach/system.h
> deleted file mode 100644
> index 540eaff..0000000
> --- a/arch/arm/mach-shmobile/include/mach/system.h
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -#ifndef __ASM_ARCH_SYSTEM_H
> -#define __ASM_ARCH_SYSTEM_H
> -
> -#include <asm/system_misc.h>
> -
> -static inline void arch_reset(char mode, const char *cmd)
> -{
> -	soft_restart(0);
> -}
> -
> -#endif
> diff --git a/arch/arm/mach-vt8500/include/mach/system.h b/arch/arm/mach-vt8500/include/mach/system.h
> deleted file mode 100644
> index 58fa801..0000000
> --- a/arch/arm/mach-vt8500/include/mach/system.h
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -/*
> - * arch/arm/mach-vt8500/include/mach/system.h
> - *
> - */
> -#include <asm/io.h>
> -
> -/* PM Software Reset request register */
> -#define VT8500_PMSR_VIRT	0xf8130060
> -
> -static inline void arch_reset(char mode, const char *cmd)
> -{
> -	writel(1, VT8500_PMSR_VIRT);
> -}
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
