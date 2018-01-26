From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 26 Jan 2018 18:10:23 +0000
Subject: [PATCH 03/14] arm/arm64: KVM: Consolidate the PSCI include files
In-Reply-To: <20180126142847.31240-4-marc.zyngier@arm.com>
References: <20180126142847.31240-1-marc.zyngier@arm.com>
 <20180126142847.31240-4-marc.zyngier@arm.com>
Message-ID: <94c9a057-cb41-a92a-aaca-8b8e95676a32@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/01/18 14:28, Marc Zyngier wrote:
> As we're about to update the PSCI support, and because I'm lazy,
> let's move the PSCI include file to include/kvm so that both
> ARM architectures can find it.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/psci.h                        | 25 ----------------------
>  arch/arm/kvm/handle_exit.c                         |  2 +-
>  arch/arm64/kvm/handle_exit.c                       |  3 ++-
>  .../asm/kvm_psci.h => include/kvm/arm_psci.h       |  6 +++---
>  virt/kvm/arm/arm.c                                 |  2 +-
>  virt/kvm/arm/psci.c                                |  3 ++-
>  6 files changed, 9 insertions(+), 32 deletions(-)
>  delete mode 100644 arch/arm/include/asm/psci.h
>  rename arch/arm64/include/asm/kvm_psci.h => include/kvm/arm_psci.h (89%)
> 
> diff --git a/arch/arm/include/asm/psci.h b/arch/arm/include/asm/psci.h
> deleted file mode 100644
> index e1b825dfab23..000000000000
> --- a/arch/arm/include/asm/psci.h
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -/*
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * Copyright (C) 2012 ARM Limited
> - */
> -
> -#ifndef __ASM_ARM_PSCI_H
> -#define __ASM_ARM_PSCI_H
> -
> -extern const struct smp_operations psci_smp_ops;
> -
> -#if defined(CONFIG_SMP) && defined(CONFIG_ARM_PSCI)
> -bool psci_smp_available(void);
> -#else
> -static inline bool psci_smp_available(void) { return false; }
> -#endif
> -
> -#endif /* __ASM_ARM_PSCI_H */

Doh. I deleted the wrong file. That was supposed to be kvm_psci.h, and
not psci.h. Not sure how I managed that one...

	M.
-- 
Jazz is not dead. It just smells funny...
