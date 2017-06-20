From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 19 Jun 2017 18:31:30 -0700
Subject: [PATCH V1 3/9] clk: sprd: add gate clock support
In-Reply-To: <20170618015855.27738-4-chunyan.zhang@spreadtrum.com>
References: <20170618015855.27738-1-chunyan.zhang@spreadtrum.com>
 <20170618015855.27738-4-chunyan.zhang@spreadtrum.com>
Message-ID: <20170620013130.GI4493@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18, Chunyan Zhang wrote:
> diff --git a/drivers/clk/sprd/Makefile b/drivers/clk/sprd/Makefile
> index 8f802b2..333e2b2 100644
> --- a/drivers/clk/sprd/Makefile
> +++ b/drivers/clk/sprd/Makefile
> @@ -1,3 +1,3 @@
>  ifneq ($(CONFIG_OF),)
> -obj-y	+= ccu_common.o
> +obj-y	+= ccu_common.o ccu_gate.o

Can this be built as a module?

>  endif
> diff --git a/drivers/clk/sprd/ccu_gate.c b/drivers/clk/sprd/ccu_gate.c
> new file mode 100644
> index 0000000..3d27615
> --- /dev/null
> +++ b/drivers/clk/sprd/ccu_gate.c
> @@ -0,0 +1,102 @@
> +/*
> + * Spreadtrum gate clock driver
> + *
> + * Copyright (C) 2017 Spreadtrum, Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0
> + */
> +
> +#include <linux/clk-provider.h>
> +
> +#include "ccu_gate.h"
> +
> +DEFINE_SPINLOCK(gate_lock);

This variable name is not very unique for debugging lockdep
reports. Probably needs 'sprd' in the name.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
