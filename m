From: lkp@intel.com (kbuild test robot)
Date: Sun, 3 Jul 2016 13:17:52 +0800
Subject: [PATCH v2 1/2] arm64: implement FTRACE_WITH_REGS
In-Reply-To: <20160627151717.BD25468D26@newverein.lst.de>
Message-ID: <201607031342.UCz5nZSH%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.7-rc5 next-20160701]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Torsten-Duwe/arm64-live-patching/20160627-232728
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-allyesconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   Makefile:687: Cannot use CONFIG_KCOV: -fsanitize-coverage=trace-pc is not supported by compiler
>> aarch64-linux-gnu-gcc: error: unrecognized command line option '-fprolog-pad=2'
   make[2]: *** [kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 50257 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160703/45af0b23/attachment-0001.obj>
