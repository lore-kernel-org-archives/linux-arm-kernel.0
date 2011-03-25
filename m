From: b32955@freescale.com (Huang Shijie)
Date: Fri, 25 Mar 2011 14:59:02 +0800
Subject: [PATCH 3/7] add the database for the NANDs
In-Reply-To: <19852.15018.820053.918668@ipc1.ka-ro>
References: <1300240521-4344-1-git-send-email-b32955@freescale.com>	<201103231629.46958.ffainelli@freebox.fr>	<4D8AAC1C.2070709@freescale.com>	<201103241450.50967.ffainelli@freebox.fr>	<4D8C0250.1060604@freescale.com>
	<19852.15018.820053.918668@ipc1.ka-ro>
Message-ID: <4D8C3D36.7000703@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi:

> Hi,
>
> Huang Shijie writes:
>> Hi Florian:
>>
>>
>>>>>> +#include "nand_device_info.h"
>>>>>> +
>>>>>> +static struct nand_device_info samsung_nand[] __initdata = {
>>>>>> +	{
>>>>>> +		.id	= { 0xec, 0xd3, 0x14, 0x25, 0x64, 0xec, 0xd3, 0x14 },
>>>>>> +		.desc	= "K9G8G08U0M, K9HAG08U1M",
>>>>>> +		.attr	= ATTR(MLC, 1LL * SZ_1G, 128, 2 * SZ_1K + 64, 4, 512),
>>>>>> +		.timing	= TIMING(20, 15, 20, 6, -1, -1, -1),
>>>>>> +	}, {
>>>>>> +		.id	= { 0xec, 0xd7, 0xd5, 0x29, 0x38, 0x41, 0xec, 0xd7 },
>>>>>> +		.desc	= "K9LBG08U0D",
>>>>>> +		.attr	= ATTR(MLC, 4LL * SZ_1G, 128, 4 * SZ_1K + 218, 8, 512),
>>>>>> +		.timing	= TIMING(20, 10, 25, 6, 20, 5, 15),
>>>>>> +	}, {
>>>>>> +		.id	= { 0xec, 0xd5, 0x14, 0xb6, 0x74, 0xec, 0xd5, 0x14 },
>>>>>> +		.desc	= "K9GAG08U0M",
>>>>>> +		.attr	= ATTR(MLC, 2LL * SZ_1G, 128, 4 * SZ_1K + 218, 4, 512),
>>>>>> +		.timing	= TIMING(15, 10, 20, 6, -1, -1, -1),
>>>>>> +	}, {
>>>>>> +		/* end of the table. */
>>>>>> +		.id	= { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
>>>>>> +	},
>>>>>> +};
>>>>> Such information should be set in platform code, because it is specific
>>>>> to your controller and most likely to a particular board design.
>>>> I prefer to place it here.
>>>>
>>>>     If I move the code to arch/arm/mach-mxs, it will make the arch/ much
>>>> bigger.
>>>> I have nearly 50 different nands information by hand, I will add it
>>>> gradually in later patches.
>>> This certainly makes the code bigger, but this is also the place where the
>>> code belongs. Also, if you mark your structures with __initdata, such memory
>>> can be freed later by the kernel, so I would rather go into that direction.
>>>
>> Please check the emails i talked with Lothar.
>>
> Maybe you should separate the database from the driver and build it as
> a separate entity, so that other chip drivers can take advantage of it
> and in the long run it might replace the current nand_ids database.
>
ok. a good idea. I will try it.

Huang Shijie
