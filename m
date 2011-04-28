From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Thu, 28 Apr 2011 12:47:21 +0530
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver.
In-Reply-To: <201104271605.09537.arnd@arndb.de>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<201104271516.30951.arnd@arndb.de>
	<FED5DF6465AF41C58DBD4E0EEB200E60@subhasishg>
	<201104271605.09537.arnd@arndb.de>
Message-ID: <CF1FC9DE1796407FB4D636189646927F@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> SG -- It depends upon how the firmware is implemented. If another
>>             firmware is downloaded on it, it will emulate another device.
>>             Also, if a firmware emulated on it supports switching between
>> devices,
>>             that too is possible. Its just a microcontroller, we can do
>> whatever we feel like
>>             with it. Both the PRUs have separate instruction/data ram, so
>> both can be used
>>             to implement two different devices.
>
> I see. So the problem that I see with the current code is that you
> force the system to provide a set of devices from the MFD, which
> then get passed to the individual drivers (uart and can) that load
> the firmware they need. Please correct me if I am reading your code
> wrong.
>
> What I suggest you do instead is to have the request_firmware
> call in the low-level MFD driver, so the user can provide the
> firmware that he/she wants to use, and then the MFD driver will
> create the devices that match the firmware loaded into the device.
>
> You can easily do that by adding a small header to the firmware
> format and interpret that header by the MFD driver. When the name
> of the subdevice is part of that header, the MFD driver does not
> need to understand the difference, it can simply pass that on
> when creating its child devices.

I don't understand why loading the firmware should be done at the MFD 
driver.
The user already specifies the device he/she wants to start on the PRU via 
modprobe.
A driver can be inserted, which can download a printer firmware on one PRU 
and a
scanner firmware on the other. This way both cores can be used for separate 
purposes.
I mean, say in a real MFD controller, that will also have two separate cores 
running on it,
just that, the firmware on it would not be downloaded runtime but fused in 
some non volatile memory. 
