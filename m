From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 6 Sep 2012 09:26:58 -0500
Subject: [PATCH 09/10] ARM: OMAP: Add dmtimer interrupt disable function
In-Reply-To: <50489DD9.90903@ti.com>
References: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
 <1346871872-24413-10-git-send-email-jon-hunter@ti.com>
 <50489DD9.90903@ti.com>
Message-ID: <5048B2B2.1030401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 09/06/2012 07:58 AM, Vaibhav Hiremath wrote:
> 
> 
> On 9/6/2012 12:34 AM, Jon Hunter wrote:
>> The OMAP dmtimer driver does not currently have a function to disable the
>> timer interrupts. For some timer instances the timer interrupt enable
>> function can be used to disable the interrupts because the same interrupt
>> enable register is used to disable interrupts. However, some timer instances
>> have separate interrupt enable/disable registers and so this will not work.
>> Therefore, add a dedicated function to disable interrupts.
>>
> 
> I think you should clearly specify which timer and which device you are
> referring to.

OMAP4+ devices. For OMAP4 all timers apart from 1, 2 and 10. For OMAP5
all timers.

Jon
