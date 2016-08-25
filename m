From: lkp@intel.com (kbuild test robot)
Date: Fri, 26 Aug 2016 00:32:02 +0800
Subject: [PATCH 1/2] smc91x: always use 8-bit access if necessary
In-Reply-To: <20160825144633.1850889-1-arnd@arndb.de>
Message-ID: <201608260030.Cb4uir4X%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

[auto build test WARNING on net-next/master]
[also build test WARNING on v4.8-rc3 next-20160825]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/smc91x-always-use-8-bit-access-if-necessary/20160825-225929
config: m32r-defconfig (attached as .config)
compiler: m32r-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m32r 

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/smsc/smc91x.c:92:0:
   drivers/net/ethernet/smsc/smc91x.h:444:0: warning: "SMC_insw" redefined
    #define SMC_insw(a, r, p, l)  BUG()
    ^
   drivers/net/ethernet/smsc/smc91x.h:110:0: note: this is the location of the previous definition
    #define SMC_insw(a, r, p, l) insw(((u32)a) + (r), p, l)
    ^
   drivers/net/ethernet/smsc/smc91x.h:445:0: warning: "SMC_outsw" redefined
    #define SMC_outsw(a, r, p, l)  BUG()
    ^
   drivers/net/ethernet/smsc/smc91x.h:111:0: note: this is the location of the previous definition
    #define SMC_outsw(a, r, p, l) outsw(((u32)a) + (r), p, l)
    ^
   drivers/net/ethernet/smsc/smc91x.h:455:0: warning: "SMC_inb" redefined
    #define SMC_inb(ioaddr, reg)  ({ BUG(); 0; })
    ^
   drivers/net/ethernet/smsc/smc91x.h:106:0: note: this is the location of the previous definition
    #define SMC_inb(a, r)  inb(((u32)a) + (r))
    ^
   drivers/net/ethernet/smsc/smc91x.h:456:0: warning: "SMC_outb" redefined
    #define SMC_outb(x, ioaddr, reg) BUG()
    ^
   drivers/net/ethernet/smsc/smc91x.h:108:0: note: this is the location of the previous definition
    #define SMC_outb(v, a, r) outb(v, ((u32)a) + (r))
    ^
   drivers/net/ethernet/smsc/smc91x.h:1128:2: error: #endif without #if
    #endif  /* _SMC91X_H_ */
     ^
   drivers/net/ethernet/smsc/smc91x.c: In function 'smc_reset':
>> drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
>> drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:261:2: note: in expansion of macro 'SMC_SELECT_BANK'
     SMC_SELECT_BANK(lp, 2);
     ^
>> drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
>> drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:278:2: note: in expansion of macro 'SMC_SELECT_BANK'
     SMC_SELECT_BANK(lp, 0);
     ^
>> drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:999:28: note: in expansion of macro 'SMC_out16'
    #define SMC_SET_RCR(lp, x) SMC_out16(x, ioaddr, RCR_REG(lp))
                               ^
   drivers/net/ethernet/smsc/smc91x.c:279:2: note: in expansion of macro 'SMC_SET_RCR'
     SMC_SET_RCR(lp, RCR_SOFTRST);
     ^
>> drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
>> drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:286:2: note: in expansion of macro 'SMC_SELECT_BANK'
     SMC_SELECT_BANK(lp, 1);
     ^
>> drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:953:31: note: in expansion of macro 'SMC_out16'
    #define SMC_SET_CONFIG(lp, x) SMC_out16(x, ioaddr, CONFIG_REG(lp))
                                  ^
   drivers/net/ethernet/smsc/smc91x.c:304:2: note: in expansion of macro 'SMC_SET_CONFIG'
     SMC_SET_CONFIG(lp, cfg);
     ^
>> drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
>> drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:317:2: note: in expansion of macro 'SMC_SELECT_BANK'
     SMC_SELECT_BANK(lp, 0);
     ^
>> drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:999:28: note: in expansion of macro 'SMC_out16'
    #define SMC_SET_RCR(lp, x) SMC_out16(x, ioaddr, RCR_REG(lp))
                               ^
   drivers/net/ethernet/smsc/smc91x.c:318:2: note: in expansion of macro 'SMC_SET_RCR'
     SMC_SET_RCR(lp, RCR_CLEAR);
     ^
>> drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:1015:28: note: in expansion of macro 'SMC_out16'
    #define SMC_SET_TCR(lp, x) SMC_out16(x, ioaddr, TCR_REG(lp))
                               ^
   drivers/net/ethernet/smsc/smc91x.c:319:2: note: in expansion of macro 'SMC_SET_TCR'
     SMC_SET_TCR(lp, TCR_CLEAR);
     ^
>> drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
>> drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:321:2: note: in expansion of macro 'SMC_SELECT_BANK'
     SMC_SELECT_BANK(lp, 1);
     ^
>> drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:959:28: note: in expansion of macro 'SMC_out16'
    #define SMC_SET_CTL(lp, x) SMC_out16(x, ioaddr, CTL_REG(lp))
                               ^
   drivers/net/ethernet/smsc/smc91x.c:333:2: note: in expansion of macro 'SMC_SET_CTL'
     SMC_SET_CTL(lp, ctl);
     ^
>> drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
>> drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:336:2: note: in expansion of macro 'SMC_SELECT_BANK'
     SMC_SELECT_BANK(lp, 2);
     ^
>> drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:981:32: note: in expansion of macro 'SMC_out16'
    #define SMC_SET_MMU_CMD(lp, x) SMC_out16(x, ioaddr, MMU_CMD_REG(lp))
                                   ^
   drivers/net/ethernet/smsc/smc91x.c:337:2: note: in expansion of macro 'SMC_SET_MMU_CMD'
     SMC_SET_MMU_CMD(lp, MC_RESET);
     ^
   drivers/net/ethernet/smsc/smc91x.c: In function 'smc_enable':
>> drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
>> drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:353:2: note: in expansion of macro 'SMC_SELECT_BANK'
     SMC_SELECT_BANK(lp, 0);
     ^

vim +/__val16 +424 drivers/net/ethernet/smsc/smc91x.h

09779c6d drivers/net/smc91x.h               Nicolas Pitre 2006-03-20  408  #define SMC_insl(a, r, p, l)		BUG()
09779c6d drivers/net/smc91x.h               Nicolas Pitre 2006-03-20  409  #define SMC_outsl(a, r, p, l)		BUG()
09779c6d drivers/net/smc91x.h               Nicolas Pitre 2006-03-20  410  #endif
09779c6d drivers/net/smc91x.h               Nicolas Pitre 2006-03-20  411  
09779c6d drivers/net/smc91x.h               Nicolas Pitre 2006-03-20  412  #if !defined(SMC_insl) || !defined(SMC_outsl)
09779c6d drivers/net/smc91x.h               Nicolas Pitre 2006-03-20  413  #define SMC_insl(a, r, p, l)		BUG()
09779c6d drivers/net/smc91x.h               Nicolas Pitre 2006-03-20  414  #define SMC_outsl(a, r, p, l)		BUG()
09779c6d drivers/net/smc91x.h               Nicolas Pitre 2006-03-20  415  #endif
09779c6d drivers/net/smc91x.h               Nicolas Pitre 2006-03-20  416  
09779c6d drivers/net/smc91x.h               Nicolas Pitre 2006-03-20  417  /*
39e82d37 drivers/net/ethernet/smsc/smc91x.h Arnd Bergmann 2016-08-25  418   * Any 16-bit register access is performed with two 8-bit accesses if the
39e82d37 drivers/net/ethernet/smsc/smc91x.h Arnd Bergmann 2016-08-25  419   * hardware can't do it directly.
09779c6d drivers/net/smc91x.h               Nicolas Pitre 2006-03-20  420   */
39e82d37 drivers/net/ethernet/smsc/smc91x.h Arnd Bergmann 2016-08-25  421  #define SMC_out16(x, ioaddr, reg)					     \
09779c6d drivers/net/smc91x.h               Nicolas Pitre 2006-03-20  422  do {									     \
39e82d37 drivers/net/ethernet/smsc/smc91x.h Arnd Bergmann 2016-08-25  423  	if (SMC_CAN_USE_8BIT && !SMC_16BIT(lp)) {			     \
09779c6d drivers/net/smc91x.h               Nicolas Pitre 2006-03-20 @424  		unsigned int __val16 = (x);				     \
09779c6d drivers/net/smc91x.h               Nicolas Pitre 2006-03-20  425  		SMC_outb(__val16, ioaddr, reg );			     \
09779c6d drivers/net/smc91x.h               Nicolas Pitre 2006-03-20  426  		SMC_outb(__val16 >> 8, ioaddr, reg + (1 << SMC_IO_SHIFT));   \
39e82d37 drivers/net/ethernet/smsc/smc91x.h Arnd Bergmann 2016-08-25  427  	} else {							     \
39e82d37 drivers/net/ethernet/smsc/smc91x.h Arnd Bergmann 2016-08-25  428  		SMC_outw(x, ioaddr, reg);				     \
39e82d37 drivers/net/ethernet/smsc/smc91x.h Arnd Bergmann 2016-08-25  429  	}								     \
09779c6d drivers/net/smc91x.h               Nicolas Pitre 2006-03-20  430  } while (0)
39e82d37 drivers/net/ethernet/smsc/smc91x.h Arnd Bergmann 2016-08-25  431  
39e82d37 drivers/net/ethernet/smsc/smc91x.h Arnd Bergmann 2016-08-25  432  #define SMC_in16(ioaddr, reg)						     \

:::::: The code at line 424 was first introduced by commit
:::::: 09779c6df2dbe95483269d194b327d41fe2cc57e [PATCH] smc91x: allow for dynamic bus access configs

:::::: TO: Nicolas Pitre <nico@cam.org>
:::::: CC: Jeff Garzik <jeff@garzik.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 9595 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160826/5e104280/attachment.obj>
