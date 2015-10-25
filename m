From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 25 Oct 2015 23:46:01 +0800
Subject: [arm-platforms:kvm/wsinc 14/14] arch/arm64/kvm/hyp/hyp-entry.S:152:
 undefined reference to `__kvm_hyp_panic'
Message-ID: <201510252355.c5yDGrMP%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm/wsinc
head:   a805124bc5884b6d4cbff8ae95974d229641dcfd
commit: a805124bc5884b6d4cbff8ae95974d229641dcfd [14/14] wsinc: hyp entry
config: arm64-defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout a805124bc5884b6d4cbff8ae95974d229641dcfd
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/kvm/built-in.o: In function `el2t_sync_invalid':
>> arch/arm64/kvm/hyp/hyp-entry.S:152: undefined reference to `__kvm_hyp_panic'
   arch/arm64/kvm/built-in.o: In function `el2t_irq_invalid':
   arch/arm64/kvm/hyp/hyp-entry.S:153: undefined reference to `__kvm_hyp_panic'
   arch/arm64/kvm/built-in.o: In function `el2t_fiq_invalid':
   arch/arm64/kvm/hyp/hyp-entry.S:154: undefined reference to `__kvm_hyp_panic'
   arch/arm64/kvm/built-in.o: In function `el2t_error_invalid':
   arch/arm64/kvm/hyp/hyp-entry.S:155: undefined reference to `__kvm_hyp_panic'
   arch/arm64/kvm/built-in.o: In function `el2h_sync_invalid':
   arch/arm64/kvm/hyp/hyp-entry.S:156: undefined reference to `__kvm_hyp_panic'
   arch/arm64/kvm/built-in.o:arch/arm64/kvm/hyp/hyp-entry.S:157: more undefined references to `__kvm_hyp_panic' follow

vim +152 arch/arm64/kvm/hyp/hyp-entry.S

   146	\label:
   147		b \target
   148	ENDPROC(\label)
   149	.endm
   150	
   151		/* None of these should ever happen */
 > 152		invalid_vector	el2t_sync_invalid
   153		invalid_vector	el2t_irq_invalid
   154		invalid_vector	el2t_fiq_invalid
   155		invalid_vector	el2t_error_invalid

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 16478 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151025/c568ceb8/attachment-0001.obj>
