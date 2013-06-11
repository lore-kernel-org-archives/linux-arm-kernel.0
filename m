From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 11 Jun 2013 10:54:19 -0400
Subject: [PATCH 2/3] ARM: keystone: Enable SMP support on Keystone machines
In-Reply-To: <51B7277B.3080107@ti.com>
References: <1370894123-26846-1-git-send-email-santosh.shilimkar@ti.com>
 <1370894123-26846-3-git-send-email-santosh.shilimkar@ti.com>
 <CANuQgHGKqnU1itAQBqjS2xY+JHz0SNPJ6rM2ZfMV8tO32f0Qnw@mail.gmail.com>
 <51B7277B.3080107@ti.com>
Message-ID: <51B73A1B.4050302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 June 2013 09:34 AM, Santosh Shilimkar wrote:
> On Tuesday 11 June 2013 01:16 AM, Chander Kashyap wrote:
>> 2013/6/11 Santosh Shilimkar <santosh.shilimkar@ti.com>:
>>> Add basic SMP support for Keystone machines. This does not
>>> include support for CPU hotplug for now.
>>>
>>> Cc: Olof Johansson <olof@lixom.net>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: arm at kernel.org
>>>
>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> ---
> 
> [..]
> 
>>> diff --git a/arch/arm/mach-keystone/platsmp.c b/arch/arm/mach-keystone/platsmp.c
>>> new file mode 100644
>>> index 0000000..3071dda
>>> --- /dev/null
>>> +++ b/arch/arm/mach-keystone/platsmp.c
>>> @@ -0,0 +1,67 @@
>>> +/*
>>> + * Keystone SOC SMP platform code
>>> + *
>>> + * Copyright 2013 Texas Instruments, Inc.
>>> + *     Cyril Chemparathy <cyril@ti.com>
>>> + *     Santosh Shilimkar <santosh.shillimkar@ti.com>
>>> + *
>>> + * Based on platsmp.c, Copyright (C) 2002 ARM Ltd.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify it
>>> + * under the terms and conditions of the GNU General Public License,
>>> + * version 2, as published by the Free Software Foundation.
>>> + */
>>> +
>>> +#include <linux/init.h>
>>> +#include <linux/smp.h>
>>> +#include <linux/io.h>
>>> +
>>> +#include <asm/smp_plat.h>
>>> +
>>> +#include "keystone.h"
>>> +
>>> +static void __init keystone_smp_init_cpus(void)
>>> +{
>>> +       unsigned int i, ncores;
>>> +
>>> +       ncores = 4;
>> This hardcoding can be done away, if cpu nodes are passed through DT.
>> Also set set_cpu_possible will be done by "arm_dt_init_cpu_maps" in  devtree.c
>>
> Thanks. Will have a look at it.
> 
For record, i have dropped keystone_smp_init_cpus() completely.
arm_dt_init_cpu_maps() does everything what we need. Thanks
for pointer.

Looks like other platforms can also do the same
but was curious why its not being used yet. May be I missed
some ongoing patches. Do you know ?

Regards,
Santosh
