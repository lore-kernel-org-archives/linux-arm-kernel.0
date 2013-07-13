From: B29397@freescale.com (Chen Peter-B29397)
Date: Sat, 13 Jul 2013 00:36:13 +0000
Subject: [PATCH v12 00/13] Add tested id switch and vbus connect detect
 support for Chipidea
In-Reply-To: <201307121518.31501.marex@denx.de>
References: <1373524041-10482-1-git-send-email-peter.chen@freescale.com>
 <201307120604.43642.marex@denx.de> <20130712082642.GB16202@nchen-desktop>
 <201307121518.31501.marex@denx.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803F46D18@039-SN2MPN1-022.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


 
> 
> Yes, ID interrupt (IDIE) is set.
> 
> I noticed this backtrace in the kernel bootlog, but this only happens if
> the
> dr_mode="otg" , it comes from the host-mode irq handler :
> 
> [    2.757563] irq 238: nobody cared (try booting with the "irqpoll"
> option)
> [    2.764398] CPU: 0 PID: 1 Comm: swapper Not tainted 3.10.0-
> next-20130711-00013-g011c4b3-dirty #703
> [    2.773445] [<80013878>] (unwind_backtrace+0x0/0xe8) from [<80011644>]
> (show_stack+0x10/0x14)
> [    2.782027] [<80011644>] (show_stack+0x10/0x14) from [<800659f4>]
> (__report_bad_irq.isra.6+0x20/0xe0)
> [    2.791286] [<800659f4>] (__report_bad_irq.isra.6+0x20/0xe0) from
> [<80065c98>] (note_interrupt+0x16c/0x230)
> [    2.801063] [<80065c98>] (note_interrupt+0x16c/0x230) from [<80064000>]
> (handle_irq_event_percpu+0x10c/0x1a4)
> [    2.811010] [<80064000>] (handle_irq_event_percpu+0x10c/0x1a4) from
> [<800640e8>] (handle_irq_event+0x50/0x78)
> [    2.820958] [<800640e8>] (handle_irq_event+0x50/0x78) from [<8006652c>]
> (handle_level_irq+0x88/0x10c)
> [    2.830210] [<8006652c>] (handle_level_irq+0x88/0x10c) from
> [<800638d0>]
> (generic_handle_irq+0x28/0x3c)
> [    2.839637] [<800638d0>] (generic_handle_irq+0x28/0x3c) from
> [<8000f84c>]
> (handle_IRQ+0x30/0x84)
> [    2.848461] [<8000f84c>] (handle_IRQ+0x30/0x84) from [<80012160>]
> (__irq_svc+0x40/0x6c)
> [    2.856510] [<80012160>] (__irq_svc+0x40/0x6c) from [<80022a44>]
> (__do_softirq+0x90/0x1d8)
> [    2.864812] [<80022a44>] (__do_softirq+0x90/0x1d8) from [<80022edc>]
> (irq_exit+0x98/0xd4)
> [    2.873025] [<80022edc>] (irq_exit+0x98/0xd4) from [<8000f850>]
> (handle_IRQ+0x34/0x84)
> [    2.880980] [<8000f850>] (handle_IRQ+0x34/0x84) from [<80012160>]
> (__irq_svc+0x40/0x6c)
> [    2.889020] [<80012160>] (__irq_svc+0x40/0x6c) from [<8001d724>]
> (vprintk_emit+0x1bc/0x524)
> [    2.897411] [<8001d724>] (vprintk_emit+0x1bc/0x524) from [<804da5a4>]
> (printk+0x30/0x40)
> [    2.905551] [<804da5a4>] (printk+0x30/0x40) from [<80630138>]
> (mousedev_init+0x4c/0x60)
> [    2.913617] [<80630138>] (mousedev_init+0x4c/0x60) from [<806178fc>]
> (do_one_initcall+0x94/0x14c)
> [    2.922537] [<806178fc>] (do_one_initcall+0x94/0x14c) from [<80617b20>]
> (kernel_init_freeable+0x16c/0x22c)
> [    2.932230] [<80617b20>] (kernel_init_freeable+0x16c/0x22c) from
> [<804d8cbc>]
> (kernel_init+0x8/0x150)
> [    2.941486] [<804d8cbc>] (kernel_init+0x8/0x150) from [<8000ea70>]
> (ret_from_fork+0x14/0x24)
> [    2.949932] handlers:
> [    2.952227] [<8033fc58>] ci_irq
> [    2.955388] Disabling IRQ #238
> 

See this " Disabling IRQ #238", that is the reason you can't get
ID interrupt.

I have no other idea before I try, you can try below things:

1. please switch VDD 5V SOURCE SELECT to USB 5V
2. try not plug in mouse during the boots up

> btw. do you have any kind of other CI13xxx documentation than what's in
> the CPU
> datasheets ?
> 

Mx28 RM does not include many controller detail, please try to 
read it from mx6/mx5 RM.

Best regards,
Peter
 
