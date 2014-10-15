From: carlo@caione.org (Carlo Caione)
Date: Wed, 15 Oct 2014 09:28:36 +0200
Subject: [PATCH v2 1/3] ARM: meson: reset: Add reset controller for MesonX
 SoCs
In-Reply-To: <20141014223651.GA15055@pengutronix.de>
References: <1413311749-13948-1-git-send-email-carlo@caione.org>
 <1413311749-13948-2-git-send-email-carlo@caione.org>
 <20141014223651.GA15055@pengutronix.de>
Message-ID: <CAOQ7t2amOv=Pk6h7fxVAqeQM9x88g6fyMtCnQSVWj7P455nYSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 15, 2014 at 12:36 AM, Philipp Zabel <pza@pengutronix.de> wrote:
> Hi Carlo,

Hi Philipp,

>> @@ -0,0 +1,142 @@
>> +/*
>> + * Copyright 2014 Carlo Caione <carlo@caione.org>
>> + *
>> + * based on
>> + * Steffen Trumtrar Reset Controller driver
>
> That doesn't sound right. Do you mean socfpga-reset?

Yes, I'll change it.

>> + * Copyright 2014 Steffen Trumtrar
>> + *
>> + * Steffen Trumtrar <s.trumtrar@pengutronix.de>
>
> Could be combined into a single line.

Ok

>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reset-controller.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/types.h>
>> +
>> +#define MESON_RST_OFFSET     0x00
>
> If there is only one register, I see no need for this.

Ok

>> +
>> +     data->rcdev.owner = THIS_MODULE;
>> +     data->rcdev.nr_resets = BITS_PER_LONG;
>
> Are all bits in this registers reset controls (or rather, are you
> positive there is no bit in this register used by anything else)?

I'm not sure to be honest. Probably some other bits is used for power
management (I don't have full documentation yet).
I'll submit a v3 with a smaller mask for just the bits I'm going to use.

> Other than that, the driver looks good.

Thank you.

-- 
Carlo Caione
