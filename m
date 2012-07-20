From: johnhlinn@gmail.com (John Linn)
Date: Thu, 19 Jul 2012 21:10:39 -0700
Subject: are there PHYS_OFFSET alignment requirements for ARM Linux?
In-Reply-To: <alpine.LFD.2.02.1207191501330.9293@xanadu.home>
References: <CAB9O=CN_aDFTb7GVv++bMXPYS_RjEZe3NUeZY5uX1+mebTVKcA@mail.gmail.com>
 <alpine.LFD.2.02.1207191501330.9293@xanadu.home>
Message-ID: <CAB9O=CMKBSxYHvoqZKKDx=6H_NhLiQrPxU550A0Ny5i+YUCv3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2012 at 12:07 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Wed, 18 Jul 2012, John Linn wrote:
>
>> I have seen some mention of 2 MB alignment requirements, but it's not
>> clear to me if that's true or not (looks old)?
>>
>> My apologies if it's obvious somewhere, but are there any alignment
>> requirements?
>
> There is a 2MB alignment requirement on PHYS_OFFSET.  You may play
> tricks with memory reservation if a smaller offset is required, but I'd
> recommend against that.  Even 2MB is too small an alignment if you want
> to have CONFIG_ARM_PATCH_PHYS_VIRT=y (the default) which requires a 16MB
> alignment.
>

Thanks, it wasn't clear to me. If it's documented somewhere it would
be great to know where I overlooked it.

> It is very exceptional to see systems where RAM is not aligned to a much
> bigger boundary.  Why would you need a 2MB alignment?

Our DDR can be from anywhere from 0 to 1 GB address. Our platform
can't DMA to the lower 1MB and we have on chip memory (OCM) at 0.

We are currently starting DDR at 0, taking care of the DMA issue in
the kernel (kind of a pain) and moving OCM to higher address, but we'd
like to simplify our memory map so moving the start address of DDR to
1MB (or 2) would do that we were thinking.

I tested it at 1MB and it seemed fine with some simple boot testing,
but nothing exhaustive.  Sounds like a 2MB (rather than 1 MB) start
address would be wise.

Thanks,
John

>
>
> Nicolas
