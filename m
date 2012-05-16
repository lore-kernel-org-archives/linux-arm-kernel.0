From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 16 May 2012 16:06:39 +0100
Subject: [PATCH 2/8] arm: mach-armada: add source files
In-Reply-To: <1337072084-21967-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <4FB3C27F.1010906@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/12 09:54, Thomas Petazzoni wrote:


> diff --git a/arch/arm/mach-armada/common.h b/arch/arm/mach-armada/common.h
> new file mode 100644
> index 0000000..e453161
> --- /dev/null
> +++ b/arch/arm/mach-armada/common.h
> @@ -0,0 +1,27 @@
> +/*
> + * Core functions for Marvell Armada System On Chip
> + *
> + * Copyright (C) 2012 Marvell
> + *
> + * Lior Amsalem<alior@marvell.com>
> + * Gregory CLEMENT<gregory.clement@free-electrons.com>
> + * Thomas Petazzoni<thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef __ARCH_ARMADA_COMMON_H
> +#define __ARCH_ARMADA_COMMON_H
> +
> +#include<asm/exception.h>
> +
> +extern struct sys_timer armada_timer;
> +
> +void armada_map_io(void);
> +void armada_init_irq(void);
> +void armada_restart(char, const char *);
> +asmlinkage void __exception_irq_entry armada_handle_irq(struct pt_regs *regs);
> +
> +#endif

As a note, I don't think you need the `__exception_irq_entry` or the
`asmlinkage` on the declaration of armada_handle_irq, so you could
probably drop the include of <asm/exception.h> too.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
