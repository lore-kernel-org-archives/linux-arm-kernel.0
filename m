From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Oct 2017 15:23:16 +0100
Subject: [PATCH v3 01/20] arm64: explicitly mask all exceptions
In-Reply-To: <20171005191812.5678-2-james.morse@arm.com>
References: <20171005191812.5678-1-james.morse@arm.com>
 <20171005191812.5678-2-james.morse@arm.com>
Message-ID: <20171018142315.vt44zeuke5po3tf7@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 05, 2017 at 08:17:53PM +0100, James Morse wrote:
> diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
> new file mode 100644
> index 000000000000..fb40da8e1457
> --- /dev/null
> +++ b/arch/arm64/include/asm/daifflags.h
> @@ -0,0 +1,59 @@
> +/*
> + * Copyright (C) 2017 ARM Ltd.
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
> +#ifndef __ASM_DAIFFLAGS_H
> +#define __ASM_DAIFFLAGS_H
> +
> +#include <asm/irqflags.h>
> +#include <linux/irqflags.h>

Nitpick: linux/irqflags.h already includes asm/irqflags.h.

We currently have local_dbg_save in asm/irqflags.h. Shall we keep all of
them in the same file (either asm/irqflags.h or the new asm/daifflags.h;
slight preference for irqflags.h unless you are worried about drivers
abusing these).

-- 
Catalin
