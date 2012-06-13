From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 12 Jun 2012 21:41:13 -0300
Subject: mx51evk kernel dump on next-20120612
Message-ID: <CAOMZO5ARiGCVWgVeY-xzKcxPkXJjL-fYZEAmq=k=3gaT=_HDoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On a mx51evk running 3.5.0-rc2-next-20120612 I am getting:

pinctrl core: initialized pinctrl subsystem
------------[ cut here ]------------
WARNING: at include/linux/regmap.h:391 regulator_register+0xf8c/0x1128()
regmap API is disabled
Modules linked in:
Backtrace:
[<80012510>] (dump_backtrace+0x0/0x10c) from [<80413ee0>] (dump_stack+0x18/0x1c)
 r7:00000009 r6:00000187 r5:8022f7cc r4:9f84dd30
[<80413ec8>] (dump_stack+0x0/0x1c) from [<80021ac0>]
(warn_slowpath_common+0x54/0x6c)
[<80021a6c>] (warn_slowpath_common+0x0/0x6c) from [<80021b7c>]
(warn_slowpath_fmt+0x38/0x40)
 r9:805d2c1f r8:8061f778 r7:9f84de04 r6:9f803c08 r5:805b78f8
r4:9f803e00
[<80021b44>] (warn_slowpath_fmt+0x0/0x40) from [<8022f7cc>]
(regulator_register+0xf8c/0x1128)
 r3:00000000 r2:804e7f40
[<8022e840>] (regulator_register+0x0/0x1128) from [<804090a4>]
(dummy_regulator_probe+0x48/0x80)
[<8040905c>] (dummy_regulator_probe+0x0/0x80) from [<80257330>]
(platform_drv_probe+0x20/0x24)
 r6:9f803c08 r5:805b78bc r4:80620a5c
[<80257310>] (platform_drv_probe+0x0/0x24) from [<80255e74>]
(driver_probe_device+0x80/0x1f0)
[<80255df4>] (driver_probe_device+0x0/0x1f0) from [<80256078>]
(__driver_attach+0x94/0x98)
 r9:8057d904 r8:0000008e r7:00000000 r6:9f803c3c r5:805b78bc
r4:9f803c08
[<80255fe4>] (__driver_attach+0x0/0x98) from [<80254630>]
(bus_for_each_dev+0x68/0x94)
 r7:00000000 r6:80255fe4 r5:9f84de90 r4:805b78bc
[<802545c8>] (bus_for_each_dev+0x0/0x94) from [<80255cd4>]
(driver_attach+0x20/0x28)
 r7:00000000 r6:9f86e400 r5:805bb770 r4:805b78bc
[<80255cb4>] (driver_attach+0x0/0x28) from [<80254f54>]
(bus_add_driver+0x18c/0x268)
[<80254dc8>] (bus_add_driver+0x0/0x268) from [<802566a8>]
(driver_register+0x80/0x134)
[<80256628>] (driver_register+0x0/0x134) from [<802576d8>]
(platform_driver_register+0x4c/0x60)
 r7:00000000 r6:805d2cc0 r5:8061f768 r4:8061f774
[<8025768c>] (platform_driver_register+0x0/0x60) from [<8055b9a8>]
(regulator_dummy_init+0x60/0x98)
[<8055b948>] (regulator_dummy_init+0x0/0x98) from [<8055b798>]
(regulator_init+0x68/0x8c)
 r5:8061f768 r4:00000000
[<8055b730>] (regulator_init+0x0/0x8c) from [<800086a4>]
(do_one_initcall+0x40/0x194)
 r5:00000002 r4:9f84c000
[<80008664>] (do_one_initcall+0x0/0x194) from [<805393f4>]
(kernel_init+0xfc/0x1cc)
[<805392f8>] (kernel_init+0x0/0x1cc) from [<80026b40>] (do_exit+0x0/0x81c)
---[ end trace 1b75b31a2719ed1c ]---
dummy:

Before I start to investigate this: is this a known issue?

Thanks,

Fabio Estevam
