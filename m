From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 31 Jul 2010 22:15:45 +0200
Subject: [PATCH] PXA: Fix wakealarm capability for pxa-rtc
In-Reply-To: <87k4ob1x29.fsf@free.fr>
References: <1280550147-12380-1-git-send-email-marek.vasut@gmail.com>
	<87k4ob1x29.fsf@free.fr>
Message-ID: <201007312215.45771.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne So 31. ?ervence 2010 17:38:06 Robert Jarzmik napsal(a):
> Marek Vasut <marek.vasut@gmail.com> writes:
> > The wakealarm capability was incorrectly set after the RTC was
> > registered, which resulted into the sysfs node not being created.
> 
> On my platform, without this patch:
> > cat /sys/devices/platform/pxa-rtc/power/wakeup
> > enabled
> 
> The sysfs node is created. What's the issue you're having ?

It's not created for me without this patch (and if you read the code, it is 
impossible to be created without this patch).

Cheers
> 
> Cheers.
> 
> --
> Robert
