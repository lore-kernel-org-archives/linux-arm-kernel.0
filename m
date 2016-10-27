From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 27 Oct 2016 09:30:32 +0200
Subject: [PATCH] Revert "gpio/mvebu: convert to use
 irq_domain_add_simple()"
In-Reply-To: <CACRpkdatYim3=tKeO-E1GazB7RV9XPdE-EBQs+FW+DrryATzRA@mail.gmail.com>
 (Linus Walleij's message of "Mon, 24 Oct 2016 01:11:23 +0200")
References: <1476831396-24359-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <871szcerxl.fsf@free-electrons.com>
 <20161019210341.GA3746@obsidianresearch.com>
 <CACRpkdatYim3=tKeO-E1GazB7RV9XPdE-EBQs+FW+DrryATzRA@mail.gmail.com>
Message-ID: <87twbyb65j.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
 
 On lun., oct. 24 2016, Linus Walleij <linus.walleij@linaro.org> wrote:

> On Wed, Oct 19, 2016 at 11:03 PM, Jason Gunthorpe
> <jgunthorpe@obsidianresearch.com> wrote:
>
>> From 7566f05ac445b652ba7607cc1899fed10fea1c76 Mon Sep 17 00:00:00 2001
>> From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
>> Date: Wed, 19 Oct 2016 14:57:45 -0600
>> Subject: [PATCH] gpio/mvebu: Use irq_domain_add_linear
>>
>> This fixes the irq allocation in this driver to not print:
>>  irq: Cannot allocate irq_descs @ IRQ34, assuming pre-allocated
>>  irq: Cannot allocate irq_descs @ IRQ66, assuming pre-allocated
>>
>> Which happens because the driver already called irq_alloc_descs()
>> and so the change to use irq_domain_add_simple resulted in calling
>> irq_alloc_descs() twice.
>>
>> Modernize the irq allocation in this driver to use the
>> irq_domain_add_linear flow directly and eliminate the use of
>> irq_domain_add_simple/legacy
>>
>> Fixes: ce931f571b6d ("gpio/mvebu: convert to use irq_domain_add_simple()")
>> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
>
> So can I just apply this?
> Gregory?

For me it's OK.

Gregory

>
> Yours,
> Linus Walleij

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
