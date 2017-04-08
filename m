From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 8 Apr 2017 22:16:11 +0800
Subject: [arm-platforms:kvm-arm64/tlb-abort 22/22]
 arch/arm64/kvm/../../../arch/arm/kvm/mmu.c:1433:3: error: implicit
 declaration of function 'kvm_inject_tlbabort'
Message-ID: <201704082207.SoKtBkqW%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/tlb-abort
head:   cb344ffd75d27204ef0e82e8d6a280b4edd19ac0
commit: cb344ffd75d27204ef0e82e8d6a280b4edd19ac0 [22/22] WIP
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout cb344ffd75d27204ef0e82e8d6a280b4edd19ac0
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/kvm/../../../arch/arm/kvm/mmu.c: In function 'kvm_handle_guest_abort':
>> arch/arm64/kvm/../../../arch/arm/kvm/mmu.c:1433:3: error: implicit declaration of function 'kvm_inject_tlbabort' [-Werror=implicit-function-declaration]
      kvm_inject_tlbabort(vcpu);
      ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/kvm_inject_tlbabort +1433 arch/arm64/kvm/../../../arch/arm/kvm/mmu.c

  1427		bool is_iabt, write_fault, writable;
  1428		gfn_t gfn;
  1429		int ret, idx;
  1430	
  1431		/* Check for TLB Conflict Abort */
  1432		if (kvm_vcpu_abt_tlbabort(vcpu)) {
> 1433			kvm_inject_tlbabort(vcpu);
  1434			return 1;
  1435		}
  1436	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 34538 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170408/7d748f13/attachment-0001.gz>
