From: mina86@mina86.com (Michal Nazarewicz)
Date: Thu, 23 Dec 2010 16:02:07 +0100
Subject: [PATCHv8 00/12] Contiguous Memory Allocator
In-Reply-To: <AANLkTinzsOom5awOr6Y8e7PKRbCWYQOqEbdw9is6HroR@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 23 Dec 2010 16:42:57 +0200")
References: <cover.1292443200.git.m.nazarewicz@samsung.com>
	<AANLkTim8_=0+-zM5z4j0gBaw3PF3zgpXQNetEn-CfUGb@mail.gmail.com>
	<20101223100642.GD3636@n2100.arm.linux.org.uk>
	<00ea01cba290$4d67f500$e837df00$%szyprowski@samsung.com>
	<20101223121917.GG3636@n2100.arm.linux.org.uk>
	<4D135004.3070904@samsung.com>
	<20101223134838.GK3636@n2100.arm.linux.org.uk>
	<4D1356D7.2000008@samsung.com>
	<20101223141608.GM3636@n2100.arm.linux.org.uk>
	<AANLkTinzsOom5awOr6Y8e7PKRbCWYQOqEbdw9is6HroR@mail.gmail.com>
Message-ID: <87d3osedn4.fsf@erwin.mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> On Thu, Dec 23, 2010 at 03:04:07PM +0100, Tomasz Fujak wrote:
>>> In other words, should we take your response as yet another NAK?
>>> Or would you try harder and at least point us to some direction that
>>> would not doom the effort from the very beginning.

> On Thu, Dec 23, 2010 at 4:16 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> What the fsck do you think I've been doing? ?This is NOT THE FIRST time
>> I've raised this issue. ?I gave up raising it after the first couple
>> of attempts because I wasn't being listened to.
>>
>> You say about _me_ not being very helpful. ?How about the CMA proponents
>> start taking the issue I've raised seriously, and try to work out how
>> to solve it? ?And how about blaming them for the months of wasted time
>> on this issue _because_ _they_ have chosen to ignore it?

Felipe Contreras <felipe.contreras@gmail.com> writes:
> I've also raised the issue for ARM. However, I don't see what is the
> big problem.
>
> A generic solution (that I think I already proposed) would be to
> reserve a chunk of memory for the CMA that can be removed from the
> normally mapped kernel memory through memblock at boot time. The size
> of this memory region would be configurable through kconfig. Then, the
> CMA would have a "dma" flag or something, 

Having exactly that usage in mind, in v8 I've added notion of private
CMA contexts which can be used for DMA coherent RAM as well as memory
mapped devices.

> and take chunks out of it until there's no more, and then return
> errors. That would work for ARM.

-- 
Best regards,                                         _     _
 .o. | Liege of Serenly Enlightened Majesty of      o' \,=./ `o
 ..o | Computer Science,  Michal "mina86" Nazarewicz   (o o)
 ooo +--<mina86-tlen.pl>--<jid:mina86-jabber.org>--ooO--(_)--Ooo--
