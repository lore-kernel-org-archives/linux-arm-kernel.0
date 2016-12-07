From: lkp@intel.com (kbuild test robot)
Date: Wed, 7 Dec 2016 18:37:26 +0800
Subject: [PATCH 2/7] arm: ftrace: Add call modify mechanism
In-Reply-To: <1481043967-15602-3-git-send-email-abelvesa@linux.com>
Message-ID: <201612071833.2LIq3ZdA%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abel,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.9-rc8 next-20161206]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Abel-Vesa/arm-Add-livepatch-support/20161207-074210
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the linux-review/Abel-Vesa/arm-Add-livepatch-support/20161207-074210 HEAD 49113edc744f38a682a4afa9e904384bb00f2988 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> arch/arm/kernel/ftrace.c:163:5: error: redefinition of 'ftrace_modify_call'
    int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
        ^~~~~~~~~~~~~~~~~~
   In file included from arch/arm/kernel/ftrace.c:15:0:
   include/linux/ftrace.h:595:19: note: previous definition of 'ftrace_modify_call' was here
    static inline int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
                      ^~~~~~~~~~~~~~~~~~

vim +/ftrace_modify_call +163 arch/arm/kernel/ftrace.c

   157		}
   158	#endif
   159	
   160		return ret;
   161	}
   162	
 > 163	int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
   164		       unsigned long addr)
   165	{
   166		unsigned long pc = rec->ip;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59384 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161207/a5fd880a/attachment-0001.gz>
