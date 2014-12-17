From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 17 Dec 2014 22:04:24 +0300
Subject: DT on s3c24xx
Message-ID: <CA+E=qVf4nT5x-fRFBu=Wv_VKUnEMAEP4GgJG8em8NyUFkwtbPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'd like to port several s3c24xx to DT, and I'm stuck with s3c24xx LCD
controller and power drivers for H1940 and RX1950.

Please see [1]. I want to move this function into another LCD power
driver, but I'm not sure what to do with s3c_gpio_cfgpin(). I need to
change pin function in runtime, and as far as I understand it should
be handled via pinctrl driver somehow. But how?

Also please see [2] and [3]. s3c2410fb driver modifies gpio registers
(and pinmux, they're same block on s3c24xx) directly. What would be
best way to get rid of that?

Regards
Vasily

[1] https://github.com/anarsoul/linux-2.6/blob/v3.18-anarsoul-wip/arch/arm/mach-s3c24xx/mach-h1940.c#L599
[2] https://github.com/anarsoul/linux-2.6/blob/v3.18-anarsoul-wip/arch/arm/mach-s3c24xx/mach-h1940.c#L221
[3] https://github.com/anarsoul/linux-2.6/blob/v3.18-anarsoul-wip/drivers/video/fbdev/s3c2410fb.c#L709
