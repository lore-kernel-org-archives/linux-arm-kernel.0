From: b32955@freescale.com (Huang Shijie)
Date: Tue, 26 Apr 2011 10:52:16 +0800
Subject: [PATCH v6 1/3] MTD : add the common code for GPMI controller
	driver
In-Reply-To: <19887.57747.43423.753598@ipc1.ka-ro>
References: <1303267549-18377-1-git-send-email-b32955@freescale.com>	<1303267549-18377-2-git-send-email-b32955@freescale.com>
	<19887.57747.43423.753598@ipc1.ka-ro>
Message-ID: <4DB63360.8010908@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi:
> Huang Shijie writes:
>> These files contain the common code for the GPMI driver.
>>
>> Signed-off-by: Huang Shijie<b32955@freescale.com>
>> ---
>>   drivers/mtd/nand/gpmi-nfc/gpmi-nfc.c | 2501 ++++++++++++++++++++++++++++++++++
>>   drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h |  488 +++++++
>>   2 files changed, 2989 insertions(+), 0 deletions(-)
>>   create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-nfc.c
>>   create mode 100644 drivers/mtd/nand/gpmi-nfc/gpmi-nfc.h
>>
>> diff --git a/drivers/mtd/nand/gpmi-nfc/gpmi-nfc.c b/drivers/mtd/nand/gpmi-nfc/gpmi-nfc.c
>> new file mode 100644
>> index 0000000..53d6915
>> --- /dev/null
>> +++ b/drivers/mtd/nand/gpmi-nfc/gpmi-nfc.c
>> @@ -0,0 +1,2501 @@
>> +/*
>> + * Freescale GPMI NFC NAND Flash Driver
>> + *
>> + * Copyright (C) 2010-2011 Freescale Semiconductor, Inc.
>> + * Copyright (C) 2008 Embedded Alley Solutions, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, write to the Free Software Foundation, Inc.,
>> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> + */
>> +#include<linux/slab.h>
>> +#include "gpmi-nfc.h"
>> +
>> +/* add our owner bbt descriptor */
>> +static uint8_t scan_ff_pattern[] = { 0xff };
>> +static struct nand_bbt_descr gpmi_bbt_descr = {
>> +	.options	= 0,
>> +	.offs		= 0,
>> +	.len		= 1,
>> +	.pattern	= scan_ff_pattern
>> +};
>> +
>> +/* debug control */
>> +int gpmi_debug;
>> +
> This could be a module_param.
>
I think the module_param is not easy to use.
I want to know the log when the gpmi driver is running, and change the 
log level as soon
as my need changs.

So I prefer to use the origin method.


Best Regards
Huang Shijie
