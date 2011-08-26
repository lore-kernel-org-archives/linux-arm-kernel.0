From: hemantp@ti.com (Pedanekar, Hemant)
Date: Fri, 26 Aug 2011 23:11:22 +0530
Subject: Question on virtual memory layout: lowmem with memory hole
In-Reply-To: <20110825185228.GA5029@n2100.arm.linux.org.uk>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B03B47E23FC@dbde02.ent.ti.com>
	<20110825102245.GA10405@n2100.arm.linux.org.uk>
	<2A3DCF3DA181AD40BDE86A3150B27B6B03B47E2949@dbde02.ent.ti.com>
	<20110825185228.GA5029@n2100.arm.linux.org.uk>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03B47E2EA7@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote on Friday, August 26, 2011 12:22 AM:

> On Fri, Aug 26, 2011 at 12:06:20AM +0530, Pedanekar, Hemant wrote:
>> Russell King - ARM Linux wrote on Thursday, August 25, 2011 3:53 PM:
>> 
>>> On Thu, Aug 25, 2011 at 09:35:07AM +0530, Pedanekar, Hemant wrote:
>>>> E.g., on OMAP3 with mem=32M at 0x80000000 mem=8M at 0x87800000
>>>> 
[...]

>> 
>> So, larger the hole, more address space will be unusable - is that correct?
> 
> Correct.
> 
>>>> This also
>>>> means vmalloc space is lower compared to when a single mem=40M is passed.
>>> 
>>> Huh.  Either your maths is wrong or...
>>> 
>>> Here's case 1:
>>>>      vmalloc : 0xc8800000 - 0xf8000000   ( 760 MB) And case 2:
>>>>      vmalloc : 0xc3000000 - 0xf8000000   ( 848 MB)
>>> 
>>> Looks to me like case 1, vmalloc space is _higher_ not _lower_.  That's
>>> expected because you told the kernel it had more memory in case 1.
>> 
>> Sorry, my mistake - I actually meant "vmalloc space is _smaller_ compared
>> to when a single mem=40M is passed" though the actual physical RAM
>> available is same in both the cases.
> 
> Again, that's expected.
> 
> We require a 1:1 relationship between virtual and physical addresses for
> efficiency - having non-linear translation means we'd need a lookup table,
> and as these translations are heavily used, that will impact
> performance.

Thanks for all the clarifications.

   Hemant
