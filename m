From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 11 Jul 2011 13:09:45 -0700
Subject: [RFC PATCH 05/17] ARM: kernel: save/restore kernel IF
In-Reply-To: <20110711191952.GC8486@n2100.arm.linux.org.uk>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-6-git-send-email-lorenzo.pieralisi@arm.com>
	<alpine.DEB.2.00.1107081641280.2609@localhost6.localdomain6>
	<20110711140047.GA346@e102568-lin.cambridge.arm.com>
	<20110711184010.GB8486@n2100.arm.linux.org.uk>
	<CAMbhsRRm4-8gzjxqqu8MAkyMg8Xx02wDhmjET0b9njVF5z=UVw@mail.gmail.com>
	<20110711191952.GC8486@n2100.arm.linux.org.uk>
Message-ID: <4E1B5889.4050700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/11/2011 12:19 PM, Russell King - ARM Linux wrote:
> On Mon, Jul 11, 2011 at 11:51:00AM -0700, Colin Cross wrote:
>> On Mon, Jul 11, 2011 at 11:40 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk>  wrote:
>>> On Mon, Jul 11, 2011 at 03:00:47PM +0100, Lorenzo Pieralisi wrote:
>>>> Well, short answer is no. On SMP we do need to save CPU registers
>>>> but if just one single cpu is shutdown L2 is still on.
>>>> cpu_suspend saves regs on the stack that has to be cleaned from
>>>> L2 before shutting a CPU down which make things more complicated than
>>>> they should.
>>>
>>> Hang on.  Please explain something to me here.  You've mentioned a few
>>> times that cpu_suspend() can't be used because of the L2 cache.  Why
>>> is this the case?
>>>
>>> OMAP appears to have code in its sleep path - which has been converted
>>> to cpu_suspend() support - to deal with the L2 issues.
>>
>> OMAP is very different, because it doesn't use cpu_suspend.  It saves
>> it's state to SAR ram, which is mapped uncached, which avoids L2
>> problems.
>
> I'm afraid your information is out of date.  See:
>
I think the confusion is OMAP3 and OMAP4. Colin was talking about OMAP4
which isn't merged in mainline yet where as you were referring OMAP3
clean-ups happened recently.

Regards
Santosh
