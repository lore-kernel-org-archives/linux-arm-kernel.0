From: sbranden@broadcom.com (Scott Branden)
Date: Sat, 28 Feb 2015 07:36:02 -0800
Subject: [PATCH v2 2/2] Input: bcm-keypad: Add Broadcom keypad controller
In-Reply-To: <1425132978.24292.39.camel@x220>
References: <Scott Branden <sbranden@broadcom.com>	
 <1424966930-28097-1-git-send-email-sbranden@broadcom.com>	
 <1424966930-28097-3-git-send-email-sbranden@broadcom.com>
 <1425132978.24292.39.camel@x220>
Message-ID: <54F1E062.8070609@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Yes, will correct.  Thanks.

On 15-02-28 06:16 AM, Paul Bolle wrote:
> On Thu, 2015-02-26 at 08:08 -0800, Scott Branden wrote:
>> Add driver for Broadcom's keypad controller.
>>
>> Broadcom Keypad controller is used to interface a SoC with a matrix-type
>> keypad device. The keypad controller supports multiple row and column lines.
>> A key can be placed at each intersection of a unique row and a unique column.
>> The keypad controller can sense a key-press and key-release and report the
>> event using a interrupt to the cpu.
>>
>> Reviewed-by: Ray Jui <rjui@broadcom.com>
>> Signed-off-by: Scott Branden <sbranden@broadcom.com>
>> ---
>>   drivers/input/keyboard/Kconfig      |  10 +
>>   drivers/input/keyboard/Makefile     |   1 +
>>   drivers/input/keyboard/bcm-keypad.c | 464 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 475 insertions(+)
>>   create mode 100644 drivers/input/keyboard/bcm-keypad.c
>
> License nit follows.
>
>> diff --git a/drivers/input/keyboard/bcm-keypad.c b/drivers/input/keyboard/bcm-keypad.c
>> new file mode 100644
>> index 0000000..f229ac0
>> --- /dev/null
>> +++ b/drivers/input/keyboard/bcm-keypad.c
>> @@ -0,0 +1,464 @@
>> +/*
>> + * Copyright (C) 2014 Broadcom Corporation
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation version 2.
>
> This states that the license is GPL v2 only.
>
>> + *
>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>> + * kind, whether express or implied; without even the implied warranty
>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>
> [...]
>
>> +MODULE_LICENSE("GPL");
>
> So you probably want
>      MODULE_LICENSE("GPL v2");
>
>
> Paul Bolle
>
