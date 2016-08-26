From: lkp@intel.com (kbuild test robot)
Date: Sat, 27 Aug 2016 06:39:16 +0800
Subject: [PATCH 1/2] smc91x: always use 8-bit access if necessary
In-Reply-To: <20160825144633.1850889-1-arnd@arndb.de>
Message-ID: <201608270623.7fH0YSH3%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

[auto build test WARNING on net-next/master]
[also build test WARNING on v4.8-rc3 next-20160825]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/smc91x-always-use-8-bit-access-if-necessary/20160825-225929
config: sh-microdev_defconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All warnings (new ones prefixed by >>):

                    from drivers/net/ethernet/smsc/smc91x.c:72:
   arch/sh/include/asm/io.h:159:25: note: expected 'long unsigned int' but argument is of type 'void *'
    static inline void pfx##out##bwlq##p(type val, unsigned long port) \
                            ^
   arch/sh/include/asm/io.h:181:2: note: in expansion of macro '__BUILD_IOPORT_SINGLE'
     __BUILD_IOPORT_SINGLE(bus, bwlq, type, ,)   \
     ^
   arch/sh/include/asm/io.h:185:2: note: in expansion of macro '__BUILD_IOPORT_PFX'
     __BUILD_IOPORT_PFX(, bwlq, type)
     ^
   arch/sh/include/asm/io.h:188:1: note: in expansion of macro 'BUILDIO_IOPORT'
    BUILDIO_IOPORT(w, u16)
    ^
   In file included from drivers/net/ethernet/smsc/smc91x.c:92:0:
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:1015:28: note: in expansion of macro 'SMC_out16'
    #define SMC_SET_TCR(lp, x) SMC_out16(x, ioaddr, TCR_REG(lp))
                               ^
   drivers/net/ethernet/smsc/smc91x.c:319:2: note: in expansion of macro 'SMC_SET_TCR'
     SMC_SET_TCR(lp, TCR_CLEAR);
     ^
   drivers/net/ethernet/smsc/smc91x.h:91:35: warning: passing argument 2 of 'outw' makes integer from pointer without a cast [-Wint-conversion]
    #define SMC_outw(v, a, r) outw(v, (a) + (r) - 0xa0000000)
                                      ^
   drivers/net/ethernet/smsc/smc91x.h:428:3: note: in expansion of macro 'SMC_outw'
      SMC_outw(x, ioaddr, reg);         \
      ^
   drivers/net/ethernet/smsc/smc91x.h:1015:28: note: in expansion of macro 'SMC_out16'
    #define SMC_SET_TCR(lp, x) SMC_out16(x, ioaddr, TCR_REG(lp))
                               ^
   drivers/net/ethernet/smsc/smc91x.c:319:2: note: in expansion of macro 'SMC_SET_TCR'
     SMC_SET_TCR(lp, TCR_CLEAR);
     ^
   In file included from include/linux/io.h:25:0,
                    from include/linux/irq.h:24,
                    from arch/sh/include/asm/hardirq.h:5,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from drivers/net/ethernet/smsc/smc91x.c:72:
   arch/sh/include/asm/io.h:159:25: note: expected 'long unsigned int' but argument is of type 'void *'
    static inline void pfx##out##bwlq##p(type val, unsigned long port) \
                            ^
   arch/sh/include/asm/io.h:181:2: note: in expansion of macro '__BUILD_IOPORT_SINGLE'
     __BUILD_IOPORT_SINGLE(bus, bwlq, type, ,)   \
     ^
   arch/sh/include/asm/io.h:185:2: note: in expansion of macro '__BUILD_IOPORT_PFX'
     __BUILD_IOPORT_PFX(, bwlq, type)
     ^
   arch/sh/include/asm/io.h:188:1: note: in expansion of macro 'BUILDIO_IOPORT'
    BUILDIO_IOPORT(w, u16)
    ^
   In file included from drivers/net/ethernet/smsc/smc91x.c:92:0:
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:321:2: note: in expansion of macro 'SMC_SELECT_BANK'
     SMC_SELECT_BANK(lp, 1);
     ^
   drivers/net/ethernet/smsc/smc91x.h:91:35: warning: passing argument 2 of 'outw' makes integer from pointer without a cast [-Wint-conversion]
    #define SMC_outw(v, a, r) outw(v, (a) + (r) - 0xa0000000)
                                      ^
   drivers/net/ethernet/smsc/smc91x.h:428:3: note: in expansion of macro 'SMC_outw'
      SMC_outw(x, ioaddr, reg);         \
      ^
   drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:321:2: note: in expansion of macro 'SMC_SELECT_BANK'
     SMC_SELECT_BANK(lp, 1);
     ^
   In file included from include/linux/io.h:25:0,
                    from include/linux/irq.h:24,
                    from arch/sh/include/asm/hardirq.h:5,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from drivers/net/ethernet/smsc/smc91x.c:72:
   arch/sh/include/asm/io.h:159:25: note: expected 'long unsigned int' but argument is of type 'void *'
    static inline void pfx##out##bwlq##p(type val, unsigned long port) \
                            ^
   arch/sh/include/asm/io.h:181:2: note: in expansion of macro '__BUILD_IOPORT_SINGLE'
     __BUILD_IOPORT_SINGLE(bus, bwlq, type, ,)   \
     ^
   arch/sh/include/asm/io.h:185:2: note: in expansion of macro '__BUILD_IOPORT_PFX'
     __BUILD_IOPORT_PFX(, bwlq, type)
     ^
   arch/sh/include/asm/io.h:188:1: note: in expansion of macro 'BUILDIO_IOPORT'
    BUILDIO_IOPORT(w, u16)
    ^
   In file included from drivers/net/ethernet/smsc/smc91x.c:92:0:
   drivers/net/ethernet/smsc/smc91x.h:88:28: warning: passing argument 1 of 'inw' makes integer from pointer without a cast [-Wint-conversion]
    #define SMC_inw(a, r)  inw((a) + (r) - 0xa0000000)
                               ^
   drivers/net/ethernet/smsc/smc91x.h:439:13: note: in expansion of macro 'SMC_inw'
      __val16 = SMC_inw(ioaddr, reg);         \
                ^
>> drivers/net/ethernet/smsc/smc91x.h:957:26: note: in expansion of macro 'SMC_in16'
    #define SMC_GET_CTL(lp)  SMC_in16(ioaddr, CTL_REG(lp))
                             ^
   drivers/net/ethernet/smsc/smc91x.c:322:8: note: in expansion of macro 'SMC_GET_CTL'
     ctl = SMC_GET_CTL(lp) | CTL_LE_ENABLE;
           ^
   In file included from include/linux/io.h:25:0,
                    from include/linux/irq.h:24,
                    from arch/sh/include/asm/hardirq.h:5,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from drivers/net/ethernet/smsc/smc91x.c:72:
   arch/sh/include/asm/io.h:168:25: note: expected 'long unsigned int' but argument is of type 'void *'
    static inline type pfx##in##bwlq##p(unsigned long port)   \
                            ^
   arch/sh/include/asm/io.h:181:2: note: in expansion of macro '__BUILD_IOPORT_SINGLE'
     __BUILD_IOPORT_SINGLE(bus, bwlq, type, ,)   \
     ^
   arch/sh/include/asm/io.h:185:2: note: in expansion of macro '__BUILD_IOPORT_PFX'
     __BUILD_IOPORT_PFX(, bwlq, type)
     ^
   arch/sh/include/asm/io.h:188:1: note: in expansion of macro 'BUILDIO_IOPORT'
    BUILDIO_IOPORT(w, u16)
    ^
   In file included from drivers/net/ethernet/smsc/smc91x.c:92:0:
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:959:28: note: in expansion of macro 'SMC_out16'
    #define SMC_SET_CTL(lp, x) SMC_out16(x, ioaddr, CTL_REG(lp))
                               ^
   drivers/net/ethernet/smsc/smc91x.c:333:2: note: in expansion of macro 'SMC_SET_CTL'
     SMC_SET_CTL(lp, ctl);
     ^
   drivers/net/ethernet/smsc/smc91x.h:91:35: warning: passing argument 2 of 'outw' makes integer from pointer without a cast [-Wint-conversion]
    #define SMC_outw(v, a, r) outw(v, (a) + (r) - 0xa0000000)
                                      ^
   drivers/net/ethernet/smsc/smc91x.h:428:3: note: in expansion of macro 'SMC_outw'
      SMC_outw(x, ioaddr, reg);         \
      ^
   drivers/net/ethernet/smsc/smc91x.h:959:28: note: in expansion of macro 'SMC_out16'
    #define SMC_SET_CTL(lp, x) SMC_out16(x, ioaddr, CTL_REG(lp))
                               ^
   drivers/net/ethernet/smsc/smc91x.c:333:2: note: in expansion of macro 'SMC_SET_CTL'
     SMC_SET_CTL(lp, ctl);
     ^
   In file included from include/linux/io.h:25:0,
                    from include/linux/irq.h:24,
                    from arch/sh/include/asm/hardirq.h:5,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from drivers/net/ethernet/smsc/smc91x.c:72:
   arch/sh/include/asm/io.h:159:25: note: expected 'long unsigned int' but argument is of type 'void *'
    static inline void pfx##out##bwlq##p(type val, unsigned long port) \
                            ^
   arch/sh/include/asm/io.h:181:2: note: in expansion of macro '__BUILD_IOPORT_SINGLE'
     __BUILD_IOPORT_SINGLE(bus, bwlq, type, ,)   \
     ^
   arch/sh/include/asm/io.h:185:2: note: in expansion of macro '__BUILD_IOPORT_PFX'
     __BUILD_IOPORT_PFX(, bwlq, type)
     ^
   arch/sh/include/asm/io.h:188:1: note: in expansion of macro 'BUILDIO_IOPORT'
    BUILDIO_IOPORT(w, u16)
    ^
   In file included from drivers/net/ethernet/smsc/smc91x.c:92:0:
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:336:2: note: in expansion of macro 'SMC_SELECT_BANK'
     SMC_SELECT_BANK(lp, 2);
     ^
   drivers/net/ethernet/smsc/smc91x.h:91:35: warning: passing argument 2 of 'outw' makes integer from pointer without a cast [-Wint-conversion]
    #define SMC_outw(v, a, r) outw(v, (a) + (r) - 0xa0000000)
                                      ^
   drivers/net/ethernet/smsc/smc91x.h:428:3: note: in expansion of macro 'SMC_outw'
      SMC_outw(x, ioaddr, reg);         \
      ^
   drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:336:2: note: in expansion of macro 'SMC_SELECT_BANK'
     SMC_SELECT_BANK(lp, 2);
     ^
   In file included from include/linux/io.h:25:0,
                    from include/linux/irq.h:24,
                    from arch/sh/include/asm/hardirq.h:5,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from drivers/net/ethernet/smsc/smc91x.c:72:
   arch/sh/include/asm/io.h:159:25: note: expected 'long unsigned int' but argument is of type 'void *'
    static inline void pfx##out##bwlq##p(type val, unsigned long port) \
                            ^
   arch/sh/include/asm/io.h:181:2: note: in expansion of macro '__BUILD_IOPORT_SINGLE'
     __BUILD_IOPORT_SINGLE(bus, bwlq, type, ,)   \
     ^
   arch/sh/include/asm/io.h:185:2: note: in expansion of macro '__BUILD_IOPORT_PFX'
     __BUILD_IOPORT_PFX(, bwlq, type)
     ^
--
   arch/sh/include/asm/io.h:168:25: note: expected 'long unsigned int' but argument is of type 'void *'
    static inline type pfx##in##bwlq##p(unsigned long port)   \
                            ^
   arch/sh/include/asm/io.h:181:2: note: in expansion of macro '__BUILD_IOPORT_SINGLE'
     __BUILD_IOPORT_SINGLE(bus, bwlq, type, ,)   \
     ^
   arch/sh/include/asm/io.h:185:2: note: in expansion of macro '__BUILD_IOPORT_PFX'
     __BUILD_IOPORT_PFX(, bwlq, type)
     ^
   arch/sh/include/asm/io.h:188:1: note: in expansion of macro 'BUILDIO_IOPORT'
    BUILDIO_IOPORT(w, u16)
    ^
   In file included from drivers/net/ethernet/smsc/smc91x.c:92:0:
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:1178:2: note: in expansion of macro 'SMC_SELECT_BANK'
     SMC_SELECT_BANK(lp, 2);
     ^
   drivers/net/ethernet/smsc/smc91x.h:91:35: warning: passing argument 2 of 'outw' makes integer from pointer without a cast [-Wint-conversion]
    #define SMC_outw(v, a, r) outw(v, (a) + (r) - 0xa0000000)
                                      ^
   drivers/net/ethernet/smsc/smc91x.h:428:3: note: in expansion of macro 'SMC_outw'
      SMC_outw(x, ioaddr, reg);         \
      ^
   drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:1178:2: note: in expansion of macro 'SMC_SELECT_BANK'
     SMC_SELECT_BANK(lp, 2);
     ^
   In file included from include/linux/io.h:25:0,
                    from include/linux/irq.h:24,
                    from arch/sh/include/asm/hardirq.h:5,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from drivers/net/ethernet/smsc/smc91x.c:72:
   arch/sh/include/asm/io.h:159:25: note: expected 'long unsigned int' but argument is of type 'void *'
    static inline void pfx##out##bwlq##p(type val, unsigned long port) \
                            ^
   arch/sh/include/asm/io.h:181:2: note: in expansion of macro '__BUILD_IOPORT_SINGLE'
     __BUILD_IOPORT_SINGLE(bus, bwlq, type, ,)   \
     ^
   arch/sh/include/asm/io.h:185:2: note: in expansion of macro '__BUILD_IOPORT_PFX'
     __BUILD_IOPORT_PFX(, bwlq, type)
     ^
   arch/sh/include/asm/io.h:188:1: note: in expansion of macro 'BUILDIO_IOPORT'
    BUILDIO_IOPORT(w, u16)
    ^
   In file included from drivers/net/ethernet/smsc/smc91x.c:92:0:
   drivers/net/ethernet/smsc/smc91x.c: In function 'smc_eph_interrupt':
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:1200:2: note: in expansion of macro 'SMC_SELECT_BANK'
     SMC_SELECT_BANK(lp, 1);
     ^
   drivers/net/ethernet/smsc/smc91x.h:91:35: warning: passing argument 2 of 'outw' makes integer from pointer without a cast [-Wint-conversion]
    #define SMC_outw(v, a, r) outw(v, (a) + (r) - 0xa0000000)
                                      ^
   drivers/net/ethernet/smsc/smc91x.h:428:3: note: in expansion of macro 'SMC_outw'
      SMC_outw(x, ioaddr, reg);         \
      ^
   drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:1200:2: note: in expansion of macro 'SMC_SELECT_BANK'
     SMC_SELECT_BANK(lp, 1);
     ^
   In file included from include/linux/io.h:25:0,
                    from include/linux/irq.h:24,
                    from arch/sh/include/asm/hardirq.h:5,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from drivers/net/ethernet/smsc/smc91x.c:72:
   arch/sh/include/asm/io.h:159:25: note: expected 'long unsigned int' but argument is of type 'void *'
    static inline void pfx##out##bwlq##p(type val, unsigned long port) \
                            ^
   arch/sh/include/asm/io.h:181:2: note: in expansion of macro '__BUILD_IOPORT_SINGLE'
     __BUILD_IOPORT_SINGLE(bus, bwlq, type, ,)   \
     ^
   arch/sh/include/asm/io.h:185:2: note: in expansion of macro '__BUILD_IOPORT_PFX'
     __BUILD_IOPORT_PFX(, bwlq, type)
     ^
   arch/sh/include/asm/io.h:188:1: note: in expansion of macro 'BUILDIO_IOPORT'
    BUILDIO_IOPORT(w, u16)
    ^
   In file included from drivers/net/ethernet/smsc/smc91x.c:92:0:
   drivers/net/ethernet/smsc/smc91x.h:88:28: warning: passing argument 1 of 'inw' makes integer from pointer without a cast [-Wint-conversion]
    #define SMC_inw(a, r)  inw((a) + (r) - 0xa0000000)
                               ^
   drivers/net/ethernet/smsc/smc91x.h:439:13: note: in expansion of macro 'SMC_inw'
      __val16 = SMC_inw(ioaddr, reg);         \
                ^
>> drivers/net/ethernet/smsc/smc91x.h:957:26: note: in expansion of macro 'SMC_in16'
    #define SMC_GET_CTL(lp)  SMC_in16(ioaddr, CTL_REG(lp))
                             ^
   drivers/net/ethernet/smsc/smc91x.c:1201:8: note: in expansion of macro 'SMC_GET_CTL'
     ctl = SMC_GET_CTL(lp);
           ^
   In file included from include/linux/io.h:25:0,
                    from include/linux/irq.h:24,
                    from arch/sh/include/asm/hardirq.h:5,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from drivers/net/ethernet/smsc/smc91x.c:72:
   arch/sh/include/asm/io.h:168:25: note: expected 'long unsigned int' but argument is of type 'void *'
    static inline type pfx##in##bwlq##p(unsigned long port)   \
                            ^
   arch/sh/include/asm/io.h:181:2: note: in expansion of macro '__BUILD_IOPORT_SINGLE'
     __BUILD_IOPORT_SINGLE(bus, bwlq, type, ,)   \
     ^
   arch/sh/include/asm/io.h:185:2: note: in expansion of macro '__BUILD_IOPORT_PFX'
     __BUILD_IOPORT_PFX(, bwlq, type)
     ^
   arch/sh/include/asm/io.h:188:1: note: in expansion of macro 'BUILDIO_IOPORT'
    BUILDIO_IOPORT(w, u16)
    ^
   In file included from drivers/net/ethernet/smsc/smc91x.c:92:0:
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:959:28: note: in expansion of macro 'SMC_out16'
    #define SMC_SET_CTL(lp, x) SMC_out16(x, ioaddr, CTL_REG(lp))
                               ^
   drivers/net/ethernet/smsc/smc91x.c:1202:2: note: in expansion of macro 'SMC_SET_CTL'
     SMC_SET_CTL(lp, ctl & ~CTL_LE_ENABLE);
     ^
   drivers/net/ethernet/smsc/smc91x.h:91:35: warning: passing argument 2 of 'outw' makes integer from pointer without a cast [-Wint-conversion]
    #define SMC_outw(v, a, r) outw(v, (a) + (r) - 0xa0000000)
                                      ^
   drivers/net/ethernet/smsc/smc91x.h:428:3: note: in expansion of macro 'SMC_outw'
      SMC_outw(x, ioaddr, reg);         \
      ^
   drivers/net/ethernet/smsc/smc91x.h:959:28: note: in expansion of macro 'SMC_out16'
    #define SMC_SET_CTL(lp, x) SMC_out16(x, ioaddr, CTL_REG(lp))
                               ^
   drivers/net/ethernet/smsc/smc91x.c:1202:2: note: in expansion of macro 'SMC_SET_CTL'
     SMC_SET_CTL(lp, ctl & ~CTL_LE_ENABLE);
     ^
   In file included from include/linux/io.h:25:0,
                    from include/linux/irq.h:24,
                    from arch/sh/include/asm/hardirq.h:5,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from drivers/net/ethernet/smsc/smc91x.c:72:
   arch/sh/include/asm/io.h:159:25: note: expected 'long unsigned int' but argument is of type 'void *'
    static inline void pfx##out##bwlq##p(type val, unsigned long port) \
                            ^
   arch/sh/include/asm/io.h:181:2: note: in expansion of macro '__BUILD_IOPORT_SINGLE'
     __BUILD_IOPORT_SINGLE(bus, bwlq, type, ,)   \
     ^
   arch/sh/include/asm/io.h:185:2: note: in expansion of macro '__BUILD_IOPORT_PFX'
     __BUILD_IOPORT_PFX(, bwlq, type)
     ^
   arch/sh/include/asm/io.h:188:1: note: in expansion of macro 'BUILDIO_IOPORT'
    BUILDIO_IOPORT(w, u16)
    ^
   In file included from drivers/net/ethernet/smsc/smc91x.c:92:0:
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:959:28: note: in expansion of macro 'SMC_out16'
    #define SMC_SET_CTL(lp, x) SMC_out16(x, ioaddr, CTL_REG(lp))
                               ^
   drivers/net/ethernet/smsc/smc91x.c:1203:2: note: in expansion of macro 'SMC_SET_CTL'
     SMC_SET_CTL(lp, ctl);
     ^
   drivers/net/ethernet/smsc/smc91x.h:91:35: warning: passing argument 2 of 'outw' makes integer from pointer without a cast [-Wint-conversion]
    #define SMC_outw(v, a, r) outw(v, (a) + (r) - 0xa0000000)
                                      ^
   drivers/net/ethernet/smsc/smc91x.h:428:3: note: in expansion of macro 'SMC_outw'
      SMC_outw(x, ioaddr, reg);         \
      ^
   drivers/net/ethernet/smsc/smc91x.h:959:28: note: in expansion of macro 'SMC_out16'
    #define SMC_SET_CTL(lp, x) SMC_out16(x, ioaddr, CTL_REG(lp))
                               ^
   drivers/net/ethernet/smsc/smc91x.c:1203:2: note: in expansion of macro 'SMC_SET_CTL'
     SMC_SET_CTL(lp, ctl);
     ^
   In file included from include/linux/io.h:25:0,
                    from include/linux/irq.h:24,
                    from arch/sh/include/asm/hardirq.h:5,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from drivers/net/ethernet/smsc/smc91x.c:72:
   arch/sh/include/asm/io.h:159:25: note: expected 'long unsigned int' but argument is of type 'void *'
    static inline void pfx##out##bwlq##p(type val, unsigned long port) \
                            ^
   arch/sh/include/asm/io.h:181:2: note: in expansion of macro '__BUILD_IOPORT_SINGLE'
     __BUILD_IOPORT_SINGLE(bus, bwlq, type, ,)   \
     ^
   arch/sh/include/asm/io.h:185:2: note: in expansion of macro '__BUILD_IOPORT_PFX'
     __BUILD_IOPORT_PFX(, bwlq, type)
     ^
..

vim +/SMC_in16 +957 drivers/net/ethernet/smsc/smc91x.h

   941			if (SMC_MUST_ALIGN_WRITE(lp))				\
   942				SMC_outl((x)<<16, ioaddr, 12<<SMC_IO_SHIFT);	\
   943			else							\
   944				SMC_out16(x, ioaddr, BANK_SELECT);		\
   945		} while (0)
   946	
   947	#define SMC_GET_BASE(lp)	SMC_in16(ioaddr, BASE_REG(lp))
   948	
   949	#define SMC_SET_BASE(lp, x)	SMC_out16(x, ioaddr, BASE_REG(lp))
   950	
   951	#define SMC_GET_CONFIG(lp)	SMC_in16(ioaddr, CONFIG_REG(lp))
   952	
   953	#define SMC_SET_CONFIG(lp, x)	SMC_out16(x, ioaddr, CONFIG_REG(lp))
   954	
   955	#define SMC_GET_COUNTER(lp)	SMC_in16(ioaddr, COUNTER_REG(lp))
   956	
 > 957	#define SMC_GET_CTL(lp)		SMC_in16(ioaddr, CTL_REG(lp))
   958	
   959	#define SMC_SET_CTL(lp, x)	SMC_out16(x, ioaddr, CTL_REG(lp))
   960	
   961	#define SMC_GET_MII(lp)		SMC_in16(ioaddr, MII_REG(lp))
   962	
   963	#define SMC_GET_GP(lp)		SMC_in16(ioaddr, GP_REG(lp))
   964	
   965	#define SMC_SET_GP(lp, x)						\

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 9967 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160827/16285cd8/attachment-0001.obj>
