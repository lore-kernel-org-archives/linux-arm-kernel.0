From: lkp@intel.com (kbuild test robot)
Date: Mon, 25 Jun 2018 21:55:59 +0800
Subject: [PATCH v2 1/2] arm64/mm: Introduce init_pg_dir
In-Reply-To: <20180625113921.21854-2-yaojun8558363@gmail.com>
References: <20180625113921.21854-2-yaojun8558363@gmail.com>
Message-ID: <201806252028.MSru9XBo%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jun,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.18-rc2 next-20180625]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jun-Yao/arm64-mm-Introduce-init_pg_dir/20180625-194126
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: parisc-allyesconfig (attached as .config)
compiler: hppa-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=parisc 

All errors (new ones prefixed by >>):

>> mm/init-mm.c:20:10: error: 'init_pg_dir' undeclared here (not in a function); did you mean 'init_per_cpu'?
     .pgd  = init_pg_dir,
             ^~~~~~~~~~~
             init_per_cpu

vim +20 mm/init-mm.c

    17	
    18	struct mm_struct init_mm = {
    19		.mm_rb		= RB_ROOT,
  > 20		.pgd		= init_pg_dir,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 52576 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180625/ba5befae/attachment-0001.gz>
