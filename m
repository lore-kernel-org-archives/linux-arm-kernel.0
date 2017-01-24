From: lkp@intel.com (kbuild test robot)
Date: Wed, 25 Jan 2017 02:38:59 +0800
Subject: [PATCH v2] KVM: arm/arm64: vgic: Add debugfs vgic-state file
In-Reply-To: <20170124132555.19094-1-christoffer.dall@linaro.org>
Message-ID: <201701250224.SpXg3xR2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

[auto build test ERROR on kvmarm/next]
[also build test ERROR on v4.10-rc5 next-20170124]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Christoffer-Dall/KVM-arm-arm64-vgic-Add-debugfs-vgic-state-file/20170124-234016
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-debug.c: In function 'print_irq_state':
>> arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-debug.c:195:7: error: 'struct vgic_irq' has no member named 'pending_latch'; did you mean 'pending'?
       irq->pending_latch,
          ^~

vim +195 arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-debug.c

   189			      " %2x "
   190			      " %2x "
   191			      "     %2d "
   192			      "\n",
   193				type, irq->intid,
   194				(irq->target_vcpu) ? irq->target_vcpu->vcpu_id : -1,
 > 195				irq->pending_latch,
   196				irq->line_level,
   197				irq->active,
   198				irq->enabled,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 32979 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/9485238f/attachment-0001.gz>
