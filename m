From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed,  9 Nov 2011 10:47:20 +0800
Subject: [PATCH v7 00/11] change pxa gpio to platform driver
Message-ID: <1320806851-13928-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog
v7:
    1. add clk_prepare() support in gpio-pxa.c.
v6:
    1. fix build issue in pxa910 since building gpio failure is found in
       mainline.
    2. merge two dependant patches (original v5 0005 and 0006) together.
    3. fix gpio bit issue in corgi and spitz.
    4. replace printk() with dev_err in clk patch.
v5:
    1. use generic gpio driver. So clean gpio-pxa.h and gpio-pxa.c again.
v4:
    1. append one patch for clean gpio macros and use function instead.
v3:
    1. Rebase on Russell's for-next branch.
    2. Add clock support.
    3. Move gpio edge detection initiliaztion of arch-mmp into gpio driver.

v2:
   1. Remove gpio.c from mach-pxa & mach-mmp that is introduced from v1.
   2. Remove init function in gpio.c. Move the platfrom_device_register()
      into platform driver.
   3. Initialize pxa_gpio_regs in gpio-pxa.c
   4. Simplify code of identifing pxa gpio series or mmp gpio series.
   5. Use linux/io.h instead of asm/io.h.
