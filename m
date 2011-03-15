From: bryanh@codeaurora.org (Bryan Huntsman)
Date: Mon, 14 Mar 2011 18:35:48 -0700
Subject: [PATCH v4 2/3] [ARM] perfevents: Add support for Scorpion
	performance monitors
In-Reply-To: <1299691007-13470-1-git-send-email-sheetals@codeaurora.org>
References: <1299608733-28514-1-git-send-email-sheetals@codeaurora.org>
	<1299691007-13470-1-git-send-email-sheetals@codeaurora.org>
Message-ID: <4D7EC274.4020407@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/2011 09:16 AM, Sheetal Sahasrabudhe wrote:
> This commit adds support for performance monitors provided by
> Qualcomm Scorpion and ScorpionMP processor to perfevents.
> 
> Signed-off-by: Sheetal Sahasrabudhe <sheetals@codeaurora.org>
> Reviewed-by: Jean Pihet <j-pihet@ti.com>
> Reviewed-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/asm/perf_event.h |    2 +
>  arch/arm/kernel/perf_event.c      |   11 +
>  arch/arm/kernel/perf_event_msm.c  |  679 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 692 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/kernel/perf_event_msm.c
> 

...

> diff --git a/arch/arm/kernel/perf_event_msm.c b/arch/arm/kernel/perf_event_msm.c
> new file mode 100644
> index 0000000..4e42f27
> --- /dev/null
> +++ b/arch/arm/kernel/perf_event_msm.c
> @@ -0,0 +1,679 @@
> +/*
> + * Copyright (c) 2011, Code Aurora Forum. All rights reserved.
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
> +#include <asm/vfp.h>
> +#include <asm/system.h>
> +#include "../vfp/vfpinstr.h"

Sorry I didn't see this earlier.  Is there another way to get the info
you need that wouldn't use a relative include path?  If the info from
vfpinstr.h is now needed outside of the vfp directory, can it be moved
to a common header instead?  Thanks.

- Bryan


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
