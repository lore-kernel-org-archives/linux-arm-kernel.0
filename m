From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 26 Jun 2017 06:49:56 +0800
Subject: [arm-platforms:kvm-arm64/gicv4-kvm 45/45]
 arch/arm/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:262:22: error:
 'struct its_vpe' has no member named 'vm'
Message-ID: <201706260654.8gOWq9qa%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/gicv4-kvm
head:   6930e5891d9ee6507e03e79a72d419e48c3f89cc
commit: 6930e5891d9ee6507e03e79a72d419e48c3f89cc [45/45] KVM: arm/arm64: GICv4: Enable virtual cpuif if VLPIs can be delivered
config: arm-axm55xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 6930e5891d9ee6507e03e79a72d419e48c3f89cc
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c: In function '__vgic_v3_save_state':
>> arch/arm/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:262:22: error: 'struct its_vpe' has no member named 'vm'
          cpu_if->its_vpe.vm)
                         ^
   arch/arm/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c: In function '__vgic_v3_restore_state':
   arch/arm/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:345:22: error: 'struct its_vpe' has no member named 'vm'
          cpu_if->its_vpe.vm)
                         ^

vim +262 arch/arm/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c

   256				cpu_if->vgic_ap1r[1] = __vgic_v3_read_ap1rn(1);
   257			default:
   258				cpu_if->vgic_ap1r[0] = __vgic_v3_read_ap1rn(0);
   259			}
   260		} else {
   261			if (static_branch_unlikely(&vgic_v3_cpuif_trap) ||
 > 262			    cpu_if->its_vpe.vm)
   263				write_gicreg(0, ICH_HCR_EL2);
   264	
   265			cpu_if->vgic_elrsr = 0xffff;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 20100 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170626/34c31771/attachment-0001.gz>
