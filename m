From: d-gerlach@ti.com (Dave Gerlach)
Date: Thu, 22 Feb 2018 08:28:16 -0600
Subject: [PATCH 2/4] ARM: OMAP2+: Introduce low-level suspend code for
 AM43XX
In-Reply-To: <CAOFm3uGUN387rU6xVZf+qndM_s9j=PT+4uuS3JQ=cdSOGm46GA@mail.gmail.com>
References: <20180216214002.6209-1-d-gerlach@ti.com>
 <20180216214002.6209-3-d-gerlach@ti.com>
 <CAOFm3uGUN387rU6xVZf+qndM_s9j=PT+4uuS3JQ=cdSOGm46GA@mail.gmail.com>
Message-ID: <bf9eeb82-d70f-fab5-d0fe-83141bddc534@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On 02/20/2018 01:25 AM, Philippe Ombredanne wrote:
> Dave,
> 
> On Fri, Feb 16, 2018 at 10:40 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
>> Although similar to AM33XX, introduce a new low-level asm file for
>> suspend containing new context save and restore paths for EMIF and l2
>> cache disabling and enabling.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
>>  arch/arm/mach-omap2/sleep43xx.S | 393 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 393 insertions(+)
>>  create mode 100644 arch/arm/mach-omap2/sleep43xx.S
>>
>> diff --git a/arch/arm/mach-omap2/sleep43xx.S b/arch/arm/mach-omap2/sleep43xx.S
>> new file mode 100644
>> index 000000000000..3a8bfd62a33c
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/sleep43xx.S
>> @@ -0,0 +1,393 @@
>> +/*
>> + * Low level suspend code for AM43XX SoCs
>> + *
>> + * Copyright (C) 2013-2018 Texas Instruments Incorporated - http://www.ti.com/
>> + *     Dave Gerlach, Vaibhav Bedia
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation version 2.
>> + *
>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>> + * kind, whether express or implied; without even the implied warranty
>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
> 
> Do you mind using SPDX tags per [1] rather that this fine but long
> legalese here and in the whole patch set? Unless you are a legalese
> lover of course!

Yes I will switch, these patches have been around for a long time and I didn't
think to update the license after rebasing them. Thanks for the reminder!

Regards,
Dave

> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
> 
