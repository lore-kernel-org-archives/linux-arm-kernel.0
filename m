From: shawn.gsc@gmail.com (Shawn Guo)
Date: Thu, 9 Dec 2010 15:04:37 +0800
Subject: [PATCH v2 14/15] ARM: mxs: Add initial mx28evk support
In-Reply-To: <20101208202822.GD17441@pengutronix.de>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-11-git-send-email-shawn.guo@freescale.com>
	<20101208202822.GD17441@pengutronix.de>
Message-ID: <AANLkTiny2P3RobZfq_G_OPHu_SLjZ2w9CFhU7HgL3VPx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2010/12/9 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello Shawn,
>
> On Wed, Dec 08, 2010 at 12:32:02AM +0800, Shawn Guo wrote:
>> Add initial mx28evk support with duart and fec0.
>>
>> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
>> ---
>> Changes for v2:
>> ?- Change function mx28evk_fec_reset() from inline to __init
>> ?- Enable pll2 clock before phy operation
>> ?- Add error checking for gpio_direction_output()
>> ?- Save bytes by passing parameter into pr_err format string
>> ?- Change mx28_add_fec0() to mx28_add_fec(0)
>> ?- Remove boot_params
>>
>> ?arch/arm/mach-mxs/mach-mx28evk.c | ?126 ++++++++++++++++++++++++++++++++++++++
>> ?1 files changed, 126 insertions(+), 0 deletions(-)
>> ?create mode 100644 arch/arm/mach-mxs/mach-mx28evk.c
>>
>> diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
>> new file mode 100644
>> index 0000000..3e8e37a
>> --- /dev/null
>> +++ b/arch/arm/mach-mxs/mach-mx28evk.c
>> @@ -0,0 +1,126 @@
>> +/*
>> + * Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/gpio.h>
>> +#include <linux/irq.h>
>> +#include <linux/clk.h>
>> +
>> +#include <asm/mach-types.h>
>> +#include <asm/mach/arch.h>
>> +#include <asm/mach/time.h>
>> +
>> +#include <mach/hardware.h>
>> +#include <mach/common.h>
>> +#include <mach/iomux-mx28.h>
>> +
>> +#include "devices-mx28.h"
>> +#include "gpio.h"
>> +
>> +#define MX28EVK_FEC_PHY_POWER ? ? ? ?MXS_GPIO_NR(2, 15)
>> +#define MX28EVK_FEC_PHY_RESET ? ? ? ?MXS_GPIO_NR(4, 13)
>> +
>> +static iomux_cfg_t mx28evk_pads[] = {
> This can be const and __initconst, ditto for mx23evk
>
With u64 iomux_cfg_t changes, I'm afraid the suggestion becomes invalid.

-- 
Regards,
Shawn
