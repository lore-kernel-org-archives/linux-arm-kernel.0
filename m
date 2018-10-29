From: lkp@intel.com (kbuild test robot)
Date: Mon, 29 Oct 2018 21:26:00 +0800
Subject: [PATCH] ARM: module: Fix function kallsyms on Thumb-2
In-Reply-To: <20181029082555.32626-1-vincent.whitchurch@axis.com>
References: <20181029082555.32626-1-vincent.whitchurch@axis.com>
Message-ID: <201810292125.rfA5v9Bj%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vincent,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on arm/for-next]
[also build test WARNING on v4.19 next-20181029]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Vincent-Whitchurch/ARM-module-Fix-function-kallsyms-on-Thumb-2/20181029-162842
base:   git://git.armlinux.org.uk/~rmk/linux-arm.git for-next
config: x86_64-randconfig-j1-10290909 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from kernel/bpf/core.c:28:0:
>> include/linux/moduleloader.h:89:35: warning: 'struct mod_kallsyms' declared inside parameter list
    void module_fixup_kallsyms(struct mod_kallsyms *kallsyms);
                                      ^
>> include/linux/moduleloader.h:89:35: warning: its scope is only this definition or declaration, which is probably not what you want

vim +89 include/linux/moduleloader.h

    88	
  > 89	void module_fixup_kallsyms(struct mod_kallsyms *kallsyms);
    90	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28176 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181029/7adec077/attachment-0001.gz>
