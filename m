From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 28 Oct 2014 04:28:53 +0400
Subject: [PATCH 00/15] new locomo driver
In-Reply-To: <20141028001338.GZ27405@n2100.arm.linux.org.uk>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <20141028001338.GZ27405@n2100.arm.linux.org.uk>
Message-ID: <CALT56yObXu53ZenS6KNJq-Dx-AYuQnWpT+ejyBg+WCm--tfXXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-10-28 4:13 GMT+04:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, Oct 28, 2014 at 03:01:53AM +0300, Dmitry Eremin-Solenikov wrote:
>> Sharp Zaurus SL-5500 and SL-5600 use special companion Gate Array. Current
>> drivers present in Linux kernel has some problems:
>>
>>  * It uses custom bus instead of platform bus/mfd core.
>
> I believe Greg wouldn't see that as a positive point.
>
> Don't think that the platform bus _should_ always be used.  It shouldn't
> (Greg has said he'd like to see the platform bus to be totally killed off.)
> Instead, custom buses properly suited to the class of device in question
> is much preferred, especially if it aids in...

I'm sorry, I must be outdated on this topic. Few years ago things were exactly
opposite - we explicitly had to use platform bus for mfd devices. I
still think that
mfd devices containing several cells should use mfd-core (is it still
OK to use it?).
And mfd-core (up to now) uses platform bus.

>
>>  * Device drivers are not well layered/separated.
>
> ... better layering or separation of drivers.
>
> So, thinking that converting from a custom bus to a platform bus
> definitely is /not/ a positive step forward.

Is there an example of new approach? Current locomo-dev implementation
is poisoned with several bugs. For example it passes ioremapped memory
as resources to child devices that later call request_resource() on it.
Adding additional features (like correct work with IRQs) will duplicate
platform bus code and mfd functions.

>
> (Why mfd was ever allowed to re-use the platform bus stuff is a separate
> question not relevent to these patches.)

I remember this story - Ian Molton and me wrote mfd-core.c.

-- 
With best wishes
Dmitry
