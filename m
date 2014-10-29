From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 29 Oct 2014 22:56:35 +0400
Subject: [PATCH 00/15] new locomo driver
In-Reply-To: <20141028001338.GZ27405@n2100.arm.linux.org.uk>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <20141028001338.GZ27405@n2100.arm.linux.org.uk>
Message-ID: <CALT56yNpMNJaT2qybV=yT4YZ+fAC8MYBS4dYQ9rJXwg=d6ReJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-10-28 3:13 GMT+03:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
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

Greg, Russell, what should I use then for mfd multi-cell devices?
Is mfd-core still a permitted API? Should we change mfd-core
internals to spawn extra bus (busses?) for the cells?

>
>>  * Device drivers are not well layered/separated.
>
> ... better layering or separation of drivers.
>
> So, thinking that converting from a custom bus to a platform bus
> definitely is /not/ a positive step forward.

-- 
With best wishes
Dmitry
