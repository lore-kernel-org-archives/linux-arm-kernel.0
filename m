From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 4 Mar 2014 10:23:10 -0800
Subject: [PATCH v2 01/11] base: power: Add generic OF-based power domain
 look-up
In-Reply-To: <1393862536-9842-2-git-send-email-tomasz.figa@gmail.com>
References: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
 <1393862536-9842-2-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20140304182310.GA9985@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03, Tomasz Figa wrote:
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index dc127e5..006b455 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -3,12 +3,16 @@
>   *
>   * Copyright (C) 2011 Rafael J. Wysocki <rjw@sisk.pl>, Renesas Electronics Corp.
>   *
> + * Support for Device Tree based power domain providers:
> + * Copyright (C) 2014 Tomasz Figa <tomasz.figa@gmail.com>
> + *
>   * This file is released under the GPLv2.
>   */
>  
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/io.h>
> +#include <linux/platform_device.h>

Is this still needed?

>  #include <linux/pm_runtime.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_qos.h>
[...]
> +
> +/*
> + * DEVICE<->DOMAIN BINDING USING DEVICE TREE LOOK-UP
> + *
> + * The code below registers a notifier for platform bus devices'
> + * BUS_NOTIFY_BIND_DRIVER events and tries to attach devices to their power
> + * domains by looking them up using Device Tree.
> + *
> + * Similarly in BUS_NOTIFY_UNBOUND_DRIVER the device is detached from its
> + * domain, since it no longer supports runtime PM without any driver bound
> + * to it.

This looks outdated.

> + *
> + * Both generic and legacy Samsung-specific DT bindings are supported to
> + * keep backwards compatibility with existing DTBs.
> + */
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
