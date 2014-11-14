From: vichy.kuo@gmail.com (vichy)
Date: Fri, 14 Nov 2014 21:13:12 +0800
Subject: some question about TCR setting
In-Reply-To: <20141114104246.GA25828@leverpostej>
References: <CAOVJa8HBYkTMCJFKC=+UwjgPp4odm5UV-oUQXu17ctv2+HkpRg@mail.gmail.com>
 <20141114104246.GA25828@leverpostej>
Message-ID: <CAOVJa8Fx4yiSU0O7HTaYEKOrRdtWve4JGeN0cWRXDsBMyV_8Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Mark:
> The CPU can't read the attributes from the page tables, because in order
> to do so it would need to know the attributes to access the page tables
> with. Additionally, the page tables might not always be mapped into the
> virtual address space.
Per your explanation, if the page table base address in TTBR is
0x1000000, {SH,ORGN,IRGN}{1,0} tell cpu how to access this part of
physical address, right?

if so, I have some questions:
1. The processor use {SH,ORGN,IRGN}{1,0} in TCR to access all the
following page directories?
2. under what circumstance, the page tables might not always be mapped
into the virtual address space.
3. if the {SH,ORGN,IRGN}{1,0} of block/page descriptor is conflict
with that one in TCR. Will that make cache maintenance issue. Or there
are separate cache for page table walking?

Sincerely appreciate your kind help,
