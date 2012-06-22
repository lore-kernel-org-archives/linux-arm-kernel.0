From: xiechao.linux@gmail.com (chao xie)
Date: Fri, 22 Jun 2012 08:48:13 +0800
Subject: pm runtime and system suspend resume
In-Reply-To: <Pine.LNX.4.44L0.1206211025060.1164-100000@iolanthe.rowland.org>
References: <CAK9wHMS_P+y+NmvVVrH+nNOb=KPi3rEgJOWEcRcKf3mTkxjDPA@mail.gmail.com>
 <Pine.LNX.4.44L0.1206211025060.1164-100000@iolanthe.rowland.org>
Message-ID: <CAK9wHMTYoxVqj3Ls3Y7NEwgL4Y=XnxGFzyxfy4bseMR_Hhzp7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/6/21 Alan Stern <stern@rowland.harvard.edu>:
> On Thu, 21 Jun 2012, chao xie wrote:
>
>> I check the code, __device_suspend will invoke dev->pm_domain->ops
>> first if dev->pm_domain is not NULL.
>> Taking "suspend" as esample, i can do the following things in the
>> dev->pm_domain->ops->suspend
>> 1. invoke dev->driver->pm->suspend for suspending the device
>> 2. do what we do in dev->pm_domain->ops->runtime_suspend for
>> suspending the surrounded logic, for example, shutdown the phy or
>> clocks.
>> So is above implementation fine?
>
> Yes, that sounds like it will work. ?Watch out for the case where your
> device is already runtime-suspended when a system suspend occurs.
>
> Have you read section 6 in Documentation/power/runtime_pm.txt? ?It is
> related to your question.
>
I will read the document. Thanks very much.

> Alan Stern
>
