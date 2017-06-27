From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 27 Jun 2017 22:30:36 +0800
Subject: [arm-platforms:kvm-arm64/gicv4-kvm 27/62]
 drivers/irqchip/irq-gic-v3-its.c:795:7: error: 'UNMAP_VLPI' undeclared
Message-ID: <201706272215.VcfwlmKc%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/gicv4-kvm
head:   362f13c96426700d3e37a921ef6d551f01491992
commit: 2a99ea393c9d1e8593bfca5c751031d227ad5cb3 [27/62] irqchip/gic-v3-its: Add VLPI configuration hook
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 2a99ea393c9d1e8593bfca5c751031d227ad5cb3
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the arm-platforms/kvm-arm64/gicv4-kvm HEAD 362f13c96426700d3e37a921ef6d551f01491992 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/irqchip/irq-gic-v3-its.c: In function 'its_irq_set_vcpu_affinity':
>> drivers/irqchip/irq-gic-v3-its.c:795:7: error: 'UNMAP_VLPI' undeclared (first use in this function)
     case UNMAP_VLPI:
          ^~~~~~~~~~
   drivers/irqchip/irq-gic-v3-its.c:795:7: note: each undeclared identifier is reported only once for each function it appears in

vim +/UNMAP_VLPI +795 drivers/irqchip/irq-gic-v3-its.c

   789		if (!its_dev->its->is_v4 || !info)
   790			return -EINVAL;
   791	
   792		switch (info->cmd_type) {
   793		case MAP_VLPI:
   794	
 > 795		case UNMAP_VLPI:
   796	
   797		case PROP_UPDATE_VLPI:
   798		case PROP_UPDATE_AND_INV_VLPI:

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 35412 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170627/afeebbb5/attachment-0001.gz>
