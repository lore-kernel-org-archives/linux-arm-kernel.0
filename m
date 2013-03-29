From: mkl0301@gmail.com (Mac Lin)
Date: Fri, 29 Mar 2013 16:11:28 +0800
Subject: [PATCH 0/5] cns3xxx multiplatform support
In-Reply-To: <20130316165037.GA2522@lizard>
References: <1363299271-8283-1-git-send-email-arnd@arndb.de>
 <20130316165037.GA2522@lizard>
Message-ID: <CAK1hUK_KS9hz=tKkvhyOkXEXnr9MVGN73Vg6y3dhiUhN+ddD-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Anton,
2013/3/17 Anton Vorontsov <anton@enomsg.org>:
> Hi Arnd,
>
> On Thu, Mar 14, 2013 at 11:14:26PM +0100, Arnd Bergmann wrote:
>> I've looked at all the platforms recently to see what their
>> state is. cns3xxx seems quite clean but not very actively
>> maintained. Since it is really easy to convert to multiplatform,
>> that's what I did here. I'd like to apply this for linux-3.9
>> unless there are objections or other comments.
>
> I might have some old self-made QEMU emulator for CNS3xxx boards, but I am
> not sure if I could revive it quickly. Maybe Cavium folks could test it
> faster than me though (some Cc'ed, some Bcc'ed).
>
> But the patches themselves look great, so:
>
> Acked-by: Anton Vorontsov <anton@enomsg.org>
Sorry for the late response. I have not tested since 3.2, and it fail
booting almost right after 3.2....
It take me some time to be able to boot 3.9-rc1. I'll send the patch
in another mail.

The image of 3.9-rc1+the patches boots fine but with one warning which
is not seen without the patches:
NR_IRQS:16 nr_irqs:96 96
------------[ cut here ]------------
WARNING: at drivers/irqchip/irq-gic.c:782 gic_init_bases+0x284/0x2e8()
Cannot allocate irq_descs @ IRQ16, assuming pre-allocated
Modules linked in:
Backtrace:
[<c000c6f0>] (dump_backtrace+0x0/0x10c) from [<c01cf158>] (dump_stack+0x18/0x1c)
 r7:c028df40 r6:c027d39c r5:c023d888 r4:0000030e
[<c01cf140>] (dump_stack+0x0/0x1c) from [<c0016be0>] (warn_slowpath_common+0x54)
[<c0016b8c>] (warn_slowpath_common+0x0/0x70) from [<c0016ca0>] (warn_slowpath_f)
 r9:410fb024 r8:c02943b4 r7:00000050 r6:00000010 r5:00000010
r4:00000000
[<c0016c68>] (warn_slowpath_fmt+0x0/0x40) from [<c027d39c>] (gic_init_bases+0x2)
 r3:00000010 r2:c023d8d8
[<c027d118>] (gic_init_bases+0x0/0x2e8) from [<c0271aa8>] (cns3xxx_init_irq+0x3)
 r8:c0294000 r7:c02a4300 r6:ffffffff r5:c02849e8 r4:3fffffff
[<c0271a78>] (cns3xxx_init_irq+0x0/0x40) from [<c026d1bc>] (init_IRQ+0x1c/0x24)
[<c026d1a0>] (init_IRQ+0x0/0x24) from [<c026a800>] (start_kernel+0x164/0x2e4)
[<c026a69c>] (start_kernel+0x0/0x2e4) from [<00008070>] (0x8070)
 r8:00004008 r7:c02955ec r6:c02849e4 r5:c029408c r4:00c5387d
---[ end trace 1b75b31a2719ed1c ]---

I have my code pushed to https://github.com/mkl0301/linux.git, branch
cns3v20vb-3.9-multiplatform-test, in case you need them.

Best Regards,
Mac Lin
