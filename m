From: lkp@intel.com (kbuild test robot)
Date: Wed, 7 Dec 2016 10:08:26 +0800
Subject: [PATCH 3/7] arm: module: Add apply_relocate_add
In-Reply-To: <1481043967-15602-4-git-send-email-abelvesa@linux.com>
Message-ID: <201612071023.rq676L5J%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abel,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.9-rc8 next-20161206]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Abel-Vesa/arm-Add-livepatch-support/20161207-074210
config: arm-simpad_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the linux-review/Abel-Vesa/arm-Add-livepatch-support/20161207-074210 HEAD 49113edc744f38a682a4afa9e904384bb00f2988 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> arch/arm/kernel/module.c:55:1: error: redefinition of 'apply_relocate_add'
    apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,
    ^~~~~~~~~~~~~~~~~~
   In file included from arch/arm/kernel/module.c:14:0:
   include/linux/moduleloader.h:65:19: note: previous definition of 'apply_relocate_add' was here
    static inline int apply_relocate_add(Elf_Shdr *sechdrs,
                      ^~~~~~~~~~~~~~~~~~

vim +/apply_relocate_add +55 arch/arm/kernel/module.c

    49					GFP_KERNEL, PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
    50					__builtin_return_address(0));
    51	}
    52	#endif
    53	
    54	int
  > 55	apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,
    56			   unsigned int symindex, unsigned int relindex,
    57			   struct module *module)
    58	{

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 12460 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161207/f20a428d/attachment-0001.gz>
