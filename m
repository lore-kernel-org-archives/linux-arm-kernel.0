From: schnitzeltony@gmx.de (Andreas Mueller)
Date: Tue, 21 Jun 2011 16:16:28 +0200
Subject: mach-mxs pwm implementation question
Message-ID: <201106211616.28872.schnitzeltony@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

For a karo tx28 (freescale imx28 or mach-mxs) I try to build a kernel 2.6.39.1 
with LCD backlight enabled and get

| drivers/built-in.o: In function `pwm_backlight_suspend':
| clkdev.c:(.text+0xfe38): undefined reference to `pwm_config'
| clkdev.c:(.text+0xfe40): undefined reference to `pwm_disable'
| drivers/built-in.o: In function `pwm_backlight_remove':
| clkdev.c:(.text+0xfe84): undefined reference to `pwm_config'
| clkdev.c:(.text+0xfe8c): undefined reference to `pwm_disable'
| clkdev.c:(.text+0xfe94): undefined reference to `pwm_free'
| drivers/built-in.o: In function `pwm_backlight_update_status':
| clkdev.c:(.text+0xff14): undefined reference to `pwm_config'
| clkdev.c:(.text+0xff1c): undefined reference to `pwm_disable'
| clkdev.c:(.text+0xff48): undefined reference to `pwm_config'
| clkdev.c:(.text+0xff50): undefined reference to `pwm_enable'
| drivers/built-in.o: In function `pwm_backlight_probe':
| clkdev.c:(.text+0x10020): undefined reference to `pwm_request'
| clkdev.c:(.text+0x100a0): undefined reference to `pwm_free'

I saw in [1] that there was an attempt to create a pwm-framework with mxs 
implementation as example but it did not find its way to mainline because of a 
better pwm framework already available ( rejected implemetation still can be 
downloaded at karo website ). Before trying to do myself: Is anybody working on 
a implementation fitting linux/pwm.h?

Regards

Andreas

[1] https://lkml.org/lkml/2011/1/28/91
