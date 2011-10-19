From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Thu, 20 Oct 2011 02:55:19 +0530
Subject: Getting random Kernel Crash with v3.1-rc8 kernel
In-Reply-To: <19F8576C6E063C45BE387C64729E739406C100F885@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E739406C100F885@dbde02.ent.ti.com>
Message-ID: <19F8576C6E063C45BE387C64729E739406C100F909@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Thanks,
Vaibhav
> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Hiremath, Vaibhav
> Sent: Wednesday, October 19, 2011 8:24 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: linux at arm.linux.org.uk
> Subject: Getting random Kernel Crash with v3.1-rc8 kernel
> 
> Hi,
> 
> I am getting random kernel crash, and it always crashes with "Internal
>  error: Oops - undefined instruction: 0 [#1]".
> There could be some stack corruption or race condition in the kernel,
> which I am currently debugging on (running out of options).
> 
> The funny part is,
>         - If I add some line of code (totally unrelated to this crash) and
> crash goes away.
>         - With filesystem on NFS, MMC card (non HS card) and NAND, the
> crash
> is very well reproducible (almost 60% success).
>         - With ramdisk, the kernel crash is not observed.
>         - The default CPU is freq is 600MHz, if I reduce it to 500Mhz,
> crash
> goes away.
> 
> 
<snip>
> [    1.594594] CPSW phy found : id is : 0x4dd074
> [    1.601482] PHY 0:01 not found
> [    2.130539] Internal error: Oops - undefined instruction: 0 [#1]
> [    2.136818] Modules linked in:
> [    2.140017] CPU: 0    Not tainted  (3.1.0-rc8-11589-gbb7fe4f-dirty #4)
> [    2.146838] PC is at 0xc05b71e8
> [    2.150134] LR is at run_timer_softirq+0xf8/0x208
> [    2.155050] pc : [<c05b71e8>]    lr : [<c0040980>]    psr: a0000113
> [    2.155059] sp : c055be68  ip : c05c96f4  fp : c055beac
> [    2.167049] r10: c05b680c  r9 : 00000100  r8 : 00200200
> [    2.172506] r7 : c055a000  r6 : ba8c4f60  r5 : c05b6000  r4 : c055be78
> [    2.179325] r3 : c05b637c  r2 : c05b636c  r1 : 00000000  r0 : c05b637c
> [    2.186146] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
> Segment kernel
> [    2.193785] Control: 10c5387d  Table: 80004019  DAC: 00000015
> [    2.199779] Process swapper (pid: 0, stack limit = 0xc055a2f0)
> [    2.205863] Stack: (0xc055be68 to 0xc055c000)
> [    2.210414] be60:                   00000000 00000000 c05b637c c05b7ff8
> c05c96f4 c781de70
> [    2.218958] be80: c05b7ff4 00000001 c05b5e88 c055a000 00000100 c05b5e40
> c0576f48 c05b5e84
> [    2.227503] bea0: c055bef4 c055beb0 c003ad54 c0040894 c055bf74 80004059
> 413fc082 00000001
> [    2.236059] bec0: c0577154 0000000a c0069360 c055a000 00000043 00000000
> c055bf74 80004059
> [    2.244611] bee0: 413fc082 00000000 c055bf0c c055bef8 c003b1c4 c003acb4
> c006ac78 c0588aa4
> [    2.253162] bf00: c055bf2c c055bf10 c00145c8 c003b144 c0014714 c0014718
> 60000013 fa200000
> [    2.261714] bf20: c055bf3c c055bf30 c0008190 c0014590 c055bf94 c055bf40
> c00132f4 c000818c
> [    2.270270] bf40: 7d2bcf2e 00000000 c055bf88 00000000 c055a000 c05a4744
> c056021c c0560214
> [    2.278825] bf60: 80004059 413fc082 00000000 c055bf94 c055bf98 c055bf88
> c0014714 c0014718
> [    2.287378] bf80: 60000013 ffffffff c055bfb4 c055bf98 c00148d8 c00146f8
> 00000000 c055c0ac
> [    2.295933] bfa0: c054bbec c06d1500 c055bfc4 c055bfb8 c03e07c4 c0014870
> c055bff4 c055bfc8
> [    2.304483] bfc0: c05237d8 c03e075c c05231ac 00000000 00000000 c054bbec
> 00000000 10c53c7d
> [    2.313029] bfe0: c055c040 c054bbe8 00000000 c055bff8 8000803c c0523520
> 00000000 00000000
> [    2.321567] Backtrace:
> [    2.324146] [<c0040888>] (run_timer_softirq+0x0/0x208) from
> [<c003ad54>] (__do_softirq+0xac/0x134)
> [    2.333524] [<c003aca8>] (__do_softirq+0x0/0x134) from [<c003b1c4>]
> (irq_exit+0x8c/0xa4)
> [    2.342004] [<c003b138>] (irq_exit+0x0/0xa4) from [<c00145c8>]
> (handle_IRQ+0x44/0x8c)
> [    2.350184]  r4:c0588aa4 r3:c006ac78
> [    2.353936] [<c0014584>] (handle_IRQ+0x0/0x8c) from [<c0008190>]
> (asm_do_IRQ+0x10/0x14)
> [    2.362294]  r6:fa200000 r5:60000013 r4:c0014718 r3:c0014714
> [    2.368234] [<c0008180>] (asm_do_IRQ+0x0/0x14) from [<c00132f4>]
> (__irq_svc+0x34/0x80)
> [    2.376507] Exception stack(0xc055bf40 to 0xc055bf88)
> [    2.381789] bf40: 7d2bcf2e 00000000 c055bf88 00000000 c055a000 c05a4744
> c056021c c0560214
> [    2.390339] bf60: 80004059 413fc082 00000000 c055bf94 c055bf98 c055bf88
> c0014714 c0014718
> [    2.398874] bf80: 60000013 ffffffff
> [    2.402522] [<c00146ec>] (default_idle+0x0/0x30) from [<c00148d8>]
> (cpu_idle+0x74/0xa0)
> [    2.410905] [<c0014864>] (cpu_idle+0x0/0xa0) from [<c03e07c4>]
> (rest_init+0x74/0x78)
> [    2.418997]  r6:c06d1500 r5:c054bbec r4:c055c0ac r3:00000000
> [    2.424950] [<c03e0750>] (rest_init+0x0/0x78) from [<c05237d8>]
> (start_kernel+0x2c4/0x2d0)
> [    2.433592] [<c0523514>] (start_kernel+0x0/0x2d0) from [<8000803c>]
> (0x8000803c)
> [    2.441315]  r6:c054bbe8 r5:c055c040 r4:10c53c7d
> [    2.446156] Code: 00000100 c05b6001 c0049608 c05b70b0 (ffffffff)
> [    2.452552] ---[ end trace 010eec470f78ac9d ]---
> [    2.457377] Kernel panic - not syncing: Fatal exception in interrupt
> [    2.464023] Backtrace:
> [    2.466602] [<c0016e40>] (dump_backtrace+0x0/0x110) from [<c03e8d88>]
> (dump_stack+0x18/0x1c)
> [    2.475434]  r6:00000001 r5:00000000 r4:c05a5508 r3:c05770c8
> [    2.481384] [<c03e8d70>] (dump_stack+0x0/0x1c) from [<c03e8df8>]
> (panic+0x6c/0x1a0)
> [    2.489397] [<c03e8d8c>] (panic+0x0/0x1a0) from [<c0017270>]
> (die+0x268/0x2bc)
> [    2.496953]  r3:00000100 r2:00000000 r1:00000000 r0:c04aba68
> [    2.502895]  r7:c055bd32
> [    2.505548] [<c0017008>] (die+0x0/0x2bc) from [<c00172e4>]
> (arm_notify_die+0x20/0x58)
> [    2.513749] [<c00172c4>] (arm_notify_die+0x0/0x58) from [<c00082d0>]
> (do_undefinstr+0x13c/0x154)
> [    2.522950] [<c0008194>] (do_undefinstr+0x0/0x154) from [<c0013388>]
> (__und_svc+0x48/0x60)
> [    2.531602] Exception stack(0xc055be20 to 0xc055be68)
> [    2.536888] be20: c05b637c 00000000 c05b636c c05b637c c055be78 c05b6000
> ba8c4f60 c055a000
> [    2.545452] be40: 00200200 00000100 c05b680c c055beac c05c96f4 c055be68
> c0040980 c05b71e8
> [    2.554009] be60: a0000113 ffffffff
> [    2.557651]  r7:00000001 r6:c055a050 r5:a0000113 r4:c05b71ec
> [    2.563607] [<c0040888>] (run_timer_softirq+0x0/0x208) from
> [<c003ad54>] (__do_softirq+0xac/0x134)
> [    2.572992] [<c003aca8>] (__do_softirq+0x0/0x134) from [<c003b1c4>]
> (irq_exit+0x8c/0xa4)
> [    2.581466] [<c003b138>] (irq_exit+0x0/0xa4) from [<c00145c8>]
> (handle_IRQ+0x44/0x8c)
> [    2.589645]  r4:c0588aa4 r3:c006ac78
> [    2.593404] [<c0014584>] (handle_IRQ+0x0/0x8c) from [<c0008190>]
> (asm_do_IRQ+0x10/0x14)
> [    2.601780]  r6:fa200000 r5:60000013 r4:c0014718 r3:c0014714
> [    2.607727] [<c0008180>] (asm_do_IRQ+0x0/0x14) from [<c00132f4>]
> (__irq_svc+0x34/0x80)
> [    2.616014] Exception stack(0xc055bf40 to 0xc055bf88)
> [    2.621297] bf40: 7d2bcf2e 00000000 c055bf88 00000000 c055a000 c05a4744
> c056021c c0560214
> [    2.629833] bf60: 80004059 413fc082 00000000 c055bf94 c055bf98 c055bf88
> c0014714 c0014718
> [    2.638390] bf80: 60000013 ffffffff
> [    2.642054] [<c00146ec>] (default_idle+0x0/0x30) from [<c00148d8>]
> (cpu_idle+0x74/0xa0)
> [    2.650432] [<c0014864>] (cpu_idle+0x0/0xa0) from [<c03e07c4>]
> (rest_init+0x74/0x78)
> [    2.658541]  r6:c06d1500 r5:c054bbec r4:c055c0ac r3:00000000
> [    2.664502] [<c03e0750>] (rest_init+0x0/0x78) from [<c05237d8>]
> (start_kernel+0x2c4/0x2d0)
> [    2.673164] [<c0523514>] (start_kernel+0x0/0x2d0) from [<8000803c>]
> (0x8000803c)
> [    2.680909]  r6:c054bbe8 r5:c055c040 r4:10c53c7d
> 
> 
After further debugging I observed that somehow mod_timer is not setting expiry timeout value passed. From USB driver we are trying to set 2S timeout value, which doesn't get configured properly -

Usage of mod_timer -

ret = mod_timer(&otg_workaround, jiffies + msecs_to_jiffies(2000));

Timer expiry log just before and after the mod_timer -

[    2.133559] otg_timer:603 state - 1
[    2.137224] otg_timer:659 expires - 4294937708
[    2.141892] otg_timer:666 expires - 4294937709

Due to this, I observed that, the execution goes crazy in function 
"run_timer_softirq", it always stays in the inner loop -

while (!list_empty(head)) {
	...

	call_timer_fn(timer, fn, data);

	...
}


Funny part is, I observed that, when kernel crashes, it would have in contiguous look inside this function and sometime later it crashes.

I am quite not sure why mod_probe is not setting right expiry timeout values, does anybody has any pointers with this? 
Just to check, I created dummy driver to test setup_timer/mod_timer/del_timer and they are working fine for me. So I wouldn't expect any issues with timer per se...

Any pointers are greatly appreciated.

> Thanks,
> Vaibhav
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
