From: shawn.gsc@gmail.com (Shawn Guo)
Date: Thu, 9 Dec 2010 10:02:48 +0800
Subject: [PATCH v2 05/15] ARM: mxs: Add low-level debug UART support
In-Reply-To: <20101208202735.GC17441@pengutronix.de>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-4-git-send-email-shawn.guo@freescale.com>
	<20101208202735.GC17441@pengutronix.de>
Message-ID: <AANLkTikbiPCtGG9S2YsAPHdNqUGGB_iFrHtGTzNAEx88@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2010/12/9 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> On Wed, Dec 08, 2010 at 12:31:55AM +0800, Shawn Guo wrote:
[...]
>> diff --git a/arch/arm/mach-mxs/include/mach/uncompress.h b/arch/arm/mach-mxs/include/mach/uncompress.h
>> new file mode 100644
>> index 0000000..efdacc7
>> --- /dev/null
>> +++ b/arch/arm/mach-mxs/include/mach/uncompress.h
>> @@ -0,0 +1,78 @@
>> +/*
>> + * ?arch/arm/mach-mxs/include/mach/uncompress.h
>> + *
>> + * ?Copyright (C) 1999 ARM Limited
>> + * ?Copyright (C) Shane Nay (shane at minirl.com)
>> + * ?Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
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
>> +#ifndef __MACH_MXS_UNCOMPRESS_H__
>> +#define __MACH_MXS_UNCOMPRESS_H__
>> +
>> +#define __MXS_BOOT_UNCOMPRESS
>> +
>> +#include <asm/mach-types.h>
>> +
>> +static unsigned long uart_base;
>> +
>> +#define UART(x) (*(volatile unsigned long *)(uart_base + (x)))
>> +
>> +#define DR ? ? ? ? ? 0x00
>> +#define FR ? ? ? ? ? 0x18
>> +#define FR_BUSY ? ? ? ? ? ? ?(1 << 3)
>> +#define FR_TXFE ? ? ? ? ? ? ?(1 << 7)
>> +#define CR ? ? ? ? ? 0x30
>> +#define CR_UARTEN ? ?1
> Maybe namespace these? ?Maybe better define CR_UARTEN as (1 << 0) for
> consistency?
>
Are you expecting namespace "MXS_" or "DUART_" for better?

-- 
Regards,
Shawn
