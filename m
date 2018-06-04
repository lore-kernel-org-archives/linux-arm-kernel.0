From: lkp@intel.com (kbuild test robot)
Date: Tue, 5 Jun 2018 03:06:03 +0800
Subject: [PATCH v1 2/2] arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS
In-Reply-To: <1527772139-19665-3-git-send-email-gengdongjiu@huawei.com>
References: <1527772139-19665-3-git-send-email-gengdongjiu@huawei.com>
Message-ID: <201806050356.CUEc4QFL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dongjiu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on v4.17 next-20180601]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dongjiu-Geng/arm64-KVM-export-the-capability-to-set-guest-SError-syndrome/20180602-175846
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm-axm55xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   In file included from include/linux/kvm_host.h:37:0,
                    from arch/arm/kernel/asm-offsets.c:18:
>> arch/arm/include/asm/kvm_host.h:217:11: warning: 'struct kvm_vcpu_events' declared inside parameter list will not be visible outside of this definition or declaration
       struct kvm_vcpu_events *events);
              ^~~~~~~~~~~~~~~
   arch/arm/include/asm/kvm_host.h:220:11: warning: 'struct kvm_vcpu_events' declared inside parameter list will not be visible outside of this definition or declaration
       struct kvm_vcpu_events *events);
              ^~~~~~~~~~~~~~~

vim +217 arch/arm/include/asm/kvm_host.h

   210	
   211	int kvm_vcpu_preferred_target(struct kvm_vcpu_init *init);
   212	unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
   213	int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
   214	int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
   215	int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
   216	int kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
 > 217				struct kvm_vcpu_events *events);
   218	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 19855 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180605/eeecc0b2/attachment-0001.gz>
