From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 May 2012 20:52:46 +0000
Subject: [GIT PULL][for 3.5] clk-next update
In-Reply-To: <CAOesGMh6w9gHwwn5MJ7MSkP9S-2RmjrwOtj77RfCMpBrEtupDg@mail.gmail.com>
References: <20120516063552.GA5154@gmail.com>
 <201205161839.03269.arnd@arndb.de>
 <CAOesGMh6w9gHwwn5MJ7MSkP9S-2RmjrwOtj77RfCMpBrEtupDg@mail.gmail.com>
Message-ID: <201205162052.46513.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 May 2012, Olof Johansson wrote:
> 
> Are you planning on sending the last couple of fixes out before
> wrapping things up? If I haven't seen a request go out by tomorrow
> I'll do it, I suppose.

I was planning to, but it's getting rather late here in Germany
so maybe you can take care of this, too.

I've just fixed up two of the next/* branches that caused build regressions
(one was my fault, the other one came from samsung/board2) and started
building the defconfigs for linux-next, which looks rather bad, so I probably
won't spend much time trying to fix them up, see below for how far I got.

	Arnd

----
acs5k_defconfig
acs5k_defconfig
  Generating include/generated/mach-types.h
/home/arnd/linux-arm/arch/arm/mm/dma-mapping.c: In function 'arm_dma_alloc':
/home/arnd/linux-arm/arch/arm/mm/dma-mapping.c:675:15: error: 'page' may be used uninitialized in this function [-Werror=uninitialized]
cc1: all warnings being treated as errors
make[2]: *** [arch/arm/mm/dma-mapping.o] Error 1
make[1]: *** [arch/arm/mm] Error 2
make[1]: *** Waiting for unfinished jobs....
/home/arnd/linux-arm/kernel/user.c:30:4: error: this decimal constant is unsigned only in ISO C90 [-Werror]
/home/arnd/linux-arm/kernel/user.c:38:4: error: this decimal constant is unsigned only in ISO C90 [-Werror]
cc1: all warnings being treated as errors
acs5k_tiny_defconfig
afeb9260_defconfig
ag5evm_defconfig
/home/arnd/linux-arm/arch/arm/mach-shmobile/clock-sh73a0.c: In function 'sh73a0_clock_init':
/home/arnd/linux-arm/arch/arm/mach-shmobile/clock-sh73a0.c:615:3: error: 'sh_clk_mstp32_register' is deprecated (declared at /home/arnd/linux-arm/include/linux/sh_clk.h:138) [-Werror=deprecated-declarations]
cc1: all warnings being treated as errors
make[2]: *** [arch/arm/mach-shmobile/clock-sh73a0.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [arch/arm/mach-shmobile] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [sub-make] Error 2
am200epdkit_defconfig
ap4evb_defconfig
/home/arnd/linux-arm/arch/arm/mach-shmobile/clock-sh7372.c: In function 'sh7372_clock_init':
/home/arnd/linux-arm/arch/arm/mach-shmobile/clock-sh7372.c:707:3: error: 'sh_clk_mstp32_register' is deprecated (declared at /home/arnd/linux-arm/include/linux/sh_clk.h:138) [-Werror=deprecated-declarations]
cc1: all warnings being treated as errors
make[2]: *** [arch/arm/mach-shmobile/clock-sh7372.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [arch/arm/mach-shmobile] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [sub-make] Error 2
armadillo800eva_defconfig
assabet_defconfig
at91_dt_defconfig
/home/arnd/linux-arm/drivers/usb/gadget/at91_udc.c: In function 'at91_ep_enable':
/home/arnd/linux-arm/drivers/usb/gadget/at91_udc.c:478:18: error: 'struct at91_ep' has no member named 'desc'
make[4]: *** [drivers/usb/gadget/at91_udc.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [drivers/usb/gadget] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [drivers/usb] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [drivers] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [sub-make] Error 2
at91rm9200_defconfig
at91sam9260_defconfig
at91sam9261_defconfig
at91sam9263_defconfig
/home/arnd/linux-arm/fs/fuse/control.c: In function 'fuse_conn_congestion_threshold_write':
/home/arnd/linux-arm/fs/fuse/control.c:165:29: error: 'val' may be used uninitialized in this function [-Werror=uninitialized]
/home/arnd/linux-arm/fs/fuse/control.c: In function 'fuse_conn_max_background_write':
/home/arnd/linux-arm/fs/fuse/control.c:128:23: error: 'val' may be used uninitialized in this function [-Werror=uninitialized]
cc1: all warnings being treated as errors
make[3]: *** [fs/fuse/control.o] Error 1
make[2]: *** [fs/fuse] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [fs] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [sub-make] Error 2
at91sam9g20_defconfig
at91sam9g45_defconfig
at91sam9rl_defconfig
at91x40_defconfig
badge4_defconfig
bcmring_defconfig
bcmring_defconfig.rej
bonito_defconfig
cam60_defconfig
