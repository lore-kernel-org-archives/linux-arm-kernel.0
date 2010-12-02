From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 02 Dec 2010 18:39:50 +0100
Subject: [PATCH 3/4] plat-s5p: Add platform support for MIPI-CSI2 devices
In-Reply-To: <20101202171538.GB30933@pulham.picochip.com>
References: <1291307862-8125-1-git-send-email-s.nawrocki@samsung.com>
	<1291307862-8125-4-git-send-email-s.nawrocki@samsung.com>
	<20101202171538.GB30933@pulham.picochip.com>
Message-ID: <4CF7D9E6.5000409@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Jamie,

On 12/02/2010 06:15 PM, Jamie Iles wrote:
> Hi Sylwester,
> 
> On Thu, Dec 02, 2010 at 05:37:41PM +0100, Sylwester Nawrocki wrote:
>> diff --git a/arch/arm/plat-s5p/dev-csis0.c b/arch/arm/plat-s5p/dev-csis0.c
>> new file mode 100644
>> index 0000000..2b1ba43
>> --- /dev/null
>> +++ b/arch/arm/plat-s5p/dev-csis0.c
>> @@ -0,0 +1,34 @@
>> +/*
>> + * Copyright (C) 2010 Samsung Electronics
>> + *
>> + * S5P series device definition for MIPI-CSI device 0
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/platform_device.h>
>> +#include <mach/map.h>
>> +
>> +static struct resource s5p_csis_resource[] = {
>> +	[0] = {
>> +		.start = S5P_PA_CSIS0,
>> +		.end   = S5P_PA_CSIS0 + SZ_4K - 1,
>> +		.flags = IORESOURCE_MEM,
>> +	},
>> +	[1] = {
>> +		.start = IRQ_MIPICSI0,
>> +		.end   = IRQ_MIPICSI0,
>> +		.flags = IORESOURCE_IRQ,
>> +	}
>> +};
> Do you really need the [0] and [1] here? These are only needed if you are 
> sparsely initialising an array.

I agree explicit indices are not really needed. I just followed the style of
all other resource definitions already there.
I am not quite sure what is the preference of the maintainer, I guess they want
all devices to follow same style for consistence.

Thanks,
Sylwester

-- 
Sylwester Nawrocki
Linux Platform Group
Samsung Poland R&D Center
