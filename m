From: vichy.kuo@gmail.com (vichy)
Date: Sun, 16 Nov 2014 18:53:57 +0800
Subject: some question about TCR setting
In-Reply-To: <20141114135531.GA27768@leverpostej>
References: <CAOVJa8HBYkTMCJFKC=+UwjgPp4odm5UV-oUQXu17ctv2+HkpRg@mail.gmail.com>
 <20141114104246.GA25828@leverpostej>
 <CAOVJa8Fx4yiSU0O7HTaYEKOrRdtWve4JGeN0cWRXDsBMyV_8Mg@mail.gmail.com>
 <20141114135531.GA27768@leverpostej>
Message-ID: <CAOVJa8GB=pk4SFEArcEGWF8g12105F_9YUL0hH5k+WW6=WWOBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Mark:

> Consider CONFIG_HIGHPTE. The physical address space can be larger than
> the virtual address space, in which case not everything can be
> permanently mapped.
if those page tables are not mapped into the virtual address space,
how OS create them?
(AFAIK, once System.M is enabled, the processor cannot access where
page table doesn't map to)
except those page tables are created before System.M enabled.

>
>> 3. if the {SH,ORGN,IRGN}{1,0} of block/page descriptor is conflict
>> with that one in TCR. Will that make cache maintenance issue.
>
> If page tables are accessed with different attributes from those used to
> walk them (i.e. those programmed into the TCR), the usual coherency
> issues would apply.
BTW, why we need to set page table walk attribute as sharable and
inner/outer cacheable?
Does that mean if core0's page table doesn't contain physical address
0x200000, but core1's page table did and set its attribute as
sharable.
Core0 can access this area without page fault?

Sincerely appreciate your kind help,
