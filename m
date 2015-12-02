From: peda@lysator.liu.se (Peter Rosin)
Date: Wed, 02 Dec 2015 20:29:35 +0100
Subject: Regression, was [PATCH 4/4] USB: host: ohci-at91: merge loops
 in ohci_hcd_at91_drv_probe
In-Reply-To: <20151202182002.GF22136@piout.net>
References: <565DD61C.5010904@lysator.liu.se>
 <20151202182002.GF22136@piout.net>
Message-ID: <565F469F.9000004@lysator.liu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On 2015-12-02 19:20, Alexandre Belloni wrote:
> Hi Peter,
> 
> On 01/12/2015 at 18:17:16 +0100, Peter Rosin wrote :
>> [<c02f5084>] (ohci_hcd_at91_overcurrent_irq) from [<c00433b0>] (handle_irq_event_percpu+0x78/0x140)
>> [<c00433b0>] (handle_irq_event_percpu) from [<c00434a4>] (handle_irq_event+0x2c/0x40)
>> [<c00434a4>] (handle_irq_event) from [<c00458b8>] (handle_simple_irq+0x6c/0x80)
>> [<c00458b8>] (handle_simple_irq) from [<c0042bc4>] (generic_handle_irq+0x2c/0x3c)
>> [<c0042bc4>] (generic_handle_irq) from [<c01fe4ac>] (gpio_irq_handler+0xa4/0x12c)
>> [<c01fe4ac>] (gpio_irq_handler) from [<c0042bc4>] (generic_handle_irq+0x2c/0x3c)
>> [<c0042bc4>] (generic_handle_irq) from [<c0042dec>] (__handle_domain_irq+0x54/0xa8)
>> [<c0042dec>] (__handle_domain_irq) from [<c0013500>] (__irq_svc+0x40/0x54)
>> [<c0013500>] (__irq_svc) from [<c004451c>] (__setup_irq+0x248/0x530)
>> [<c004451c>] (__setup_irq) from [<c0044954>] (request_threaded_irq+0xc4/0x144)
>> [<c0044954>] (request_threaded_irq) from [<c02f5a0c>] (ohci_hcd_at91_drv_probe+0x460/0x518)
>> [<c02f5a0c>] (ohci_hcd_at91_drv_probe) from [<c02670ec>] (platform_drv_probe+0x44/0xa4)
>> [<c02670ec>] (platform_drv_probe) from [<c02655b4>] (driver_probe_device+0x1fc/0x43c)
>> [<c02655b4>] (driver_probe_device) from [<c0265880>] (__driver_attach+0x8c/0x90)
>> [<c0265880>] (__driver_attach) from [<c0263880>] (bus_for_each_dev+0x6c/0xa0)
>> [<c0263880>] (bus_for_each_dev) from [<c0264b80>] (bus_add_driver+0x1d0/0x268)
>> [<c0264b80>] (bus_add_driver) from [<c0266078>] (driver_register+0x78/0xf8)
>> [<c0266078>] (driver_register) from [<c00096c8>] (do_one_initcall+0xb8/0x1f0)
>> [<c00096c8>] (do_one_initcall) from [<c068bda4>] (kernel_init_freeable+0x138/0x1d8)
>> [<c068bda4>] (kernel_init_freeable) from [<c04d06f4>] (kernel_init+0x8/0xe8)
>> [<c04d06f4>] (kernel_init) from [<c000ff68>] (ret_from_fork+0x14/0x2c)
>> Code: e5916058 e1a08000 e3a04000 e2865008 (e5b50004)
>> ---[ end trace e66fbc480972ac43 ]---
>> Kernel panic - not syncing: Fatal exception in interrupt
>> ---[ end Kernel panic - not syncing: Fatal exception in interrupt
> 
> I think I understood what happens. Can you try the following patch?

Seems to work here. Excellent!

> 8<------
> From 402f8444bc92d218edc63dcc3c87459981a56c31 Mon Sep 17 00:00:00 2001
> From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Date: Wed, 2 Dec 2015 18:49:34 +0100
> Subject: [PATCH] USB: host: ohci-at91: fix a crash in
>  ohci_hcd_at91_overcurrent_irq
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Reported-by: Peter Rosin <peda@axentia.se>
Tested-by: Peter Rosin <peda@axentia.se>

(and bisected-by if anyone cares...)

Cheers,
Peter
