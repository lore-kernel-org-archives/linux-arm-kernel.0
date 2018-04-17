From: lkp@intel.com (kbuild test robot)
Date: Wed, 18 Apr 2018 02:46:00 +0800
Subject: [arm-platforms:irq/level-msi 8/9] include/linux/dma-iommu.h:93:69:
 error: unknown type name 'dma_addr_t'
Message-ID: <201804180257.Q6etJ3Ho%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/level-msi
head:   38158ba494401627aff6018b4cd65d17d9a8d3e8
commit: 0f5775c792c5f600ddbd7e40a73b2444e6829482 [8/9] irqchip/gic-v3: Add support for Message Based Interrupts as an MSI controller
config: arm64-allnoconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 0f5775c792c5f600ddbd7e40a73b2444e6829482
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/irqchip/irq-gic-v3-mbi.c:20:0:
>> include/linux/dma-iommu.h:93:69: error: unknown type name 'dma_addr_t'
    static inline int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
                                                                        ^~~~~~~~~~
>> include/linux/dma-iommu.h:106:74: warning: 'struct list_head' declared inside parameter list will not be visible outside of this definition or declaration
    static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
                                                                             ^~~~~~~~~
>> drivers/irqchip/irq-gic-v3-mbi.c:60:23: error: 'pci_msi_domain_write_msg' undeclared here (not in a function); did you mean 'msi_domain_free_irqs'?
     .irq_write_msi_msg = pci_msi_domain_write_msg,
                          ^~~~~~~~~~~~~~~~~~~~~~~~
                          msi_domain_free_irqs
   drivers/irqchip/irq-gic-v3-mbi.c: In function 'mbi_allocate_domains':
>> drivers/irqchip/irq-gic-v3-mbi.c:218:15: error: implicit declaration of function 'pci_msi_create_irq_domain'; did you mean 'msi_create_irq_domain'? [-Werror=implicit-function-declaration]
     pci_domain = pci_msi_create_irq_domain(parent->fwnode,
                  ^~~~~~~~~~~~~~~~~~~~~~~~~
                  msi_create_irq_domain
>> drivers/irqchip/irq-gic-v3-mbi.c:218:13: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     pci_domain = pci_msi_create_irq_domain(parent->fwnode,
                ^
   cc1: some warnings being treated as errors
--
   In file included from drivers//irqchip/irq-gic-v3-mbi.c:20:0:
>> include/linux/dma-iommu.h:93:69: error: unknown type name 'dma_addr_t'
    static inline int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
                                                                        ^~~~~~~~~~
>> include/linux/dma-iommu.h:106:74: warning: 'struct list_head' declared inside parameter list will not be visible outside of this definition or declaration
    static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
                                                                             ^~~~~~~~~
   drivers//irqchip/irq-gic-v3-mbi.c:60:23: error: 'pci_msi_domain_write_msg' undeclared here (not in a function); did you mean 'msi_domain_free_irqs'?
     .irq_write_msi_msg = pci_msi_domain_write_msg,
                          ^~~~~~~~~~~~~~~~~~~~~~~~
                          msi_domain_free_irqs
   drivers//irqchip/irq-gic-v3-mbi.c: In function 'mbi_allocate_domains':
   drivers//irqchip/irq-gic-v3-mbi.c:218:15: error: implicit declaration of function 'pci_msi_create_irq_domain'; did you mean 'msi_create_irq_domain'? [-Werror=implicit-function-declaration]
     pci_domain = pci_msi_create_irq_domain(parent->fwnode,
                  ^~~~~~~~~~~~~~~~~~~~~~~~~
                  msi_create_irq_domain
   drivers//irqchip/irq-gic-v3-mbi.c:218:13: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     pci_domain = pci_msi_create_irq_domain(parent->fwnode,
                ^
   cc1: some warnings being treated as errors

vim +/dma_addr_t +93 include/linux/dma-iommu.h

0db2e5d1 Robin Murphy 2015-10-01   92  
fdbe574e Robin Murphy 2017-01-19  @93  static inline int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
fdbe574e Robin Murphy 2017-01-19   94  {
fdbe574e Robin Murphy 2017-01-19   95  	return -ENODEV;
fdbe574e Robin Murphy 2017-01-19   96  }
fdbe574e Robin Murphy 2017-01-19   97  
0db2e5d1 Robin Murphy 2015-10-01   98  static inline void iommu_put_dma_cookie(struct iommu_domain *domain)
0db2e5d1 Robin Murphy 2015-10-01   99  {
0db2e5d1 Robin Murphy 2015-10-01  100  }
0db2e5d1 Robin Murphy 2015-10-01  101  
44bb7e24 Robin Murphy 2016-09-12  102  static inline void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
44bb7e24 Robin Murphy 2016-09-12  103  {
44bb7e24 Robin Murphy 2016-09-12  104  }
44bb7e24 Robin Murphy 2016-09-12  105  
273df963 Robin Murphy 2017-03-16 @106  static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
273df963 Robin Murphy 2017-03-16  107  {
273df963 Robin Murphy 2017-03-16  108  }
273df963 Robin Murphy 2017-03-16  109  

:::::: The code at line 93 was first introduced by commit
:::::: fdbe574eb69312a7fbe09674d69c01b80e4ed9dc iommu/dma: Allow MSI-only cookies

:::::: TO: Robin Murphy <robin.murphy@arm.com>
:::::: CC: Will Deacon <will.deacon@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6595 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180418/67c9d36b/attachment.gz>
