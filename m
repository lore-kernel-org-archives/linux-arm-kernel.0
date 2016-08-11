From: lkp@intel.com (kbuild test robot)
Date: Fri, 12 Aug 2016 03:32:44 +0800
Subject: [PATCH v3 1/2] arm64: implement FTRACE_WITH_REGS
In-Reply-To: <20160811163635.277C868C43@newverein.lst.de>
Message-ID: <201608120337.ncJVDfVQ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Torsten,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.8-rc1 next-20160811]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Torsten-Duwe/arm64-live-patching/20160812-004131
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/Makefile:61: Cannot use CONFIG_DYNAMIC_FTRACE_WITH_REGS: -fprolog-pad not supported by compiler
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
Size: 50394 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160812/b30b9cda/attachment-0001.obj>
