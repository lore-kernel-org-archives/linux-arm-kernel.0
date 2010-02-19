From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 19 Feb 2010 09:44:03 +0100
Subject: Alignment Requirement for MT_MEMORY type
In-Reply-To: <B125D8217ABC4B43826503DE00A2D44910F4639C3F@SJEXCHCCR01.corp.ad.broadcom.com>
References: <B125D8217ABC4B43826503DE00A2D44910F4639A8D@SJEXCHCCR01.corp.ad.broadcom.com>
	<20100218085125.GA848@n2100.arm.linux.org.uk>
	<B125D8217ABC4B43826503DE00A2D44910F4639C3F@SJEXCHCCR01.corp.ad.broadcom.com>
Message-ID: <63386a3d1002190044t6157e1d7ua70f188e3b8a5b93@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/2/18 Henry Li <hli@broadcom.com>:
> On Wed, Feb 17, 2010 at 04:33:00PM -0800, Henry Li wrote:
>>> Can someone tell me why there is a requirement for the virtual and
>>> physical addresses and size using MT_MEMORY memtype (where prot_l1=0)
>>> to be aligned to section boundary (1MB) in
>>> linux-2.6.32/arch/arm/mm/mmu.c/create_mapping
>>> during IO table init?

>> Because today SDRAM is always a whole number of MB, so its pointless
>> defining it in terms of 4K pages. ?MT_MEMORY is not for general purpose
>> use, but only for setting up the initial kernel SDRAM mapping.

> I see. The platform I am working with has 160kB of SRAM that I need
> to map as cacheable and shareable but its physical address is not 1MB
> aligned. ?Is there suitable memtype that I could use to map this?

I don't know just what you're trying to do, but is this some kind of
fast on-chip RAM, that's not in a separate capsule?

In that case you might want to examine the solution used for
the OMAP on-chip SRAM at:
arch/arm/plat-omap/sram.c
Or the solution we chose for the TCM memory close to the L1
caches in ARM systems:
arch/arm/kernel/tcm.c

Yours,
Linus Walleij
