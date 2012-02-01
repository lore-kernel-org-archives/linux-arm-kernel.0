From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 1 Feb 2012 10:52:29 -0500
Subject: [PATCH 2/6] drivers/base: add bus for System-on-Chip devices
In-Reply-To: <1328088226-29594-3-git-send-email-lee.jones@linaro.org>
References: <1328088226-29594-1-git-send-email-lee.jones@linaro.org>
 <1328088226-29594-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACb=_tQ7M0DpfZ0FX+yA-pG_7hEyN_DQPBNM+BStaXrV5GQaMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

I'm not able to give this a full testing, but it looks good to me,  I
have one really minor nit, but I'll look forward to integrating this
into picoxcell as soon as I get chance!

Jamie

On 1 February 2012 04:23, Lee Jones <lee.jones@linaro.org> wrote:
> diff --git a/drivers/base/soc.c b/drivers/base/soc.c
> new file mode 100644
> index 0000000..29abf6d
> --- /dev/null
> +++ b/drivers/base/soc.c
> @@ -0,0 +1,186 @@
> +/*
> + * Copyright (C) ST-Ericsson SA 2011
> + *
> + * Author: Lee Jones <lee.jones@linaro.org> for ST-Ericsson.
> + * License terms: ?GNU General Public License (GPL), version 2
> + */
> +
> +#include <linux/sysfs.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/stat.h>
> +#include <linux/slab.h>
> +#include <linux/idr.h>
> +#include <linux/spinlock.h>
> +#include <linux/sys_soc.h>
> +#include <linux/err.h>
> +
> +static struct ida soc_ida;
> +static spinlock_t soc_lock;

Use DEFINE_IDR() and DEFINE_SPINLOCK() rather than initialising them at runtime?

Jamie
