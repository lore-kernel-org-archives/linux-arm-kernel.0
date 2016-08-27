From: lkp@intel.com (kbuild test robot)
Date: Sat, 27 Aug 2016 19:37:16 +0800
Subject: [PATCH 1/2] smc91x: always use 8-bit access if necessary
In-Reply-To: <20160825144633.1850889-1-arnd@arndb.de>
Message-ID: <201608271947.Af1MLYUW%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

[auto build test WARNING on net-next/master]
[also build test WARNING on v4.8-rc3 next-20160825]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/smc91x-always-use-8-bit-access-if-necessary/20160825-225929
config: m32r-allyesconfig (attached as .config)
compiler: m32r-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m32r 

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:1015:28: note: in expansion of macro 'SMC_out16'
    #define SMC_SET_TCR(lp, x) SMC_out16(x, ioaddr, TCR_REG(lp))
                               ^
   drivers/net/ethernet/smsc/smc91x.c:1028:3: note: in expansion of macro 'SMC_SET_TCR'
      SMC_SET_TCR(lp, lp->tcr_cur_mode);
      ^
   drivers/net/ethernet/smsc/smc91x.c: In function 'smc_phy_configure':
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:1077:2: note: in expansion of macro 'SMC_SELECT_BANK'
     SMC_SELECT_BANK(lp, 0);
     ^
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:1010:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, RPC_REG(lp));  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:1078:2: note: in expansion of macro 'SMC_SET_RPC'
     SMC_SET_RPC(lp, lp->rpc_cur_mode);
     ^
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:1135:2: note: in expansion of macro 'SMC_SELECT_BANK'
     SMC_SELECT_BANK(lp, 2);
     ^
   drivers/net/ethernet/smsc/smc91x.c: In function 'smc_10bt_check_media':
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:1176:2: note: in expansion of macro 'SMC_SELECT_BANK'
     SMC_SELECT_BANK(lp, 0);
     ^
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:1178:2: note: in expansion of macro 'SMC_SELECT_BANK'
     SMC_SELECT_BANK(lp, 2);
     ^
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
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:959:28: note: in expansion of macro 'SMC_out16'
    #define SMC_SET_CTL(lp, x) SMC_out16(x, ioaddr, CTL_REG(lp))
                               ^
   drivers/net/ethernet/smsc/smc91x.c:1202:2: note: in expansion of macro 'SMC_SET_CTL'
     SMC_SET_CTL(lp, ctl & ~CTL_LE_ENABLE);
     ^
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:959:28: note: in expansion of macro 'SMC_out16'
    #define SMC_SET_CTL(lp, x) SMC_out16(x, ioaddr, CTL_REG(lp))
                               ^
   drivers/net/ethernet/smsc/smc91x.c:1203:2: note: in expansion of macro 'SMC_SET_CTL'
     SMC_SET_CTL(lp, ctl);
     ^
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:1204:2: note: in expansion of macro 'SMC_SELECT_BANK'
     SMC_SELECT_BANK(lp, 2);
     ^
   drivers/net/ethernet/smsc/smc91x.c: In function 'smc_interrupt':
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
>> include/linux/dynamic_debug.h:143:12: note: in expansion of macro 'SMC_SELECT_BANK'
             ##__VA_ARGS__);  \
               ^
>> include/linux/netdevice.h:4276:2: note: in expansion of macro 'dynamic_netdev_dbg'
     dynamic_netdev_dbg(__dev, format, ##args);  \
     ^
   drivers/net/ethernet/smsc/smc91x.c:159:4: note: in expansion of macro 'netdev_dbg'
       netdev_dbg(dev, fmt, ##__VA_ARGS__); \
       ^
   drivers/net/ethernet/smsc/smc91x.c:1238:3: note: in expansion of macro 'DBG'
      DBG(2, dev, "INT 0x%02x MASK 0x%02x MEM 0x%04x FIFO 0x%04x\n",
      ^
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
>> include/linux/dynamic_debug.h:143:12: note: in expansion of macro 'SMC_SELECT_BANK'
             ##__VA_ARGS__);  \
               ^
>> include/linux/netdevice.h:4276:2: note: in expansion of macro 'dynamic_netdev_dbg'
     dynamic_netdev_dbg(__dev, format, ##args);  \
     ^
   drivers/net/ethernet/smsc/smc91x.c:159:4: note: in expansion of macro 'netdev_dbg'
       netdev_dbg(dev, fmt, ##__VA_ARGS__); \
       ^
   drivers/net/ethernet/smsc/smc91x.c:1238:3: note: in expansion of macro 'DBG'
      DBG(2, dev, "INT 0x%02x MASK 0x%02x MEM 0x%04x FIFO 0x%04x\n",
      ^
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:1268:4: note: in expansion of macro 'SMC_SELECT_BANK'
       SMC_SELECT_BANK(lp, 0);
       ^
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:1270:4: note: in expansion of macro 'SMC_SELECT_BANK'
       SMC_SELECT_BANK(lp, 2);
       ^
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
>> include/linux/dynamic_debug.h:143:12: note: in expansion of macro 'SMC_SELECT_BANK'
             ##__VA_ARGS__);  \
               ^
>> include/linux/netdevice.h:4276:2: note: in expansion of macro 'dynamic_netdev_dbg'
     dynamic_netdev_dbg(__dev, format, ##args);  \
     ^
   drivers/net/ethernet/smsc/smc91x.c:159:4: note: in expansion of macro 'netdev_dbg'
       netdev_dbg(dev, fmt, ##__VA_ARGS__); \
       ^
   drivers/net/ethernet/smsc/smc91x.c:1279:4: note: in expansion of macro 'DBG'
       DBG(1, dev, "RX overrun (EPH_ST 0x%04x)\n",
       ^
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
>> include/linux/dynamic_debug.h:143:12: note: in expansion of macro 'SMC_SELECT_BANK'
             ##__VA_ARGS__);  \
               ^
>> include/linux/netdevice.h:4276:2: note: in expansion of macro 'dynamic_netdev_dbg'
     dynamic_netdev_dbg(__dev, format, ##args);  \
     ^
   drivers/net/ethernet/smsc/smc91x.c:159:4: note: in expansion of macro 'netdev_dbg'
       netdev_dbg(dev, fmt, ##__VA_ARGS__); \
       ^
   drivers/net/ethernet/smsc/smc91x.c:1279:4: note: in expansion of macro 'DBG'
       DBG(1, dev, "RX overrun (EPH_ST 0x%04x)\n",
       ^
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:992:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, PTR_REG(lp));  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:1298:2: note: in expansion of macro 'SMC_SET_PTR'
     SMC_SET_PTR(lp, saved_pointer);
     ^
   drivers/net/ethernet/smsc/smc91x.c: In function 'smc_timeout':
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:1347:2: note: in expansion of macro 'SMC_SELECT_BANK'
     SMC_SELECT_BANK(lp, 0);
     ^
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:1350:2: note: in expansion of macro 'SMC_SELECT_BANK'
     SMC_SELECT_BANK(lp, 2);
     ^
   drivers/net/ethernet/smsc/smc91x.c: In function 'smc_set_multicast_list':
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:1456:2: note: in expansion of macro 'SMC_SELECT_BANK'
     SMC_SELECT_BANK(lp, 0);
     ^
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:999:28: note: in expansion of macro 'SMC_out16'
    #define SMC_SET_RCR(lp, x) SMC_out16(x, ioaddr, RCR_REG(lp))
                               ^
   drivers/net/ethernet/smsc/smc91x.c:1457:2: note: in expansion of macro 'SMC_SET_RCR'
     SMC_SET_RCR(lp, lp->rcr_cur_mode);
     ^
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:944:4: note: in expansion of macro 'SMC_out16'
       SMC_out16(x, ioaddr, BANK_SELECT);  \
       ^
   drivers/net/ethernet/smsc/smc91x.c:1459:3: note: in expansion of macro 'SMC_SELECT_BANK'
      SMC_SELECT_BANK(lp, 3);
      ^
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:1040:3: note: in expansion of macro 'SMC_out16'
      SMC_out16(mt[0] | (mt[1] << 8), ioaddr, MCAST_REG1(lp)); \
      ^
   drivers/net/ethernet/smsc/smc91x.c:1460:3: note: in expansion of macro 'SMC_SET_MCAST'
      SMC_SET_MCAST(lp, multicast_table);
      ^
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:1041:3: note: in expansion of macro 'SMC_out16'
      SMC_out16(mt[2] | (mt[3] << 8), ioaddr, MCAST_REG2(lp)); \
      ^
   drivers/net/ethernet/smsc/smc91x.c:1460:3: note: in expansion of macro 'SMC_SET_MCAST'
      SMC_SET_MCAST(lp, multicast_table);
      ^
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:1042:3: note: in expansion of macro 'SMC_out16'
      SMC_out16(mt[4] | (mt[5] << 8), ioaddr, MCAST_REG3(lp)); \
      ^
   drivers/net/ethernet/smsc/smc91x.c:1460:3: note: in expansion of macro 'SMC_SET_MCAST'
      SMC_SET_MCAST(lp, multicast_table);
      ^
   drivers/net/ethernet/smsc/smc91x.h:424:16: warning: unused variable '__val16' [-Wunused-variable]
      unsigned int __val16 = (x);         \
                   ^
   drivers/net/ethernet/smsc/smc91x.h:1043:3: note: in expansion of macro 'SMC_out16'
      SMC_out16(mt[6] | (mt[7] << 8), ioaddr, MCAST_REG4(lp)); \
      ^
   drivers/net/ethernet/smsc/smc91x.c:1460:3: note: in expansion of macro 'SMC_SET_MCAST'
      SMC_SET_MCAST(lp, multicast_table);
      ^

vim +/SMC_SELECT_BANK +143 include/linux/dynamic_debug.h

07613b0b5 Jason Baron         2011-10-04  127  				   ##__VA_ARGS__);		\
e9d376f0f Jason Baron         2009-02-05  128  } while (0)
e9d376f0f Jason Baron         2009-02-05  129  
07613b0b5 Jason Baron         2011-10-04  130  #define dynamic_dev_dbg(dev, fmt, ...)				\
07613b0b5 Jason Baron         2011-10-04  131  do {								\
07613b0b5 Jason Baron         2011-10-04  132  	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);		\
9049fc745 Jason Baron         2016-08-03  133  	if (DYNAMIC_DEBUG_BRANCH(descriptor))			\
07613b0b5 Jason Baron         2011-10-04  134  		__dynamic_dev_dbg(&descriptor, dev, fmt,	\
07613b0b5 Jason Baron         2011-10-04  135  				  ##__VA_ARGS__);		\
e9d376f0f Jason Baron         2009-02-05  136  } while (0)
e9d376f0f Jason Baron         2009-02-05  137  
07613b0b5 Jason Baron         2011-10-04  138  #define dynamic_netdev_dbg(dev, fmt, ...)			\
07613b0b5 Jason Baron         2011-10-04  139  do {								\
07613b0b5 Jason Baron         2011-10-04  140  	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);		\
9049fc745 Jason Baron         2016-08-03  141  	if (DYNAMIC_DEBUG_BRANCH(descriptor))			\
07613b0b5 Jason Baron         2011-10-04  142  		__dynamic_netdev_dbg(&descriptor, dev, fmt,	\
07613b0b5 Jason Baron         2011-10-04 @143  				     ##__VA_ARGS__);		\
ffa10cb47 Jason Baron         2011-08-11  144  } while (0)
ffa10cb47 Jason Baron         2011-08-11  145  
7a555613e Vladimir Kondratiev 2012-12-05  146  #define dynamic_hex_dump(prefix_str, prefix_type, rowsize,	\
7a555613e Vladimir Kondratiev 2012-12-05  147  			 groupsize, buf, len, ascii)		\
7a555613e Vladimir Kondratiev 2012-12-05  148  do {								\
7a555613e Vladimir Kondratiev 2012-12-05  149  	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,		\
7a555613e Vladimir Kondratiev 2012-12-05  150  		__builtin_constant_p(prefix_str) ? prefix_str : "hexdump");\
9049fc745 Jason Baron         2016-08-03  151  	if (DYNAMIC_DEBUG_BRANCH(descriptor))			\

:::::: The code at line 143 was first introduced by commit
:::::: 07613b0b5ef8570033aa806d1731dce599862223 dynamic_debug: consolidate repetitive struct _ddebug descriptor definitions

:::::: TO: Jason Baron <jbaron@redhat.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 36404 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160827/ee4ec88a/attachment-0001.obj>
