From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri, 01 Dec 2017 18:59:10 +0100
Subject: [clk:clk-next 9/11] include/linux/clk.h:637:1: error: expected
 identifier or '(' before '{' token
In-Reply-To: <201712020115.S9MTjUlq%fengguang.wu@intel.com>
References: <201712020115.S9MTjUlq%fengguang.wu@intel.com>
Message-ID: <1512151150.23975.1.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike, Stephen,

Indeed, I made a mistake in the non-CCF case
I'll send another version for you to pull


On Sat, 2017-12-02 at 01:37 +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
> head:   20697052ae1dc0aad45f72eaed791edb7579ee4f
> commit: b833533133b209e89f4d652e0c7f001adda81f96 [9/11] clk: add
> clk_rate_exclusive api
> config: blackfin-allmodconfig (attached as .config)
> compiler: bfin-uclinux-gcc (GCC) 6.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/mak
> e.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout b833533133b209e89f4d652e0c7f001adda81f96
>         # save the attached .config to linux build tree
>         make.cross ARCH=blackfin 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from drivers/media/platform/qcom/camss-8x16/camss.c:18:0:
>    include/linux/clk.h: In function 'clk_exclusive_get':
> > > include/linux/clk.h:636:44: warning: no return statement in function
> > > returning non-void [-Wreturn-type]
> 
>     static inline int clk_exclusive_get(struct clk *clk) {}
>                                                ^~~
>    include/linux/clk.h: At top level:
> > > include/linux/clk.h:637:1: error: expected identifier or '(' before '{'
> > > token
> 
>     {
>     ^
> --
>    In file included from drivers//net/ethernet/hisilicon/hix5hd2_gmac.c:18:0:
>    include/linux/clk.h: In function 'clk_exclusive_get':
> > > include/linux/clk.h:636:44: warning: no return statement in function
> > > returning non-void [-Wreturn-type]
> 
>     static inline int clk_exclusive_get(struct clk *clk) {}
>                                                ^~~
>    include/linux/clk.h: At top level:
> > > include/linux/clk.h:637:1: error: expected identifier or '(' before '{'
> > > token
> 
>     {
>     ^
>    drivers//net/ethernet/hisilicon/hix5hd2_gmac.c:26:0: warning: "PORT_EN"
> redefined
>     #define PORT_EN    0x0044
>     
>    In file included from arch/blackfin/mach-
> bf533/include/mach/blackfin.h:16:0,
>                     from arch/blackfin/include/asm/irqflags.h:11,
>                     from include/linux/irqflags.h:16,
>                     from arch/blackfin/include/asm/bitops.h:33,
>                     from include/linux/bitops.h:38,
>                     from include/linux/kernel.h:11,
>                     from include/linux/list.h:9,
>                     from include/linux/module.h:9,
>                     from drivers//net/ethernet/hisilicon/hix5hd2_gmac.c:10:
>    arch/blackfin/mach-bf533/include/mach/defBF532.h:431:0: note: this is the
> location of the previous definition
>     #define PORT_EN              0x00000001 /* PPI Port Enable  */
>     
> --
>    In file included from drivers/usb/musb/ux500.c:11:0:
>    include/linux/clk.h: In function 'clk_exclusive_get':
> > > include/linux/clk.h:636:44: warning: no return statement in function
> > > returning non-void [-Wreturn-type]
> 
>     static inline int clk_exclusive_get(struct clk *clk) {}
>                                                ^~~
>    include/linux/clk.h: At top level:
> > > include/linux/clk.h:637:1: error: expected identifier or '(' before '{'
> > > token
> 
>     {
>     ^
>    In file included from drivers/usb/musb/musb_core.h:439:0,
>                     from drivers/usb/musb/ux500.c:18:
>    drivers/usb/musb/ux500.c: In function 'ux500_musb_set_vbus':
>    drivers/usb/musb/musb_regs.h:443:33: error: 'USB_OTG_DEV_CTL' undeclared
> (first use in this function)
>     #define MUSB_DEVCTL  USB_OFFSET(USB_OTG_DEV_CTL) /* 8 bit */
>                                     ^
>    drivers/usb/musb/musb_regs.h:422:27: note: in definition of macro
> 'USB_OFFSET'
>     #define USB_OFFSET(reg)  (reg - USB_BASE)
>                               ^~~
>    drivers/usb/musb/ux500.c:43:35: note: in expansion of macro 'MUSB_DEVCTL'
>      devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
>                                       ^~~~~~~~~~~
>    drivers/usb/musb/musb_regs.h:443:33: note: each undeclared identifier is
> reported only once for each function it appears in
>     #define MUSB_DEVCTL  USB_OFFSET(USB_OTG_DEV_CTL) /* 8 bit */
>                                     ^
>    drivers/usb/musb/musb_regs.h:422:27: note: in definition of macro
> 'USB_OFFSET'
>     #define USB_OFFSET(reg)  (reg - USB_BASE)
>                               ^~~
>    drivers/usb/musb/ux500.c:43:35: note: in expansion of macro 'MUSB_DEVCTL'
>      devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
>                                       ^~~~~~~~~~~
>    drivers/usb/musb/musb_regs.h:421:19: error: 'USB_FADDR' undeclared (first
> use in this function)
>     #define USB_BASE  USB_FADDR
>                       ^
>    drivers/usb/musb/musb_regs.h:422:33: note: in expansion of macro 'USB_BASE'
>     #define USB_OFFSET(reg)  (reg - USB_BASE)
>                                     ^~~~~~~~
>    drivers/usb/musb/musb_regs.h:443:22: note: in expansion of macro
> 'USB_OFFSET'
>     #define MUSB_DEVCTL  USB_OFFSET(USB_OTG_DEV_CTL) /* 8 bit */
>                          ^~~~~~~~~~
>    drivers/usb/musb/ux500.c:43:35: note: in expansion of macro 'MUSB_DEVCTL'
>      devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
>                                       ^~~~~~~~~~~
>    drivers/usb/musb/ux500.c: In function 'ux500_musb_interrupt':
>    drivers/usb/musb/musb_regs.h:433:34: error: 'USB_INTRUSB' undeclared (first
> use in this function)
>     #define MUSB_INTRUSB  USB_OFFSET(USB_INTRUSB) /* 8 bit */
>                                      ^
>    drivers/usb/musb/musb_regs.h:422:27: note: in definition of macro
> 'USB_OFFSET'
>     #define USB_OFFSET(reg)  (reg - USB_BASE)
>                               ^~~
>    drivers/usb/musb/ux500.c:134:42: note: in expansion of macro 'MUSB_INTRUSB'
>      musb->int_usb = musb_readb(musb->mregs, MUSB_INTRUSB);
>                                              ^~~~~~~~~~~~
>    drivers/usb/musb/musb_regs.h:421:19: error: 'USB_FADDR' undeclared (first
> use in this function)
>     #define USB_BASE  USB_FADDR
>                       ^
>    drivers/usb/musb/musb_regs.h:422:33: note: in expansion of macro 'USB_BASE'
>     #define USB_OFFSET(reg)  (reg - USB_BASE)
>                                     ^~~~~~~~
>    drivers/usb/musb/musb_regs.h:433:23: note: in expansion of macro
> 'USB_OFFSET'
>     #define MUSB_INTRUSB  USB_OFFSET(USB_INTRUSB) /* 8 bit */
>                           ^~~~~~~~~~
>    drivers/usb/musb/ux500.c:134:42: note: in expansion of macro 'MUSB_INTRUSB'
>      musb->int_usb = musb_readb(musb->mregs, MUSB_INTRUSB);
>                                              ^~~~~~~~~~~~
>    drivers/usb/musb/musb_regs.h:429:33: error: 'USB_INTRTX' undeclared (first
> use in this function)
>     #define MUSB_INTRTX  USB_OFFSET(USB_INTRTX) /* 16-bit */
>                                     ^
>    drivers/usb/musb/musb_regs.h:422:27: note: in definition of macro
> 'USB_OFFSET'
>     #define USB_OFFSET(reg)  (reg - USB_BASE)
>                               ^~~
>    drivers/usb/musb/ux500.c:135:41: note: in expansion of macro 'MUSB_INTRTX'
>      musb->int_tx = musb_readw(musb->mregs, MUSB_INTRTX);
>                                             ^~~~~~~~~~~
>    drivers/usb/musb/musb_regs.h:430:33: error: 'USB_INTRRX' undeclared (first
> use in this function)
>     #define MUSB_INTRRX  USB_OFFSET(USB_INTRRX)
>                                     ^
>    drivers/usb/musb/musb_regs.h:422:27: note: in definition of macro
> 'USB_OFFSET'
>     #define USB_OFFSET(reg)  (reg - USB_BASE)
>                               ^~~
>    drivers/usb/musb/ux500.c:136:41: note: in expansion of macro 'MUSB_INTRRX'
>      musb->int_rx = musb_readw(musb->mregs, MUSB_INTRRX);
>                                             ^~~~~~~~~~~
> --
>    In file included from drivers/net/ethernet/hisilicon/hix5hd2_gmac.c:18:0:
>    include/linux/clk.h: In function 'clk_exclusive_get':
> > > include/linux/clk.h:636:44: warning: no return statement in function
> > > returning non-void [-Wreturn-type]
> 
>     static inline int clk_exclusive_get(struct clk *clk) {}
>                                                ^~~
>    include/linux/clk.h: At top level:
> > > include/linux/clk.h:637:1: error: expected identifier or '(' before '{'
> > > token
> 
>     {
>     ^
>    drivers/net/ethernet/hisilicon/hix5hd2_gmac.c:26:0: warning: "PORT_EN"
> redefined
>     #define PORT_EN    0x0044
>     
>    In file included from arch/blackfin/mach-
> bf533/include/mach/blackfin.h:16:0,
>                     from arch/blackfin/include/asm/irqflags.h:11,
>                     from include/linux/irqflags.h:16,
>                     from arch/blackfin/include/asm/bitops.h:33,
>                     from include/linux/bitops.h:38,
>                     from include/linux/kernel.h:11,
>                     from include/linux/list.h:9,
>                     from include/linux/module.h:9,
>                     from drivers/net/ethernet/hisilicon/hix5hd2_gmac.c:10:
>    arch/blackfin/mach-bf533/include/mach/defBF532.h:431:0: note: this is the
> location of the previous definition
>     #define PORT_EN              0x00000001 /* PPI Port Enable  */
>     
> --
>    In file included from drivers/clocksource/timer-oxnas-rps.c:26:0:
>    include/linux/clk.h: In function 'clk_exclusive_get':
> > > include/linux/clk.h:636:44: warning: no return statement in function
> > > returning non-void [-Wreturn-type]
> 
>     static inline int clk_exclusive_get(struct clk *clk) {}
>                                                ^~~
>    include/linux/clk.h: At top level:
> > > include/linux/clk.h:637:1: error: expected identifier or '(' before '{'
> > > token
> 
>     {
>     ^
>    drivers/clocksource/timer-oxnas-rps.c:50:0: warning: "TIMER_ENABLE"
> redefined
>     #define TIMER_ENABLE  BIT(7)
>     
>    In file included from arch/blackfin/mach-
> bf533/include/mach/blackfin.h:16:0,
>                     from arch/blackfin/include/asm/irqflags.h:11,
>                     from include/linux/irqflags.h:16,
>                     from arch/blackfin/include/asm/bitops.h:33,
>                     from include/linux/bitops.h:38,
>                     from include/linux/kernel.h:11,
>                     from include/linux/list.h:9,
>                     from include/linux/smp.h:12,
>                     from include/linux/irq.h:13,
>                     from drivers/clocksource/timer-oxnas-rps.c:24:
>    arch/blackfin/mach-bf533/include/mach/defBF532.h:97:0: note: this is the
> location of the previous definition
>     #define TIMER_ENABLE   0xFFC00640 /* Timer Enable Register */
>     
> --
>    In file included from drivers//clocksource/timer-oxnas-rps.c:26:0:
>    include/linux/clk.h: In function 'clk_exclusive_get':
> > > include/linux/clk.h:636:44: warning: no return statement in function
> > > returning non-void [-Wreturn-type]
> 
>     static inline int clk_exclusive_get(struct clk *clk) {}
>                                                ^~~
>    include/linux/clk.h: At top level:
> > > include/linux/clk.h:637:1: error: expected identifier or '(' before '{'
> > > token
> 
>     {
>     ^
>    drivers//clocksource/timer-oxnas-rps.c:50:0: warning: "TIMER_ENABLE"
> redefined
>     #define TIMER_ENABLE  BIT(7)
>     
>    In file included from arch/blackfin/mach-
> bf533/include/mach/blackfin.h:16:0,
>                     from arch/blackfin/include/asm/irqflags.h:11,
>                     from include/linux/irqflags.h:16,
>                     from arch/blackfin/include/asm/bitops.h:33,
>                     from include/linux/bitops.h:38,
>                     from include/linux/kernel.h:11,
>                     from include/linux/list.h:9,
>                     from include/linux/smp.h:12,
>                     from include/linux/irq.h:13,
>                     from drivers//clocksource/timer-oxnas-rps.c:24:
>    arch/blackfin/mach-bf533/include/mach/defBF532.h:97:0: note: this is the
> location of the previous definition
>     #define TIMER_ENABLE   0xFFC00640 /* Timer Enable Register */
>     
> --
>    In file included from drivers/media/i2c/tc358743.c:32:0:
>    include/linux/clk.h: In function 'clk_exclusive_get':
> > > include/linux/clk.h:636:44: warning: no return statement in function
> > > returning non-void [-Wreturn-type]
> 
>     static inline int clk_exclusive_get(struct clk *clk) {}
>                                                ^~~
>    include/linux/clk.h: At top level:
> > > include/linux/clk.h:637:1: error: expected identifier or '(' before '{'
> > > token
> 
>     {
>     ^
>    In file included from drivers/media/i2c/tc358743.c:50:0:
>    drivers/media/i2c/tc358743_regs.h:32:0: warning: "CHIPID" redefined
>     #define CHIPID                                0x0000
>     
>    In file included from arch/blackfin/mach-
> bf533/include/mach/blackfin.h:16:0,
>                     from arch/blackfin/include/asm/irqflags.h:11,
>                     from include/linux/irqflags.h:16,
>                     from arch/blackfin/include/asm/bitops.h:33,
>                     from include/linux/bitops.h:38,
>                     from include/linux/kernel.h:11,
>                     from drivers/media/i2c/tc358743.c:28:
>    arch/blackfin/mach-bf533/include/mach/defBF532.h:22:0: note: this is the
> location of the previous definition
>     #define CHIPID                 0xFFC00014       /* Chip ID Register */
>     
> --
>    In file included from drivers/rtc/rtc-xgene.c:29:0:
>    include/linux/clk.h: In function 'clk_exclusive_get':
> > > include/linux/clk.h:636:44: warning: no return statement in function
> > > returning non-void [-Wreturn-type]
> 
>     static inline int clk_exclusive_get(struct clk *clk) {}
>                                                ^~~
>    include/linux/clk.h: At top level:
> > > include/linux/clk.h:637:1: error: expected identifier or '(' before '{'
> > > token
> 
>     {
>     ^
>    drivers/rtc/rtc-xgene.c:42:0: warning: "RTC_STAT" redefined
>     #define RTC_STAT  0x10
>     
>    In file included from arch/blackfin/mach-
> bf533/include/mach/blackfin.h:16:0,
>                     from arch/blackfin/include/asm/irqflags.h:11,
>                     from include/linux/irqflags.h:16,
>                     from arch/blackfin/include/asm/bitops.h:33,
>                     from include/linux/bitops.h:38,
>                     from include/linux/kernel.h:11,
>                     from include/linux/list.h:9,
>                     from include/linux/module.h:9,
>                     from drivers/rtc/rtc-xgene.c:24:
>    arch/blackfin/mach-bf533/include/mach/defBF532.h:41:0: note: this is the
> location of the previous definition
>     #define RTC_STAT                 0xFFC00300 /* RTC Status Register */
>     
> 
> vim +637 include/linux/clk.h
> 
>    634	
>    635	
>  > 636	static inline int clk_exclusive_get(struct clk *clk) {}
>  > 637	{
>    638		return 0;
>    639	}
>    640	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
