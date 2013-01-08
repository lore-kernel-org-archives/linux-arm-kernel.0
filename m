From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 8 Jan 2013 14:41:25 -0200
Subject: [PATCH 7/7] ARM i.MX51 babbage: Add display support
In-Reply-To: <1352733809-27230-8-git-send-email-s.hauer@pengutronix.de>
References: <1352733809-27230-1-git-send-email-s.hauer@pengutronix.de>
 <1352733809-27230-8-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CAOMZO5BnFZs+s-WFahtqyzCi15P9RBzKDzwdZNCJ4PmnQrFY1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, Nov 12, 2012 at 1:23 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> The babbage board has a DVI-I output which allows to output analog
> and digital signals simultaneously. This patch adds support for it
> to the devicetree. The DDC signals are not wired up on the board, so
> DRM will fall back on default VESA modes.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

I am running linux-next 20130108, which has this patch applied and I
get the following on my mx51babbage:

[drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[drm] No driver support for vblank timestamp query.
[drm] Initialized imx-drm 1.0.0 20120507 on minor 0
imx-ipuv3 40000000.ipu: DI0 base: 0x5e040000 remapped to a08aa000
imx-ipuv3 40000000.ipu: DI1 base: 0x5e048000 remapped to a08ac000
imx-ipuv3 40000000.ipu: IPUv3EX probed
Unable to handle kernel NULL pointer dereference at virtual address 0000000c
pgd = 80004000
[0000000c] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0    Not tainted  (3.8.0-rc2-next-20130108+ #996)
PC is at imx_drm_handle_vblank+0xc/0x20
LR is at ipu_irq_handler+0x1c/0xe0
pc : [<803f97b8>]    lr : [<803fe5f0>]    psr: 40000193
sp : 9f855b20  ip : 9f855b30  fp : 9f855b2c
r10: 9fa69600  r9 : 8070d39a  r8 : 00000127
r7 : 00000000  r6 : 9fa5f010  r5 : 9fa69650  r4 : 9fa701c0
r3 : 803fe5d4  r2 : 9fa69650  r1 : 9fa5f010  r0 : 00000000
Flags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 90004019  DAC: 00000017
Process swapper/0 (pid: 1, stack limit = 0x9f854238)
Stack: (0x9f855b20 to 0x9f856000)
5b20: 9f855b5c 9f855b30 803fe5f0 803f97b8 9f854000 002012d0 9f855bd4 9fa701c0
5b40: 9fa69650 00000000 00000000 00000127 9f855b94 9f855b60 8006ed8c 803fe5e0
5b60: 0003a980 00000000 00000000 9fa69600 9fa69650 00000001 9fa78c10 00000000
5b80: 00000017 00000009 9f855bac 9f855b98 8006ef34 8006ed44 9fa69600 9fa69650
5ba0: 9f855bcc 9f855bb0 80071ac4 8006eee0 80071a10 00000127 9f855c28 00000000
5bc0: 9f855be4 9f855bd0 8006e6e4 80071a1c 00000007 00000110 9f855c1c 9f855be8
5be0: 803fabb0 8006e6c8 80258e7c 00800000 9f855c1c 9f805480 9fa78c10 9f80cdb4
5c00: 0000001b 00000000 9fa69630 00000000 9f855c64 9f855c20 803facf4 803fab28
5c20: 00000000 00000000 00000001 00000002 00000003 0000000a 0000000b 0000000c
5c40: 0000000d 0000000e 9f855c64 0000001b 806cfe08 9f854000 9f855c7c 9f855c68
5c60: 8006e6e4 803fac98 000001b0 806db178 9f855ca4 9f855c80 8000ede8 8006e6c8
5c80: 00000010 00000000 8070dca0 00000000 00000001 9f855cd0 9f855ccc 9f855ca8
5ca0: 800085ac 8000eda0 80515b44 60000113 ffffffff 9f855d04 00000127 60000113
5cc0: 9f855d24 9f855cd0 8000e080 80008540 9fa69650 60000113 00050005 00000000
5ce0: 9fa69600 9fa701c0 9fa69650 00000000 00000127 9fa69630 60000113 9f855d24
5d00: 00000000 9f855d18 80070418 80515b44 60000113 ffffffff 9f855d64 9f855d28
5d20: 80070418 80515b18 8011565c 800af4e4 00003278 000080d0 9f855d54 9fa701c0
5d40: 9fa69600 9fa5f010 00000000 803fe5d4 00000000 00000127 9f855d94 9f855d68
5d60: 80070720 80070258 00000000 9fa70190 00000127 803fe5d4 9fa64410 00000000
5d80: 8069220c 9fa5f010 9f855dc4 9f855d98 80072690 8007066c 806556fc 9fa5f010
5da0: 9fa68940 9fa5f010 9fa78c10 9fa64410 807057a4 8070d480 9f855df4 9f855dc8
5dc0: 803fe038 80072640 00000000 806556fc 9fa5f010 80116c14 8075c080 807057a4
5de0: 9fa64410 00000000 9f855e04 9f855df8 802d8e38 803fdf2c 9f855e2c 9f855e08
5e00: 802d79b0 802d8e24 00000000 9fa64410 807057a4 9fa64444 00000000 000000a4
5e20: 9f855e4c 9f855e30 802d7bc8 802d7944 802d7b34 807057a4 802d7b34 00000000
5e40: 9f855e74 9f855e50 802d6128 802d7b40 9f833158 9fa658b4 80257848 807057a4
5e60: 806f3e10 9fa65980 9f855e84 9f855e78 802d7558 802d60dc 9f855eb4 9f855e88
5e80: 802d7174 802d7544 8065563c 8070d480 9f855eb4 807057a4 00000006 00000000
5ea0: 8070d480 000000a4 9f855edc 9f855eb8 802d8110 802d7008 9f854000 00000006
5ec0: 00000000 8070d480 000000a4 8070d480 9f855eec 9f855ee0 802d905c 802d809c
5ee0: 9f855efc 9f855ef0 806b2618 802d901c 9f855f54 9f855f00 800086b8 806b2610
5f00: 9f855f54 9f855f10 806b2604 00000000 00000000 00000006 00000006 8068f8f8
5f20: 00000000 806489fc 9f855f54 806c43e0 00000006 806c43c0 8070d480 000000a4
5f40: 8069220c 806ce9a8 9f855f94 9f855f58 80692978 80008684 00000006 00000006
5f60: 8069220c 00000000 00000000 00000000 8050b0bc 00000000 00000000 00000000
5f80: 00000000 00000000 9f855fac 9f855f98 8050b0cc 80692880 ffffffff 00000000
5fa0: 00000000 9f855fb0 8000e598 8050b0c8 00000000 00000000 00000000 00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
Backtrace:
[<803f97ac>] (imx_drm_handle_vblank+0x0/0x20) from [<803fe5f0>]
(ipu_irq_handler+0x1c/0xe0)
[<803fe5d4>] (ipu_irq_handler+0x0/0xe0) from [<8006ed8c>]
(handle_irq_event_percpu+0x54/0x19c)
 r8:00000127 r7:00000000 r6:00000000 r5:9fa69650 r4:9fa701c0
[<8006ed38>] (handle_irq_event_percpu+0x0/0x19c) from [<8006ef34>]
(handle_irq_event+0x60/0x80)
[<8006eed4>] (handle_irq_event+0x0/0x80) from [<80071ac4>]
(handle_level_irq+0xb4/0x134)
 r5:9fa69650 r4:9fa69600
[<80071a10>] (handle_level_irq+0x0/0x134) from [<8006e6e4>]
(generic_handle_irq+0x28/0x38)
 r6:00000000 r5:9f855c28 r4:00000127 r3:80071a10
[<8006e6bc>] (generic_handle_irq+0x0/0x38) from [<803fabb0>]
(ipu_irq_handle+0x94/0xc4)
 r4:00000110 r3:00000007
[<803fab1c>] (ipu_irq_handle+0x0/0xc4) from [<803facf4>]
(ipu_irq_handler+0x68/0xbc)
[<803fac8c>] (ipu_irq_handler+0x0/0xbc) from [<8006e6e4>]
(generic_handle_irq+0x28/0x38)
 r6:9f854000 r5:806cfe08 r4:0000001b
[<8006e6bc>] (generic_handle_irq+0x0/0x38) from [<8000ede8>]
(handle_IRQ+0x54/0xb4)
 r4:806db178 r3:000001b0
[<8000ed94>] (handle_IRQ+0x0/0xb4) from [<800085ac>] (tzic_handle_irq+0x78/0xa8)
 r8:9f855cd0 r7:00000001 r6:00000000 r5:8070dca0 r4:00000000
r3:00000010
[<80008534>] (tzic_handle_irq+0x0/0xa8) from [<8000e080>] (__irq_svc+0x40/0x54)
Exception stack(0x9f855cd0 to 0x9f855d18)
5cc0:                                     9fa69650 60000113 00050005 00000000
5ce0: 9fa69600 9fa701c0 9fa69650 00000000 00000127 9fa69630 60000113 9f855d24
5d00: 00000000 9f855d18 80070418 80515b44 60000113 ffffffff
[<80515b0c>] (_raw_spin_unlock_irqrestore+0x0/0x3c) from [<80070418>]
(__setup_irq+0x1cc/0x414)
[<8007024c>] (__setup_irq+0x0/0x414) from [<80070720>]
(request_threaded_irq+0xc0/0x158)
[<80070660>] (request_threaded_irq+0x0/0x158) from [<80072690>]
(devm_request_threaded_irq+0x5c/0x90)
[<80072634>] (devm_request_threaded_irq+0x0/0x90) from [<803fe038>]
(ipu_drm_probe+0x118/0x1ec)
[<803fdf20>] (ipu_drm_probe+0x0/0x1ec) from [<802d8e38>]
(platform_drv_probe+0x20/0x24)
 r7:00000000 r6:9fa64410 r5:807057a4 r4:8075c080
[<802d8e18>] (platform_drv_probe+0x0/0x24) from [<802d79b0>]
(driver_probe_device+0x78/0x1fc)
[<802d7938>] (driver_probe_device+0x0/0x1fc) from [<802d7bc8>]
(__driver_attach+0x94/0x98)
 r8:000000a4 r7:00000000 r6:9fa64444 r5:807057a4 r4:9fa64410
r3:00000000
[<802d7b34>] (__driver_attach+0x0/0x98) from [<802d6128>]
(bus_for_each_dev+0x58/0x84)
 r6:00000000 r5:802d7b34 r4:807057a4 r3:802d7b34
[<802d60d0>] (bus_for_each_dev+0x0/0x84) from [<802d7558>]
(driver_attach+0x20/0x28)
 r6:9fa65980 r5:806f3e10 r4:807057a4
[<802d7538>] (driver_attach+0x0/0x28) from [<802d7174>]
(bus_add_driver+0x178/0x248)
[<802d6ffc>] (bus_add_driver+0x0/0x248) from [<802d8110>]
(driver_register+0x80/0x14c)
 r8:000000a4 r7:8070d480 r6:00000000 r5:00000006 r4:807057a4
[<802d8090>] (driver_register+0x0/0x14c) from [<802d905c>]
(platform_driver_register+0x4c/0x60)
[<802d9010>] (platform_driver_register+0x0/0x60) from [<806b2618>]
(ipu_drm_driver_init+0x14/0x1c)
[<806b2604>] (ipu_drm_driver_init+0x0/0x1c) from [<800086b8>]
(do_one_initcall+0x40/0x184)
[<80008678>] (do_one_initcall+0x0/0x184) from [<80692978>]
(kernel_init_freeable+0x104/0x1cc)
[<80692874>] (kernel_init_freeable+0x0/0x1cc) from [<8050b0cc>]
(kernel_init+0x10/0xec)
[<8050b0bc>] (kernel_init+0x0/0xec) from [<8000e598>] (ret_from_fork+0x14/0x3c)
 r4:00000000 r3:ffffffff
Code: e89da800 e1a0c00d e92dd800 e24cb004 (e590300c)
---[ end trace d806e2933ab4f47d ]---
Kernel panic - not syncing: Fatal exception in interrupt

Any suggestions as to how to make mx51babbage display something out of
the DVI port?

Thanks,

Fabio Estevam
