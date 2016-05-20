From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 May 2016 14:19:24 -0700
Subject: [PATCH] soc: qcom: provide mechanism for drivers to access L2
 registers
In-Reply-To: <1463771587-7438-1-git-send-email-nleeder@codeaurora.org>
References: <1463771587-7438-1-git-send-email-nleeder@codeaurora.org>
Message-ID: <573F7F5C.1050100@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2016 12:13 PM, Neil Leeder wrote:
> diff --git a/drivers/soc/qcom/l2-accessors.c b/drivers/soc/qcom/l2-accessors.c
> new file mode 100644
> index 0000000..fbb69bd
> --- /dev/null
> +++ b/drivers/soc/qcom/l2-accessors.c
> @@ -0,0 +1,66 @@
> +/*
> + * Copyright (c) 2014-2016 The Linux Foundation. All rights reserved.
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
> +#include <linux/spinlock.h>
> +#include <linux/module.h>

export.h instead?

> +#include <linux/soc/qcom/l2-accessors.h>
> +#include <asm/cputype.h>
> +#include <asm/sysreg.h>

Is there a patch to add sysreg.h to arch/arm? It would be nice to use
one l2 accessor API on arm64 and arm.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
