From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 28 Oct 2015 17:50:40 +0800
Subject: [arm-platforms:kvm-arm64/vhe-wsinc 27/31] arch/arm/kvm/mmu.c:597:2:
 error: implicit declaration of function 'is_kernel_in_hyp_mode'
Message-ID: <201510281738.XuP5AVMf%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/vhe-wsinc
head:   de3f90e8d3e0751d8bfb2ed946eb4fdbf880d549
commit: 6df2cc7cc0972deb9f639ab14a68c11f0a55e2e7 [27/31] arm64: KVM: skip HYP setup when already running in HYP
config: arm-axm55xx_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 6df2cc7cc0972deb9f639ab14a68c11f0a55e2e7
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kvm/mmu.c: In function 'create_hyp_mappings':
>> arch/arm/kvm/mmu.c:597:2: error: implicit declaration of function 'is_kernel_in_hyp_mode' [-Werror=implicit-function-declaration]
     if (is_kernel_in_hyp_mode())
     ^
   cc1: some warnings being treated as errors

vim +/is_kernel_in_hyp_mode +597 arch/arm/kvm/mmu.c

   591	{
   592		phys_addr_t phys_addr;
   593		unsigned long virt_addr;
   594		unsigned long start = KERN_TO_HYP((unsigned long)from);
   595		unsigned long end = KERN_TO_HYP((unsigned long)to);
   596	
 > 597		if (is_kernel_in_hyp_mode())
   598			return 0;
   599	
   600		start = start & PAGE_MASK;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 18300 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151028/384a3c2e/attachment-0001.obj>
