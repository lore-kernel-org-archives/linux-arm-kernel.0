From: lkp@intel.com (kbuild test robot)
Date: Wed, 4 Oct 2017 17:08:08 +0800
Subject: [PATCH v4 03/10] kexec_file: factor out arch_kexec_kernel_*()
 from x86, powerpc
In-Reply-To: <20171002061431.11117-4-takahiro.akashi@linaro.org>
Message-ID: <201710041658.Ukz7Eof0%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi AKASHI,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.14-rc3 next-20170929]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/AKASHI-Takahiro/arm64-kexec-add-kexec_file_load-support/20171004-163130
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: x86_64-randconfig-x000-201740 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> arch/x86/kernel/kexec-bzimage64.c:541:29: error: conflicting type qualifiers for 'kexec_bzImage64_ops'
    const struct kexec_file_ops kexec_bzImage64_ops = {
                                ^~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/kernel/kexec-bzimage64.c:29:0:
   arch/x86/include/asm/kexec-bzimage64.h:4:30: note: previous declaration of 'kexec_bzImage64_ops' was here
    extern struct kexec_file_ops kexec_bzImage64_ops;
                                 ^~~~~~~~~~~~~~~~~~~

vim +/kexec_bzImage64_ops +541 arch/x86/kernel/kexec-bzimage64.c

   540	
 > 541	const struct kexec_file_ops kexec_bzImage64_ops = {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 27479 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171004/8a75116f/attachment-0001.gz>
