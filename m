From: olof@lixom.net (Olof Johansson)
Date: Wed, 16 May 2012 14:17:46 -0700
Subject: [GIT PULL][for 3.5] clk-next update
In-Reply-To: <201205162052.46513.arnd@arndb.de>
References: <20120516063552.GA5154@gmail.com>
 <201205161839.03269.arnd@arndb.de>
 <CAOesGMh6w9gHwwn5MJ7MSkP9S-2RmjrwOtj77RfCMpBrEtupDg@mail.gmail.com>
 <201205162052.46513.arnd@arndb.de>
Message-ID: <CAOesGMhwSKLVLVCSSo17FyqJ1FmyTb=NkkbvV0-KGZ69_us9MQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 1:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 16 May 2012, Olof Johansson wrote:
>>
>> Are you planning on sending the last couple of fixes out before
>> wrapping things up? If I haven't seen a request go out by tomorrow
>> I'll do it, I suppose.
>
> I was planning to, but it's getting rather late here in Germany
> so maybe you can take care of this, too.

Sure.

> I've just fixed up two of the next/* branches that caused build regressions
> (one was my fault, the other one came from samsung/board2) and started
> building the defconfigs for linux-next, which looks rather bad, so I probably
> won't spend much time trying to fix them up, see below for how far I got.

Hmm. The _errors_ i get with next-0516 isn't nearly that bad but I
think you build with -Werror?

What I see here with last night's build is below. Some of these have
been broken for a very long time (ixp4xx for example).

buildall.arm.at91_dt_defconfig.log.failed:drivers/usb/gadget/at91_udc.c:478:18:
error: 'struct at91_ep' has no member named 'desc'
buildall.arm.ezx_defconfig.log.failed:drivers/mfd/ezx-pcap.c:205:2:
error: implicit declaration of function 'irq_to_gpio'
[-Werror=implicit-function-declaration]
buildall.arm.ixp4xx_defconfig.log.failed:include/asm-generic/gpio.h:218:2:
error: implicit declaration of function '__gpio_get_value'
[-Werror=implicit-function-declaration]
buildall.arm.ixp4xx_defconfig.log.failed:include/asm-generic/gpio.h:224:2:
error: implicit declaration of function '__gpio_set_value'
[-Werror=implicit-function-declaration]
buildall.arm.ixp4xx_defconfig.log.failed:include/asm-generic/gpio.h:218:2:
error: implicit declaration of function '__gpio_get_value'
[-Werror=implicit-function-declaration]
buildall.arm.ixp4xx_defconfig.log.failed:include/asm-generic/gpio.h:224:2:
error: implicit declaration of function '__gpio_set_value'
[-Werror=implicit-function-declaration]
buildall.arm.ixp4xx_defconfig.log.failed:include/asm-generic/gpio.h:218:2:
error: implicit declaration of function '__gpio_get_value'
[-Werror=implicit-function-declaration]
buildall.arm.ixp4xx_defconfig.log.failed:include/asm-generic/gpio.h:224:2:
error: implicit declaration of function '__gpio_set_value'
[-Werror=implicit-function-declaration]
buildall.arm.ixp4xx_defconfig.log.failed:include/asm-generic/gpio.h:218:2:
error: implicit declaration of function '__gpio_get_value'
[-Werror=implicit-function-declaration]
buildall.arm.ixp4xx_defconfig.log.failed:include/asm-generic/gpio.h:224:2:
error: implicit declaration of function '__gpio_set_value'
[-Werror=implicit-function-declaration]
buildall.arm.ixp4xx_defconfig.log.failed:include/asm-generic/gpio.h:218:2:
error: implicit declaration of function '__gpio_get_value'
[-Werror=implicit-function-declaration]
buildall.arm.ixp4xx_defconfig.log.failed:include/asm-generic/gpio.h:224:2:
error: implicit declaration of function '__gpio_set_value'
[-Werror=implicit-function-declaration]
buildall.arm.kota2_defconfig.log.failed:arch/arm/mach-shmobile/platsmp.c:29:2:
error: implicit declaration of function 'of_machine_is_compatible'
[-Werror=implicit-function-declaration]
buildall.arm.kzm9g_defconfig.log.failed:arch/arm/mach-shmobile/platsmp.c:29:2:
error: implicit declaration of function 'of_machine_is_compatible'
[-Werror=implicit-function-declaration]
buildall.arm.marzen_defconfig.log.failed:arch/arm/mach-shmobile/platsmp.c:29:2:
error: implicit declaration of function 'of_machine_is_compatible'
[-Werror=implicit-function-declaration]
buildall.arm.marzen_defconfig.log.failed:fs/inode.c:1775:6: error:
redefinition of 'inode_dio_wait'
buildall.arm.mv78xx0_defconfig.log.failed:arch/arm/mach-mv78xx0/pcie.c:256:29:
error: 'bus' undeclared (first use in this function)
buildall.arm.netx_defconfig.log.failed:arch/arm/mach-netx/fb.c:72:6:
error: redefinition of 'clk_disable'
buildall.arm.netx_defconfig.log.failed:arch/arm/mach-netx/fb.c:76:5:
error: redefinition of 'clk_set_rate'
buildall.arm.netx_defconfig.log.failed:arch/arm/mach-netx/fb.c:81:5:
error: redefinition of 'clk_enable'
buildall.arm.netx_defconfig.log.failed:arch/arm/mach-netx/fb.c:86:13:
error: redefinition of 'clk_get'
buildall.arm.netx_defconfig.log.failed:arch/arm/mach-netx/fb.c:91:6:
error: redefinition of 'clk_put'
buildall.arm.prima2_defconfig.log.failed:drivers/spi/spi-sirf.c:563:2:
error: implicit declaration of function 'pinmux_get'
[-Werror=implicit-function-declaration]
buildall.arm.prima2_defconfig.log.failed:drivers/spi/spi-sirf.c:568:2:
error: implicit declaration of function 'pinmux_enable'
[-Werror=implicit-function-declaration]
buildall.arm.prima2_defconfig.log.failed:drivers/spi/spi-sirf.c:602:2:
error: implicit declaration of function 'pinmux_disable'
[-Werror=implicit-function-declaration]
buildall.arm.prima2_defconfig.log.failed:drivers/spi/spi-sirf.c:603:2:
error: implicit declaration of function 'pinmux_put'
[-Werror=implicit-function-declaration]
buildall.arm.raumfeld_defconfig.log.failed:drivers/input/touchscreen/eeti_ts.c:65:2:
error: implicit declaration of function 'irq_to_gpio'
[-Werror=implicit-function-declaration]
buildall.arm.tegra_defconfig.log.failed:drivers/iommu/tegra-smmu.c:930:2:
error: implicit declaration of function 'of_get_dma_window'
[-Werror=implicit-function-declaration]
buildall.arm.xcep_defconfig.log.failed:fs/inode.c:1775:6: error:
redefinition of 'inode_dio_wait'
buildall.arm.xcep_defconfig.log.failed:fs/nfs/direct.c:459:2: error:
implicit declaration of function 'inode_dio_done'
[-Werror=implicit-function-declaration]


-Olof
