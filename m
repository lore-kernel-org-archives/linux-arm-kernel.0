From: Frank.Li@freescale.com (Frank Li)
Date: Fri, 9 Nov 2012 16:34:36 +0800
Subject: [PATCH 1/1] regulator: gpio-regulator: fix crash when no states
 property in dt
Message-ID: <1352450076-22682-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unable to handle kernel NULL pointer dereference at virtual address 00000004
pgd = 80004000
[00000004] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0    Not tainted  (3.5.7+ #11)
PC is at of_get_gpio_regulator_config+0x1b0/0x2e0
LR is at of_find_property+0x4c/0x9c
pc : [<8022498c>]    lr : [<80322d44>]    psr: 60000013
sp : bf859de8  ip : bf859dc8  fp : bf859e14
r10: 805d1180  r9 : 8053e208  r8 : 00000001
r7 : 811056ec  r6 : 00000000  r5 : bf8e0208  r4 : bf8f2b50
r3 : 805a7e00  r2 : 000000d0  r1 : 00000000  r0 : 00000000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 1000404a  DAC: 00000017
Process swapper/0 (pid: 1, stack limit = 0xbf8582f0)
Stack: (0xbf859de8 to 0xbf85a000)
9de0:                   bf859e34 bf859df8 8010a040 00000000 bf8e0200 811056ec
9e00: 00000000 805b4d9c bf859e54 bf859e18 80404a14 802247e8 00000000 00000000
9e20: 00000000 00000000 00000000 00000000 00000000 00000000 8061f05c 805b4d9c
9e40: bf8e0208 00000000 bf859e64 bf859e58 8024bc0c 804049e0 bf859e8c bf859e68
9e60: 8024a7d8 8024bbf8 00000000 bf8e0208 805b4d9c bf8e023c 00000000 0000008d
9e80: bf859eac bf859e90 8024a9dc 8024a76c 8024a948 805b4d9c 8024a948 00000000
9ea0: bf859ed4 bf859eb0 80248f10 8024a954 bf83b458 bf8dd934 801f13e0 805b4d9c
9ec0: 805b8af8 bf8e9f00 bf859ee4 bf859ed8 8024a358 80248ec4 bf859f14 bf859ee8
9ee0: 80249f94 8024a344 804eb244 805d1180 805b4d9c 00000004 00000000 805d1180
9f00: 0000008d 805d1180 bf859f3c bf859f18 8024aefc 80249e1c 00000000 bf858000
9f20: 00000004 00000000 805d1180 0000008d bf859f4c bf859f40 8024bedc 8024ae88
9f40: bf859f5c bf859f50 805600b4 8024be9c bf859fb4 bf859f60 800086e4 805600ac
9f60: bf859fb4 bf859f70 805600a0 00000000 00000000 00000004 00000004 8053cb20
9f80: 00000000 804c9788 bf859fb4 805770a0 00000004 80577080 805d1180 0000008d
9fa0: 8053e208 805827a4 bf859ff4 bf859fb8 8053e974 800086b0 00000004 00000004
9fc0: 8053e208 8053e870 80026750 00000000 8053e870 80026750 00000013 00000000
9fe0: 00000000 00000000 00000000 bf859ff8 80026750 8053e87c 9773f7a7 ed28dffe
Backtrace:
[<802247dc>] (of_get_gpio_regulator_config+0x0/0x2e0) from [<80404a14>] (gpio_regulator_probe+0x40/0x2f0)
 r8:805b4d9c r7:00000000 r6:811056ec r5:bf8e0200 r4:00000000
[<804049d4>] (gpio_regulator_probe+0x0/0x2f0) from [<8024bc0c>] (platform_drv_probe+0x20/0x24)
 r7:00000000 r6:bf8e0208 r5:805b4d9c r4:8061f05c
[<8024bbec>] (platform_drv_probe+0x0/0x24) from [<8024a7d8>] (driver_probe_device+0x78/0x1e8)
[<8024a760>] (driver_probe_device+0x0/0x1e8) from [<8024a9dc>] (__driver_attach+0x94/0x98)
 r8:0000008d r7:00000000 r6:bf8e023c r5:805b4d9c r4:bf8e0208
 r3:00000000
[<8024a948>] (__driver_attach+0x0/0x98) from [<80248f10>] (bus_for_each_dev+0x58/0x84)
 r6:00000000 r5:8024a948 r4:805b4d9c r3:8024a948
[<80248eb8>] (bus_for_each_dev+0x0/0x84) from [<8024a358>] (driver_attach+0x20/0x28)
 r6:bf8e9f00 r5:805b8af8 r4:805b4d9c
[<8024a338>] (driver_attach+0x0/0x28) from [<80249f94>] (bus_add_driver+0x184/0x250)
[<80249e10>] (bus_add_driver+0x0/0x250) from [<8024aefc>] (driver_register+0x80/0x134)
[<8024ae7c>] (driver_register+0x0/0x134) from [<8024bedc>] (platform_driver_register+0x4c/0x60)
 r8:0000008d r7:805d1180 r6:00000000 r5:00000004 r4:bf858000
 r3:00000000
[<8024be90>] (platform_driver_register+0x0/0x60) from [<805600b4>] (gpio_regulator_init+0x14/0x1c)
[<805600a0>] (gpio_regulator_init+0x0/0x1c) from [<800086e4>] (do_one_initcall+0x40/0x184)
[<800086a4>] (do_one_initcall+0x0/0x184) from [<8053e974>] (kernel_init+0x104/0x1c8)
[<8053e870>] (kernel_init+0x0/0x1c8) from [<80026750>] (do_exit+0x0/0x7fc)
Code: e3a02000 e1a00007 eb03f8db e3a020d0 (e5903004)

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 drivers/regulator/gpio-regulator.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index e467d0a..b51e757 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -183,7 +183,7 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np)
 
 	/* Fetch states. */
 	prop = of_find_property(np, "states", NULL);
-	proplen = prop->length / sizeof(int);
+	proplen = prop ? prop->length / sizeof(int) : 0;
 
 	config->states = devm_kzalloc(dev,
 				sizeof(struct gpio_regulator_state)
-- 
1.7.1
