From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 15 Sep 2011 00:39:07 -0300
Subject: gpio_ensure_requested error on mx31pdk boot
Message-ID: <CAOMZO5AmM2yd5FopjNO9QsPNLZiBNH3U29_xXPV3cnZnB9EjtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On a MX31PDK running 3.1-rc3 from Pengutronix's imx-features branch I
get the following:

Registering mxc_nand as whole device
------------[ cut here ]------------
WARNING: at drivers/gpio/gpiolib.c:101 gpio_ensure_requested+0x4c/0xf4()
autorequest GPIO-0
Modules linked in:
[<c0014410>] (unwind_backtrace+0x0/0xf4) from [<c0025754>] (warn_slowpath_common
+0x4c/0x64)
[<c0025754>] (warn_slowpath_common+0x4c/0x64) from [<c0025800>] (warn_slowpath_f
mt+0x30/0x40)
[<c0025800>] (warn_slowpath_fmt+0x30/0x40) from [<c0198688>] (gpio_ensure_reques
ted+0x4c/0xf4)
[<c0198688>] (gpio_ensure_requested+0x4c/0xf4) from [<c01988c8>] (gpio_direction
_output+0xa0/0x138)
[<c01988c8>] (gpio_direction_output+0xa0/0x138) from [<c01ed198>] (spi_imx_setup
+0x38/0x4c)
[<c01ed198>] (spi_imx_setup+0x38/0x4c) from [<c01eb5d0>] (spi_setup+0x38/0x50)
[<c01eb5d0>] (spi_setup+0x38/0x50) from [<c01eb85c>] (spi_add_device+0x94/0x124)
[<c01eb85c>] (spi_add_device+0x94/0x124) from [<c01eb960>] (spi_new_device+0x74/
0xac)
[<c01eb960>] (spi_new_device+0x74/0xac) from [<c01eb9b8>] (spi_match_master_to_b
oardinfo+0x20/0x40)
[<c01eb9b8>] (spi_match_master_to_boardinfo+0x20/0x40) from [<c01eba88>] (spi_re
gister_master+0xb0/0x104)
[<c01eba88>] (spi_register_master+0xb0/0x104) from [<c01ec0b4>] (spi_bitbang_sta
rt+0x104/0x17c)
[<c01ec0b4>] (spi_bitbang_start+0x104/0x17c) from [<c02c2c4c>] (spi_imx_probe+0x
2fc/0x404)
[<c02c2c4c>] (spi_imx_probe+0x2fc/0x404) from [<c01c2498>] (platform_drv_probe+0
x18/0x1c)
[<c01c2498>] (platform_drv_probe+0x18/0x1c) from [<c01c1058>] (driver_probe_devi
ce+0x78/0x174)
[<c01c1058>] (driver_probe_device+0x78/0x174) from [<c01c11e0>] (__driver_attach
+0x8c/0x90)
[<c01c11e0>] (__driver_attach+0x8c/0x90) from [<c01c0860>] (bus_for_each_dev+0x6
0/0x8c)
[<c01c0860>] (bus_for_each_dev+0x60/0x8c) from [<c01c0088>] (bus_add_driver+0xa0
/0x288)
[<c01c0088>] (bus_add_driver+0xa0/0x288) from [<c01c179c>] (driver_register+0x78
/0x18c)
[<c01c179c>] (driver_register+0x78/0x18c) from [<c0008490>] (do_one_initcall+0x3
4/0x178)
[<c0008490>] (do_one_initcall+0x34/0x178) from [<c03a5204>] (kernel_init+0x74/0x
118)
[<c03a5204>] (kernel_init+0x74/0x118) from [<c000f65c>] (kernel_thread_exit+0x0/
0x8)
---[ end trace 759f924b30fd5a44 ]---

I have not started debugging yet, but just wondering if anyone else
has seen this.

Regards,

Fabio Estevam
