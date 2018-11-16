From: pintu.ping@gmail.com (Pintu Agarwal)
Date: Fri, 16 Nov 2018 23:13:48 +0530
Subject: [ARM64] Printing IRQ stack usage information
In-Reply-To: <5997.1542386778@turing-police.cc.vt.edu>
References: <CAOuPNLiLj9be5iUdpUiLqiTge-xYY_v4_VLs-ah2_PygG7vxdg@mail.gmail.com>
 <28496.1542300549@turing-police.cc.vt.edu>
 <CAOuPNLj8wj=tPJo8L3oS7o8iTQcyhZ0W-GH6xmP_GsG4r7YdAQ@mail.gmail.com>
 <49219.1542367988@turing-police.cc.vt.edu>
 <CAOuPNLg4tM6Cw8Yf9rdpkBOU=+Fh654yFQeAhJf1y88Gb3MAew@mail.gmail.com>
 <5997.1542386778@turing-police.cc.vt.edu>
Message-ID: <CAOuPNLiX0zhxiRAx03YjVU6cocwWbgY9naxeYPRKmT+3PoGhRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 10:16 PM <valdis.kletnieks@vt.edu> wrote:
>
> On Fri, 16 Nov 2018 20:10:28 +0530, Pintu Agarwal said:
>
> > > Look at the code controlled by '#ifdef CONFIG_DEBUG_STACK_USAGE'
>
> > For example: is it possible to keep storing the irq_stack_usage (for
> > each cpu in a variable) information from boot time, and then use this
> > variable to dump the irq_stack information, after the system booted,
> > may be from proc entry ?
>
> Congrats. You just re-invented DEBUG_STACK_USAGE, which just keeps a high-water mark
> for stack usage.

So, you mean to say, my implementation is good enough to get the
irq_stack usage, from the interrupt handler ?
But my concern is that if I dump it from irq handler, I will get
information only for the current cpu.
How do I store and get the information for all the cpu from the boot time ?
>From where do I call my dump_irq_stack_info() [some where during the
entry/exit part of the irq handler], so that I could dump information
for all the handler at boot time itself ?
Like I would to capture these information:
- What was the name of the handler ?
- Which cpu was executing it ?
- How much irq stack (max value, same like high water mark) were used
at that time ?

Where can I collect these information from the boot time ?


Thanks,
Pintu
