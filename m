From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 31 Jul 2010 23:07:06 +0200
Subject: [PATCH] PXA: Fix wakealarm capability for pxa-rtc
In-Reply-To: <201007312215.45771.marek.vasut@gmail.com> (Marek Vasut's message
	of "Sat\, 31 Jul 2010 22\:15\:45 +0200")
References: <1280550147-12380-1-git-send-email-marek.vasut@gmail.com>
	<87k4ob1x29.fsf@free.fr> <201007312215.45771.marek.vasut@gmail.com>
Message-ID: <87mxt7z7gl.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut <marek.vasut@gmail.com> writes:

> Dne So 31. ?ervence 2010 17:38:06 Robert Jarzmik napsal(a):
>> Marek Vasut <marek.vasut@gmail.com> writes:
>> > The wakealarm capability was incorrectly set after the RTC was
>> > registered, which resulted into the sysfs node not being created.
>> 
>> On my platform, without this patch:
>> > cat /sys/devices/platform/pxa-rtc/power/wakeup
>> > enabled
>> 
>> The sysfs node is created. What's the issue you're having ?
>
> It's not created for me without this patch (and if you read the code, it is 
> impossible to be created without this patch).

I read the code, and I see:
rtc_device_register()
  -> device_register()
    -> device_initialize()
      -> device_init_wakeup(dev, 0)

So with or without your patch, device_init_wakeup() is called. The difference is
that with your patch, we end up with a disabled wakeup capability.
I showed the code sequence, your turn to show your "if you read the code".

Moreover, my platform without your patch prooves that the sysfs entry is created.

So unless you prove me wrong, I will reject the patch.

Cheers.

-- 
Robert
