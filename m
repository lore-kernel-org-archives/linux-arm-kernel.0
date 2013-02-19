From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 19 Feb 2013 15:37:12 +0100
Subject: Kernel panic in imx-drm driver
In-Reply-To: <20130219140026.GA23123@S2101-09.ap.freescale.net>
References: <20130219140026.GA23123@S2101-09.ap.freescale.net>
Message-ID: <1361284632.4350.11.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Am Dienstag, den 19.02.2013, 22:00 +0800 schrieb Shawn Guo:
> I'm running into the following kernel panic with next-20130215 on
> imx51.  Is it a known issue?

The patch "staging: imx/drm: request irq only after adding the crtc"
which I've just resent should fix this issue:

https://patchwork.kernel.org/patch/1951311

regards
Philipp

> Shawn
> 
> [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
> [drm] No driver support for vblank timestamp query.
> [drm] Initialized imx-drm 1.0.0 20120507 on minor 0
> mmc0: new high speed SDHC card at address 97c8
> imx-ipuv3 40000000.ipu: IPUv3EX probed
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000c
> pgd = 80004000
> [0000000c] *pgd=00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Modules linked in:
> CPU: 0    Not tainted  (3.8.0-rc7-next-20130215+ #347)
> PC is at imx_drm_handle_vblank+0xc/0x20
> LR is at ipu_irq_handler+0x1c/0xd8
> pc : [<8040c448>]    lr : [<80410ea8>]    psr: 40000193
> sp : 9f855b28  ip : 9f855b38  fp : 9f855b34
> r10: 9fa6a840  r9 : 80759494  r8 : 00000127
> r7 : 00000000  r6 : 9fa5f010  r5 : 00000001  r4 : 9fa72880
> r3 : 80410e8c  r2 : 00000006  r1 : 9fa5f010  r0 : 00000000
> Flags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 10c5387d  Table: 90004019  DAC: 00000017
> Process swapper/0 (pid: 1, stack limit = 0x9f854238)
> Stack: (0x9f855b28 to 0x9f856000)
> 5b20:                   9f855b64 9f855b38 80410ea8 8040c448 8075b51c
> 9f855d3c
> 5b40: 60000193 9fa72880 00000001 00000000 00000000 00000127 9f855b9c
> 9f855b68
> 5b60: 80073314 80410e98 9f855bb4 9f855b78 800268fc 9fa6a840 00000001
> 00000000
> 5b80: 9fa78810 00000000 00000017 00000009 9f855bb4 9f855ba0 800734ac
> 800732cc
> 5ba0: 9fa6a840 00000001 9f855bcc 9f855bb8 80075f98 80073468 00000127
> 9f855c28
> 5bc0: 9f855be4 9f855bd0 80072c80 80075ef4 00000007 00000110 9f855c1c
> 9f855be8
> 5be0: 8040d484 80072c64 802621d4 00800000 9f855c1c 9f805480 9fa78810
> 9f80cdb4
> 5c00: 0000001b 00000000 9fa6a870 00000000 9f855c64 9f855c20 8040d5c8
> 8040d3fc
> 5c20: 00000000 00000000 00000001 00000002 00000003 0000000a 0000000b
> 0000000c
> 5c40: 0000000d 0000000e 9f855c64 0000001b 8070bd30 9f854000 9f855c7c
> 9f855c68
> 5c60: 80072c80 8040d56c 000001b0 80716bc0 9f855ca4 9f855c80 8000ee74
> 80072c64
> 5c80: 00000010 00000000 80759fd4 00000000 00000001 9f855cd0 9f855ccc
> 9f855ca8
> 5ca0: 80008548 8000ee2c 8052e0b0 60000113 ffffffff 9f855d04 00000127
> 60000113
> 5cc0: 9f855d24 9f855cd0 8000e100 800084dc 9fa6a890 60000113 00000005
> 00000000
> 5ce0: 9fa6a840 9fa72880 9fa6a890 9fa5f010 00000127 9fa6a870 60000113
> 9f855d24
> 5d00: 9f855d28 9f855d18 80074970 8052e0b0 60000113 ffffffff 9f855d64
> 9f855d28
> 5d20: 80074970 8052e090 801218e4 800bdb24 0000336e 000080d0 9f855d54
> 9fa72880
> 5d40: 9fa6a840 80410e8c 9fa5f010 00000000 00000000 00000127 9f855d94
> 9f855d68
> 5d60: 80074c74 800747b0 00000000 9fa72850 00000127 80410e8c 9fa69410
> 00000000
> 5d80: 806c220c 9fa5f010 9f855dc4 9f855d98 80076b7c 80074bc4 80682db0
> 9fa5f010
> 5da0: 9fa67fc0 9fa5f010 9fa78810 9fa69410 80750368 80759580 9f855df4
> 9f855dc8
> 5dc0: 804108ec 80076b2c 00000000 80682db0 9fa5f010 80122e5c 807a8a40
> 80750368
> 5de0: 9fa69410 00000000 9f855e04 9f855df8 802e4ebc 804107e0 9f855e2c
> 9f855e08
> 5e00: 802e3b00 802e4ea8 00000000 9fa69410 80750368 9fa69444 00000000
> 000000a7
> 5e20: 9f855e4c 9f855e30 802e3ca8 802e3a14 802e3c14 80750368 802e3c14
> 00000000
> 5e40: 9f855e74 9f855e50 802e2238 802e3c20 9f834158 9fa665b4 9f83416c
> 80750368
> 5e60: 8073f1e8 9fa66680 9f855e84 9f855e78 802e3628 802e21e8 9f855eb4
> 9f855e88
> 5e80: 802e31c0 802e3614 80682d14 00000000 9f855eb4 80750368 00000006
> 00000000
> 5ea0: 80759580 000000a7 9f855edc 9f855eb8 802e41d0 802e30ec 9f854000
> 00000006
> 5ec0: 00000000 80759580 000000a7 80759580 9f855eec 9f855ee0 802e50e0
> 802e415c
> 5ee0: 9f855efc 9f855ef0 806ec350 802e50a0 9f855f54 9f855f00 80008710
> 806ec348
> 5f00: 9f855f54 9f855f10 806ec33c 00000000 00000000 00000006 00000006
> 806bf89c
> 5f20: 00000000 80675bd4 9f855f54 806febe0 00000006 806febc0 80759580
> 000000a7
> 5f40: 806c220c 8070a968 9f855f94 9f855f58 806c297c 800086dc 00000006
> 00000006
> 5f60: 806c220c 00000000 00000000 00000000 80523550 00000000 00000000
> 00000000
> 5f80: 00000000 00000000 9f855fac 9f855f98 80523560 806c2884 ffffffff
> 00000000
> 5fa0: 00000000 9f855fb0 8000e618 8052355c 00000000 00000000 00000000
> 00000000
> 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000
> 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000
> 00000000
> Backtrace:
> [<8040c43c>] (imx_drm_handle_vblank+0x0/0x20) from [<80410ea8>]
> (ipu_irq_handler+0x1c/0xd8)
> [<80410e8c>] (ipu_irq_handler+0x0/0xd8) from [<80073314>]
> (handle_irq_event_percpu+0x54/0x19c)
>  r8:00000127 r7:00000000 r6:00000000 r5:00000001 r4:9fa72880
> [<800732c0>] (handle_irq_event_percpu+0x0/0x19c) from [<800734ac>]
> (handle_irq_event+0x50/0x70)
> [<8007345c>] (handle_irq_event+0x0/0x70) from [<80075f98>]
> (handle_level_irq+0xb0/0x124)
>  r5:00000001 r4:9fa6a840
> [<80075ee8>] (handle_level_irq+0x0/0x124) from [<80072c80>]
> (generic_handle_irq+0x28/0x38)
>  r5:9f855c28 r4:00000127
> [<80072c58>] (generic_handle_irq+0x0/0x38) from [<8040d484>]
> (ipu_irq_handle+0x94/0xc4)
>  r4:00000110 r3:00000007
> [<8040d3f0>] (ipu_irq_handle+0x0/0xc4) from [<8040d5c8>]
> (ipu_irq_handler+0x68/0xbc)
> [<8040d560>] (ipu_irq_handler+0x0/0xbc) from [<80072c80>]
> (generic_handle_irq+0x28/0x38)
>  r6:9f854000 r5:8070bd30 r4:0000001b
> [<80072c58>] (generic_handle_irq+0x0/0x38) from [<8000ee74>]
> (handle_IRQ+0x54/0xb4)
>  r4:80716bc0 r3:000001b0
> [<8000ee20>] (handle_IRQ+0x0/0xb4) from [<80008548>]
> (tzic_handle_irq+0x78/0xa8)
>  r8:9f855cd0 r7:00000001 r6:00000000 r5:80759fd4 r4:00000000
> r3:00000010
> [<800084d0>] (tzic_handle_irq+0x0/0xa8) from [<8000e100>]
> (__irq_svc+0x40/0x54)
> Exception stack(0x9f855cd0 to 0x9f855d18)
> 5cc0:                                     9fa6a890 60000113 00000005
> 00000000
> 5ce0: 9fa6a840 9fa72880 9fa6a890 9fa5f010 00000127 9fa6a870 60000113
> 9f855d24
> 5d00: 9f855d28 9f855d18 80074970 8052e0b0 60000113 ffffffff
> [<8052e084>] (_raw_spin_unlock_irqrestore+0x0/0x30) from [<80074970>]
> (__setup_irq+0x1cc/0x414)
> [<800747a4>] (__setup_irq+0x0/0x414) from [<80074c74>]
> (request_threaded_irq+0xbc/0x140)
> [<80074bb8>] (request_threaded_irq+0x0/0x140) from [<80076b7c>]
> (devm_request_threaded_irq+0x5c/0x90
> )
> [<80076b20>] (devm_request_threaded_irq+0x0/0x90) from [<804108ec>]
> (ipu_drm_probe+0x118/0x1f0)
> [<804107d4>] (ipu_drm_probe+0x0/0x1f0) from [<802e4ebc>]
> (platform_drv_probe+0x20/0x24)
>  r7:00000000 r6:9fa69410 r5:80750368 r4:807a8a40
> [<802e4e9c>] (platform_drv_probe+0x0/0x24) from [<802e3b00>]
> (driver_probe_device+0xf8/0x20c)
> [<802e3a08>] (driver_probe_device+0x0/0x20c) from [<802e3ca8>]
> (__driver_attach+0x94/0x98)
>  r8:000000a7 r7:00000000 r6:9fa69444 r5:80750368 r4:9fa69410
> r3:00000000
> [<802e3c14>] (__driver_attach+0x0/0x98) from [<802e2238>]
> (bus_for_each_dev+0x5c/0x90)
>  r6:00000000 r5:802e3c14 r4:80750368 r3:802e3c14
> [<802e21dc>] (bus_for_each_dev+0x0/0x90) from [<802e3628>]
> (driver_attach+0x20/0x28)
>  r6:9fa66680 r5:8073f1e8 r4:80750368
> [<802e3608>] (driver_attach+0x0/0x28) from [<802e31c0>]
> (bus_add_driver+0xe0/0x234)
> [<802e30e0>] (bus_add_driver+0x0/0x234) from [<802e41d0>]
> (driver_register+0x80/0x14c)
>  r8:000000a7 r7:80759580 r6:00000000 r5:00000006 r4:80750368
> [<802e4150>] (driver_register+0x0/0x14c) from [<802e50e0>]
> (platform_driver_register+0x4c/0x60)
> [<802e5094>] (platform_driver_register+0x0/0x60) from [<806ec350>]
> (ipu_drm_driver_init+0x14/0x1c)
> [<806ec33c>] (ipu_drm_driver_init+0x0/0x1c) from [<80008710>]
> (do_one_initcall+0x40/0x184)
> [<800086d0>] (do_one_initcall+0x0/0x184) from [<806c297c>]
> (kernel_init_freeable+0x104/0x1d0)
> [<806c2878>] (kernel_init_freeable+0x0/0x1d0) from [<80523560>]
> (kernel_init+0x10/0xec)
> [<80523550>] (kernel_init+0x0/0xec) from [<8000e618>]
> (ret_from_fork+0x14/0x3c)
>  r4:00000000 r3:ffffffff
> Code: e89da800 e1a0c00d e92dd800 e24cb004 (e590300c)
> ---[ end trace b72e3418b526b7f3 ]---
> Kernel panic - not syncing: Fatal exception in interrupt
> 
> 
