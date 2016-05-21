From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 21 May 2016 22:46:38 +0800
Subject: [arm-platforms:kvm-arm64/vgic-fixes-4.7 5/6]
 arch/arm64/kvm/sys_regs.c:144:3: error: 'struct sys_reg_params' has no
 member named 'retval'
Message-ID: <201605212236.l8y8YZJr%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/vgic-fixes-4.7
head:   1ff896af0190c4244ceab0658407da5095b40076
commit: 3320e0e2679738f8f46310412410786f379ad095 [5/6] arm64: KVM: Make ICC_SRE_EL1 access return the configured SRE value
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 3320e0e2679738f8f46310412410786f379ad095
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the arm-platforms/kvm-arm64/vgic-fixes-4.7 HEAD 1ff896af0190c4244ceab0658407da5095b40076 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   arch/arm64/kvm/sys_regs.c: In function 'access_gic_sre':
>> arch/arm64/kvm/sys_regs.c:144:3: error: 'struct sys_reg_params' has no member named 'retval'
     p->retval = vcpu->arch.vgic_cpu.vgic_v3.vgic_sre;
      ^

vim +144 arch/arm64/kvm/sys_regs.c

   138				   struct sys_reg_params *p,
   139				   const struct sys_reg_desc *r)
   140	{
   141		if (p->is_write)
   142			return ignore_write(vcpu, p);
   143	
 > 144		p->retval = vcpu->arch.vgic_cpu.vgic_v3.vgic_sre;
   145		return true;
   146	}
   147	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 22498 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160521/cb12f761/attachment-0001.obj>
