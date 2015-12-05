From: martyn.welch@collabora.co.uk (Martyn Welch)
Date: Sat, 05 Dec 2015 10:42:44 +0000
Subject: [PATCH 2/3] Add support for monitoring gpio switches
In-Reply-To: <20151204185713.GA22925@kroah.com>
References: <1449250275-23435-1-git-send-email-martyn.welch@collabora.co.uk>
 <1449250275-23435-3-git-send-email-martyn.welch@collabora.co.uk>
 <20151204185713.GA22925@kroah.com>
Message-ID: <5662BFA4.1010304@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/12/15 18:57, Greg Kroah-Hartman wrote:
> On Fri, Dec 04, 2015 at 05:31:14PM +0000, Martyn Welch wrote:
>> Select Chromebooks have gpio attached to switches used to cause the
>> firmware to enter alternative modes of operation and/or control other
>> device characteristics (such as write protection on flash devices). This
>> patch adds a driver that exposes a read-only interface to allow these
>> signals to be read from user space.
>>
>> This functionality has been generalised to provide support for any device
>> with device tree support which needs to identify a gpio as being used for a
>> specific task.
>>
>> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
>> ---
>>   drivers/misc/Kconfig       |  11 ++++
>>   drivers/misc/Makefile      |   1 +
>>   drivers/misc/gpio-switch.c | 160 +++++++++++++++++++++++++++++++++++++++++++++
>
> Why isn't this in drivers/gpio/ ?
>
> why make it a misc driver?
>

I thought all the drivers in /drivers/gpio were gpio drivers, rather 
than users of the gpio framework. Is that not the case?

Happy to move it if the consensus is that that's the correct place to 
put it.

Martyn

> thanks,
>
> greg k-h
>
