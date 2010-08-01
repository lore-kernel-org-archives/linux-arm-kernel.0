From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 01 Aug 2010 21:32:47 +0200
Subject: [PATCH] PXA: Fix wakealarm capability for pxa-rtc
In-Reply-To: <201008011738.16225.marek.vasut@gmail.com> (Marek Vasut's message
	of "Sun\, 1 Aug 2010 17\:38\:16 +0200")
References: <1280550147-12380-1-git-send-email-marek.vasut@gmail.com>
	<201008010253.28319.marek.vasut@gmail.com> <87eieiziri.fsf@free.fr>
	<201008011738.16225.marek.vasut@gmail.com>
Message-ID: <87vd7uxh5s.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut <marek.vasut@gmail.com> writes:

>> Okay, I understand better, you're looking for the class driver wakup sysfs
>> entry, and not the driver sysfs wakeup entry.
>> 
>> So when you said "It's not created for me without this patch", you meant
>> the class driver's sysfs entry, not the one I mentioned I presume ?
>
> You're still talking about some "wakeup", I'm talking about 
> /sys/devices/platform/pxa-rtc/power/wakealarm .
...

>> 
>> Anyway, to straighten things up :
>>  - for an rtc driver, device_init_wakeup() has to be called before
>>  rtc_driver_register()
>>  - if that's not the case, /sys/class/rtc/rtc0/wakealarm won't be created
>>  - if that's the case, if the driver called device_init_wakeup(x, 1), the
>> rtc registering will override the value with device_init_wakeup(x, 0)
>
> Are we talking about the same kernel? I just can't find this 
> "device_init_wakeup(x, 0);" which would override anything anywhere.
I already provided the call tree.

Anyway, I won't be available for the next days, and as I don't want to argue
anymore, and I expect you have tested your patch against a suspended device to
see it wake up, have my:

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

--
Robert
