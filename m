From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 08 Nov 2013 10:51:39 -0800
Subject: [PATCH] ARM: Use udiv/sdiv for __aeabi_{u}idiv library functions
In-Reply-To: <527D15E8.6070802@codeaurora.org>
References: <1383852042-10780-1-git-send-email-sboyd@codeaurora.org>
 <527D15E8.6070802@codeaurora.org>
Message-ID: <527D32BB.40607@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/13 08:48, Christopher Covington wrote:
> Hi Stephen,
>
> On 11/07/2013 02:20 PM, Stephen Boyd wrote:
>> If we're running on a v7 ARM CPU, detect if the CPU supports the
>> sdiv/udiv instructions and replace the signed and unsigned
>> division library functions with an sdiv/udiv instruction.
> [...]
>
>> +++ b/arch/arm/lib/div-v7.c
>> @@ -0,0 +1,58 @@
>> +/* Copyright (c) 2013, The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/static_key.h>
>> +
>> +extern int ___aeabi_idiv(int, int);
>> +extern unsigned ___aeabi_uidiv(int, int);
> Why are the input parameters signed?

Copy pasta. Fixed thanks.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
