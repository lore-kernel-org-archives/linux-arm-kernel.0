From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 22 Dec 2016 02:26:03 +0800
Subject: [arm-platforms:kvm-arm64/gicv4-wip 17/39]
 drivers/irqchip/irq-gic-v3-its.c:698:24: error: 'id' undeclared
Message-ID: <201612220258.0UxMBzO5%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/gicv4-wip
head:   1bca4673c546185e9812e8479900eca8a3ca9c33
commit: 1136731f544e664ab2990fe615c049ead0479b6d [17/39] irqchip/gic-v3-its: Generalize LPI configuration
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 1136731f544e664ab2990fe615c049ead0479b6d
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the arm-platforms/kvm-arm64/gicv4-wip HEAD 1bca4673c546185e9812e8479900eca8a3ca9c33 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/irqchip/irq-gic-v3-its.c: In function 'lpi_update_config':
>> drivers/irqchip/irq-gic-v3-its.c:698:24: error: 'id' undeclared (first use in this function)
     its_send_inv(its_dev, id);
                           ^~
   drivers/irqchip/irq-gic-v3-its.c:698:24: note: each undeclared identifier is reported only once for each function it appears in

vim +/id +698 drivers/irqchip/irq-gic-v3-its.c

c48ed51c Marc Zyngier 2014-11-24  692  	 * Humpf...
c48ed51c Marc Zyngier 2014-11-24  693  	 */
c48ed51c Marc Zyngier 2014-11-24  694  	if (gic_rdists->flags & RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING)
c48ed51c Marc Zyngier 2014-11-24  695  		__flush_dcache_area(cfg, sizeof(*cfg));
c48ed51c Marc Zyngier 2014-11-24  696  	else
c48ed51c Marc Zyngier 2014-11-24  697  		dsb(ishst);
c48ed51c Marc Zyngier 2014-11-24 @698  	its_send_inv(its_dev, id);
c48ed51c Marc Zyngier 2014-11-24  699  }
c48ed51c Marc Zyngier 2014-11-24  700  
c48ed51c Marc Zyngier 2014-11-24  701  static void its_mask_irq(struct irq_data *d)

:::::: The code at line 698 was first introduced by commit
:::::: c48ed51c0d101ec4351530bdd6e1a01808f0a441 irqchip: GICv3: ITS: irqchip implementation

:::::: TO: Marc Zyngier <marc.zyngier@arm.com>
:::::: CC: Jason Cooper <jason@lakedaemon.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 31902 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161222/15f88814/attachment-0001.gz>
