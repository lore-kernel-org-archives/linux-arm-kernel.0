From: lkp@intel.com (kbuild test robot)
Date: Wed, 6 Jun 2018 05:34:29 +0800
Subject: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
In-Reply-To: <1528186420-6615-3-git-send-email-changbin.du@intel.com>
References: <1528186420-6615-3-git-send-email-changbin.du@intel.com>
Message-ID: <201806060444.hdHcKOBy%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Changbin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.17 next-20180605]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/changbin-du-intel-com/kernel-hacking-GCC-optimization-for-better-debug-experience-Og/20180606-001415
config: sparc64-allyesconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All warnings (new ones prefixed by >>):

>> WARNING: vmlinux.o(.text.unlikely+0x1fc): Section mismatch in reference from the function init_tick_ops() to the function .init.text:get_tick_patch()
   The function init_tick_ops() references
   the function __init get_tick_patch().
   This is often because init_tick_ops lacks a __init
   annotation or the annotation of get_tick_patch is wrong.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 53264 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180606/a2ea7dd7/attachment-0001.gz>
