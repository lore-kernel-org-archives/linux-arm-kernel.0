From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 22 May 2014 18:06:36 -0400
Subject: [RFC] ARM: tty: Move HVC DCC assembly to arch/arm
In-Reply-To: <B273A106-344F-4D36-998B-E44F889AD93F@codeaurora.org>
References: <1382120064-2459-1-git-send-email-cov@codeaurora.org>
 <B273A106-344F-4D36-998B-E44F889AD93F@codeaurora.org>
Message-ID: <537E74EC.1020004@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kumar,

On 10/23/2013 01:59 AM, Kumar Gala wrote:
> 
> On Oct 18, 2013, at 1:14 PM, Christopher Covington wrote:
> 
>> Put architecture-specific assembly code where it belongs,
>> allowing for support of additional architectures such as arm64 in
>> the future.
>>
>> Signed-off-by: Christopher Covington <cov@codeaurora.org>
>> ---
>> arch/arm/include/asm/dcc.h | 45 +++++++++++++++++++++++++++++++++++++++++++
>> drivers/tty/hvc/hvc_dcc.c  | 48 ++--------------------------------------------
>> 2 files changed, 47 insertions(+), 46 deletions(-)
>> create mode 100644 arch/arm/include/asm/dcc.h
>>
>> diff --git a/arch/arm/include/asm/dcc.h b/arch/arm/include/asm/dcc.h
>> new file mode 100644
>> index 0000000..306d1fc
>> --- /dev/null
>> +++ b/arch/arm/include/asm/dcc.h
>> @@ -0,0 +1,45 @@
>> +/* Copyright (c) 2010, The Linux Foundation. All rights reserved.
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
>> +#include <asm/barrier.h>
>> +
>> +/* DCC Status Bits */
>> +#define DCC_STATUS_RX		(1 << 30)
>> +#define DCC_STATUS_TX		(1 << 29)
>> +
> 
> Why'd you move these define's here? They don't seem to be arch specific
> and I don't see them used in the asm anywhere.

Fixed in v2.

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
