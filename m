From: lkp@intel.com (kbuild test robot)
Date: Mon, 29 Oct 2018 16:54:03 +0800
Subject: [PATCH] ARM: module: Fix function kallsyms on Thumb-2
In-Reply-To: <20181029082555.32626-1-vincent.whitchurch@axis.com>
References: <20181029082555.32626-1-vincent.whitchurch@axis.com>
Message-ID: <201810291629.DTMbJE2a%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vincent,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on arm/for-next]
[also build test WARNING on v4.19 next-20181019]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Vincent-Whitchurch/ARM-module-Fix-function-kallsyms-on-Thumb-2/20181029-162842
base:   git://git.armlinux.org.uk/~rmk/linux-arm.git for-next
config: i386-randconfig-x000-201843 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from kernel/bpf/core.c:28:0:
>> include/linux/moduleloader.h:89:35: warning: 'struct mod_kallsyms' declared inside parameter list will not be visible outside of this definition or declaration
    void module_fixup_kallsyms(struct mod_kallsyms *kallsyms);
                                      ^~~~~~~~~~~~

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
Size: 29535 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181029/a296bddc/attachment-0001.gz>
