From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Fri, 13 May 2011 16:25:56 +0530
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver.
In-Reply-To: <201105112203.54838.arnd@arndb.de>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<201105102344.58598.arnd@arndb.de>
	<82D549BB195345A1A189D569952B387C@subhasishg>
	<201105112203.54838.arnd@arndb.de>
Message-ID: <EAA964D5CCD94B4A9544B294E0CF5099@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>
>> Ok, thanks for the clarification.
>> Instead of passing the device name, will it be ok to pass the mfd_id.
>> The benefit will be that I can use the ID directly as an array
>> index for the mfd_cell entries.
>
> I think a device name would be clearer here, especially in order
> to avoid conflicts when the list gets extended in different ways
> depending on which kernel runs.
>
> We had a little discussion at the Linaro Developer Summit about your
> driver and mfd drivers in general. There was a general feeling among
> some people (including me) that by the point you dynamically create
> the subdevices, MFD is probably not the right abstraction any more,
> as it does not provide any service that you need.
>
> Instead, maybe you can simply call platform_device_register
> at that stage to create the children and not use MFD at all.
>
> Samuel, can you comment on this as well? Do you still see pruss
> as an MFD driver when the uses are completely dynamic and determined
> by the firmware loaded into it?
>

Hi Arnd,

But in that case, where do I fit my driver.
It's a microcontroller inside of a processor, guess that's unique for Linux.
Will a misc device be a better choice.

In that case I can remove the MFD cell from the board_file and add an array
of platform_device for the UART & CAN.

Regarding device register, I will have to implement something similar to
mfd_add_devices and mark the dev->parent.

Did I miss something or will that be fine.



 
