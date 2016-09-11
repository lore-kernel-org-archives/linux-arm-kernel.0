From: lkp@intel.com (kbuild test robot)
Date: Sun, 11 Sep 2016 12:31:50 +0800
Subject: [PATCH] atomic64: No need for
 CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
In-Reply-To: <1473352098-5822-1-git-send-email-vgupta@synopsys.com>
Message-ID: <201609111259.q67d9T4B%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vineet,

[auto build test ERROR on arm64/for-next/core]
[cannot apply to linus/master linux/master v4.8-rc5 next-20160909]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Vineet-Gupta/atomic64-No-need-for-CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE/20160909-013936
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   lib/atomic64_test.c: In function 'test_atomic64':
>> lib/atomic64_test.c:217:2: error: implicit declaration of function 'atomic64_dec_if_positive' [-Werror=implicit-function-declaration]
     BUG_ON(atomic64_dec_if_positive(&v) != (onestwos - 1));
     ^
   cc1: some warnings being treated as errors

vim +/atomic64_dec_if_positive +217 lib/atomic64_test.c

86a89380 Luca Barbieri 2010-02-24  211  	INIT(v0);
9efbcd59 Luca Barbieri 2010-03-01  212  	BUG_ON(!atomic64_add_unless(&v, one, v1));
86a89380 Luca Barbieri 2010-02-24  213  	r += one;
86a89380 Luca Barbieri 2010-02-24  214  	BUG_ON(v.counter != r);
86a89380 Luca Barbieri 2010-02-24  215  
86a89380 Luca Barbieri 2010-02-24  216  	INIT(onestwos);
86a89380 Luca Barbieri 2010-02-24 @217  	BUG_ON(atomic64_dec_if_positive(&v) != (onestwos - 1));
86a89380 Luca Barbieri 2010-02-24  218  	r -= one;
86a89380 Luca Barbieri 2010-02-24  219  	BUG_ON(v.counter != r);
86a89380 Luca Barbieri 2010-02-24  220  

:::::: The code at line 217 was first introduced by commit
:::::: 86a8938078a8bb518c5376de493e348c7490d506 lib: Add self-test for atomic64_t

:::::: TO: Luca Barbieri <luca@luca-barbieri.com>
:::::: CC: H. Peter Anvin <hpa@zytor.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 44278 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160911/f694dbce/attachment-0001.obj>
