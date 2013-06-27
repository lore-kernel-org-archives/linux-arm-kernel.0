From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 27 Jun 2013 10:25:14 -0700
Subject: [PATCH 4/8] ARM: OMAP: move cpuidle drivers to drivers/cpuidle/
In-Reply-To: <20130627080653.GH5523@atomide.com> (Tony Lindgren's message of
 "Thu, 27 Jun 2013 01:06:54 -0700")
References: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
 <1372241747-21083-5-git-send-email-b.zolnierkie@samsung.com>
 <20130627080653.GH5523@atomide.com>
Message-ID: <878v1vqxdx.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> [130626 12:25]:
>> While at it:
>> - remove file path from comment
>> - fix whitespace issues
>> 
>> Compile tested only.
> ...
>
>> --- /dev/null
>> +++ b/drivers/cpuidle/cpuidle-omap34xx.c
>> @@ -0,0 +1,342 @@
>> +/*
>> + * OMAP3 CPU IDLE Routines
>> + *
>> + * Copyright (C) 2008 Texas Instruments, Inc.
>> + * Rajendra Nayak <rnayak@ti.com>
>> + *
>> + * Copyright (C) 2007 Texas Instruments, Inc.
>> + * Karthik Dasu <karthik-dp@ti.com>
>> + *
>> + * Copyright (C) 2006 Nokia Corporation
>> + * Tony Lindgren <tony@atomide.com>
>> + *
>> + * Copyright (C) 2005 Texas Instruments, Inc.
>> + * Richard Woodruff <r-woodruff2@ti.com>
>> + *
>> + * Based on pm.c for omap2
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/sched.h>
>> +#include <linux/cpuidle.h>
>> +#include <linux/export.h>
>> +#include <linux/cpu_pm.h>
>> +#include <asm/cpuidle.h>
>> +
>> +#include "../../arch/arm/mach-omap2/powerdomain.h"
>> +#include "../../arch/arm/mach-omap2/clockdomain.h"
>> +
>> +#include "../../arch/arm/mach-omap2/pm.h"
>> +#include "../../arch/arm/mach-omap2/control.h"
>> +#include "../../arch/arm/mach-omap2/common.h"
>
> Do we really want to do includes like this from drivers?
> Presumably these will go away with DT, but still.
>
> Kevin, any comments?

NACK

We need proper interfaces to platform-specific code before moving.

Kevin
