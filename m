From: will.deacon@arm.com (Will Deacon)
Date: Thu, 13 Mar 2014 18:01:05 +0000
Subject: [PATCH] arm64: Add ARCH_HAS_SG_CHAIN
In-Reply-To: <1394732963-12174-1-git-send-email-lauraa@codeaurora.org>
References: <1394732963-12174-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140313180105.GG25472@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 05:49:23PM +0000, Laura Abbott wrote:
> It's useful to be able to chain scatterlists together for very large
> scatter allocations. Define ARCH_HAS_SG_CHAIN to let this happen.
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
>  arch/arm64/include/asm/scatterlist.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 arch/arm64/include/asm/scatterlist.h
> 
> diff --git a/arch/arm64/include/asm/scatterlist.h b/arch/arm64/include/asm/scatterlist.h
> new file mode 100644
> index 0000000..7b2602a
> --- /dev/null
> +++ b/arch/arm64/include/asm/scatterlist.h
> @@ -0,0 +1,21 @@
> +/*
> + * Copyright (c) 2014, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __ASM_SCATTERLIST_H
> +#define __ASM_SCATTERLIST_H
> +
> +#include <asm-generic/scatterlist.h>
> +
> +#define ARCH_HAS_SG_CHAIN

Hmm, I wonder if this should be a Kconfig option instead, to avoid the need
for the dummy header?

Will
