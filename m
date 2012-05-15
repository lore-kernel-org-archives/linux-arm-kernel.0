From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 May 2012 09:25:17 +0000
Subject: [GIT PULL][for 3.5] pull request of board-specific branch in
 arch-pxa git tree
In-Reply-To: <CAN1soZzgO7yKfPM8wx9-8i85iq1OW=FxfjRFsOpGd4A_eiyqDQ@mail.gmail.com>
References: <CAN1soZzgO7yKfPM8wx9-8i85iq1OW=FxfjRFsOpGd4A_eiyqDQ@mail.gmail.com>
Message-ID: <201205150925.17477.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 May 2012, Haojian Zhuang wrote:
> Neil Zhang (4):
>       ARM: mmp: add usb device support for PXA910
>       ARM: mmp: add usb device support for ttc dkb
>       ARM: mmp: add usb host support for PXA168
>       ARM: mmp: add usb host support for aspen
> 
> Paul Parsons (5):
>       ARM: pxa: hx4700: Initialize DS1WM clock_rate
>       ARM: pxa: hx4700: Enable ASIC3 GPIO as a wakeup source
>       ARM: pxa: hx4700: Add PCMCIA/CF support
>       ARM: pxa: Add standard UART to hx4700_pin_config[]

The last patch in this series causes a build error with magician_defconfig:

/home/arnd/linux-arm/arch/arm/mach-pxa/hx4700.c:298:2: error: unknown field 'clock_rate' specified in initializer
/home/arnd/linux-arm/arch/arm/mach-pxa/hx4700.c:298:2: error: initialization makes pointer from integer without a cast [-Werror]
/home/arnd/linux-arm/arch/arm/mach-pxa/hx4700.c:298:2: error: (near initialization for 'asic3_platform_data.leds') [-Werror]
cc1: all warnings being treated as errors
make[2]: *** [arch/arm/mach-pxa/hx4700.o] Error 1
make[1]: *** [arch/arm/mach-pxa] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [sub-make] Error 2

Did you miss a dependency? Should I revert that patch for now?

	Arnd
