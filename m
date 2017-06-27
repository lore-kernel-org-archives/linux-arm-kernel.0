From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 28 Jun 2017 03:14:30 +0800
Subject: [arm-platforms:kvm-arm64/gicv4-kvm 49/62]
 arch/arm/kvm/../../../virt/kvm/arm/arm.c:1465: undefined reference to
 `kvm_vgic_v4_set_forwarding'
Message-ID: <201706280327.lIGwiqGr%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/gicv4-kvm
head:   362f13c96426700d3e37a921ef6d551f01491992
commit: fb4d9e42b5d97aacf74f33b053f7786ed442328d [49/62] KVM: arm/arm64: GICv4: Wire mapping/unmapping of VLPIs in VFIO irq bypass
config: arm-axm55xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout fb4d9e42b5d97aacf74f33b053f7786ed442328d
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kvm/built-in.o: In function `kvm_arch_irq_bypass_add_producer':
>> arch/arm/kvm/../../../virt/kvm/arm/arm.c:1465: undefined reference to `kvm_vgic_v4_set_forwarding'
   arch/arm/kvm/built-in.o: In function `kvm_arch_irq_bypass_del_producer':
   arch/arm/kvm/../../../virt/kvm/arm/arm.c:1484: undefined reference to `kvm_vgic_v4_set_forwarding'
   arch/arm/kvm/built-in.o: In function `kvm_vgic_dist_destroy':
   arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-init.c:334: undefined reference to `vgic_v4_teardown'
   arch/arm/kvm/built-in.o: In function `vgic_init':
   arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-init.c:291: undefined reference to `vgic_v4_init'

vim +1465 arch/arm/kvm/../../../virt/kvm/arm/arm.c

  1459	
  1460		switch (prod->type) {
  1461		case IRQ_BYPASS_VFIO_PLATFORM:
  1462			return kvm_vgic_set_forwarding(irqfd->kvm, prod->irq,
  1463						       irqfd->gsi + VGIC_NR_PRIVATE_IRQS);
  1464		case IRQ_BYPASS_VFIO_PCI_MSI:
> 1465			return kvm_vgic_v4_set_forwarding(irqfd->kvm, prod->irq,
  1466							  &irqfd->irq_entry);
  1467		default:
  1468			return 0;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 20100 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170628/b61d132c/attachment-0001.gz>
