From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 4 Jun 2016 03:26:23 +0800
Subject: [arm-soc:to-build 1/141] warning: (ARM64) selects ARM_GIC_V2M which
 has unmet direct dependencies (ARM_GIC && ..)
Message-ID: <201606040319.hj4M23Yy%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git to-build
head:   48e65edd714769af2c23ed7e1017a948cb6595d3
commit: 98830bb0c58c1660fb074aa775c43cd5de990e8a [1/141] [NEEDS FIX] [SUBMITTED 20160317] arm/arm64/irqchip/pci: select PCI_MSI instead of depending on it
config: arm64-allnoconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 98830bb0c58c1660fb074aa775c43cd5de990e8a
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All error/warnings (new ones prefixed by >>):

warning: (ARM64 && HISILICON_IRQ_MBIGEN) selects ARM_GIC_V3_ITS which has unmet direct dependencies (PCI)
warning: (ARM64) selects ARM_GIC_V2M which has unmet direct dependencies (ARM_GIC && PCI)
>> drivers/irqchip/irq-gic-v2m.c:90:23: error: 'pci_msi_domain_write_msg' undeclared here (not in a function)
     .irq_write_msi_msg = pci_msi_domain_write_msg,
                          ^
>> drivers/irqchip/irq-gic-v2m.c:93:15: error: variable 'gicv2m_msi_domain_info' has initializer but incomplete type
    static struct msi_domain_info gicv2m_msi_domain_info = {
                  ^
>> drivers/irqchip/irq-gic-v2m.c:94:2: error: unknown field 'flags' specified in initializer
     .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
     ^
>> drivers/irqchip/irq-gic-v2m.c:94:12: error: 'MSI_FLAG_USE_DEF_DOM_OPS' undeclared here (not in a function)
     .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
               ^
>> drivers/irqchip/irq-gic-v2m.c:94:39: error: 'MSI_FLAG_USE_DEF_CHIP_OPS' undeclared here (not in a function)
     .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
                                          ^
>> drivers/irqchip/irq-gic-v2m.c:95:6: error: 'MSI_FLAG_PCI_MSIX' undeclared here (not in a function)
         MSI_FLAG_PCI_MSIX),
         ^
>> drivers/irqchip/irq-gic-v2m.c:94:11: warning: excess elements in struct initializer
     .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
              ^
   drivers/irqchip/irq-gic-v2m.c:94:11: note: (near initialization for 'gicv2m_msi_domain_info')
>> drivers/irqchip/irq-gic-v2m.c:96:2: error: unknown field 'chip' specified in initializer
     .chip = &gicv2m_msi_irq_chip,
     ^
   drivers/irqchip/irq-gic-v2m.c:96:10: warning: excess elements in struct initializer
     .chip = &gicv2m_msi_irq_chip,
             ^
   drivers/irqchip/irq-gic-v2m.c:96:10: note: (near initialization for 'gicv2m_msi_domain_info')
>> drivers/irqchip/irq-gic-v2m.c:239:15: error: variable 'gicv2m_pmsi_ops' has initializer but incomplete type
    static struct msi_domain_ops gicv2m_pmsi_ops = {
                  ^
>> drivers/irqchip/irq-gic-v2m.c:242:15: error: variable 'gicv2m_pmsi_domain_info' has initializer but incomplete type
    static struct msi_domain_info gicv2m_pmsi_domain_info = {
                  ^
   drivers/irqchip/irq-gic-v2m.c:243:2: error: unknown field 'flags' specified in initializer
     .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
     ^
   drivers/irqchip/irq-gic-v2m.c:243:11: warning: excess elements in struct initializer
     .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
              ^
   drivers/irqchip/irq-gic-v2m.c:243:11: note: (near initialization for 'gicv2m_pmsi_domain_info')
>> drivers/irqchip/irq-gic-v2m.c:244:2: error: unknown field 'ops' specified in initializer
     .ops = &gicv2m_pmsi_ops,
     ^
   drivers/irqchip/irq-gic-v2m.c:244:9: warning: excess elements in struct initializer
     .ops = &gicv2m_pmsi_ops,
            ^
   drivers/irqchip/irq-gic-v2m.c:244:9: note: (near initialization for 'gicv2m_pmsi_domain_info')
   drivers/irqchip/irq-gic-v2m.c:245:2: error: unknown field 'chip' specified in initializer
     .chip = &gicv2m_pmsi_irq_chip,
     ^
   drivers/irqchip/irq-gic-v2m.c:245:10: warning: excess elements in struct initializer
     .chip = &gicv2m_pmsi_irq_chip,
             ^
   drivers/irqchip/irq-gic-v2m.c:245:10: note: (near initialization for 'gicv2m_pmsi_domain_info')
   drivers/irqchip/irq-gic-v2m.c: In function 'gicv2m_allocate_domains':
>> drivers/irqchip/irq-gic-v2m.c:281:15: error: implicit declaration of function 'pci_msi_create_irq_domain' [-Werror=implicit-function-declaration]
     pci_domain = pci_msi_create_irq_domain(v2m->fwnode,
                  ^
>> drivers/irqchip/irq-gic-v2m.c:281:13: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     pci_domain = pci_msi_create_irq_domain(v2m->fwnode,
                ^
>> drivers/irqchip/irq-gic-v2m.c:284:16: error: implicit declaration of function 'platform_msi_create_irq_domain' [-Werror=implicit-function-declaration]
     plat_domain = platform_msi_create_irq_domain(v2m->fwnode,
                   ^
   drivers/irqchip/irq-gic-v2m.c:284:14: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     plat_domain = platform_msi_create_irq_domain(v2m->fwnode,
                 ^
   cc1: some warnings being treated as errors
--
>> drivers/irqchip/irq-gic-v3-its.c:1259:17: error: unknown type name 'msi_alloc_info_t'
          int nvec, msi_alloc_info_t *info)
                    ^
>> drivers/irqchip/irq-gic-v3-its.c:1298:15: error: variable 'its_msi_domain_ops' has initializer but incomplete type
    static struct msi_domain_ops its_msi_domain_ops = {
                  ^
>> drivers/irqchip/irq-gic-v3-its.c:1299:2: error: unknown field 'msi_prepare' specified in initializer
     .msi_prepare = its_msi_prepare,
     ^
>> drivers/irqchip/irq-gic-v3-its.c:1299:17: error: 'its_msi_prepare' undeclared here (not in a function)
     .msi_prepare = its_msi_prepare,
                    ^
>> drivers/irqchip/irq-gic-v3-its.c:1299:17: warning: excess elements in struct initializer
   drivers/irqchip/irq-gic-v3-its.c:1299:17: note: (near initialization for 'its_msi_domain_ops')
   drivers/irqchip/irq-gic-v3-its.c: In function 'its_irq_domain_alloc':
   drivers/irqchip/irq-gic-v3-its.c:1324:2: error: unknown type name 'msi_alloc_info_t'
     msi_alloc_info_t *info = args;
     ^
>> drivers/irqchip/irq-gic-v3-its.c:1325:35: error: request for member 'scratchpad' in something not a structure or union
     struct its_device *its_dev = info->scratchpad[0].ptr;
                                      ^
   drivers/irqchip/irq-gic-v3-its.c: In function 'its_probe':
>> drivers/irqchip/irq-gic-v3-its.c:1566:25: error: dereferencing pointer to incomplete type 'struct msi_domain_info'
      info = kzalloc(sizeof(*info), GFP_KERNEL);
                            ^
   drivers/irqchip/irq-gic-v3-its.c: At top level:
   drivers/irqchip/irq-gic-v3-its.c:1133:27: warning: 'its_find_device' defined but not used [-Wunused-function]
    static struct its_device *its_find_device(struct its_node *its, u32 dev_id)
                              ^
   drivers/irqchip/irq-gic-v3-its.c:1164:27: warning: 'its_create_device' defined but not used [-Wunused-function]
    static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
                              ^
--
>> drivers/irqchip/irq-gic-v3-its-pci-msi.c:40:23: error: 'pci_msi_domain_write_msg' undeclared here (not in a function)
     .irq_write_msi_msg = pci_msi_domain_write_msg,
                          ^
   In file included from include/linux/list.h:8:0,
                    from include/linux/kobject.h:20,
                    from include/linux/msi.h:4,
                    from drivers/irqchip/irq-gic-v3-its-pci-msi.c:18:
   drivers/irqchip/irq-gic-v3-its-pci-msi.c: In function 'its_pci_msi_vec_count':
>> drivers/irqchip/irq-gic-v3-its-pci-msi.c:52:12: error: implicit declaration of function 'pci_msi_vec_count' [-Werror=implicit-function-declaration]
     msi = max(pci_msi_vec_count(pdev), 0);
               ^
   include/linux/kernel.h:746:9: note: in definition of macro 'max'
     typeof(x) _max1 = (x);   \
            ^
>> drivers/irqchip/irq-gic-v3-its-pci-msi.c:53:13: error: implicit declaration of function 'pci_msix_vec_count' [-Werror=implicit-function-declaration]
     msix = max(pci_msix_vec_count(pdev), 0);
                ^
   include/linux/kernel.h:746:9: note: in definition of macro 'max'
     typeof(x) _max1 = (x);   \
            ^
   drivers/irqchip/irq-gic-v3-its-pci-msi.c: At top level:
>> drivers/irqchip/irq-gic-v3-its-pci-msi.c:69:21: error: unknown type name 'msi_alloc_info_t'
              int nvec, msi_alloc_info_t *info)
                        ^
>> drivers/irqchip/irq-gic-v3-its-pci-msi.c:93:15: error: variable 'its_pci_msi_ops' has initializer but incomplete type
    static struct msi_domain_ops its_pci_msi_ops = {
                  ^
>> drivers/irqchip/irq-gic-v3-its-pci-msi.c:94:2: error: unknown field 'msi_prepare' specified in initializer
     .msi_prepare = its_pci_msi_prepare,
     ^
>> drivers/irqchip/irq-gic-v3-its-pci-msi.c:94:17: error: 'its_pci_msi_prepare' undeclared here (not in a function)
     .msi_prepare = its_pci_msi_prepare,
                    ^
>> drivers/irqchip/irq-gic-v3-its-pci-msi.c:94:17: warning: excess elements in struct initializer
   drivers/irqchip/irq-gic-v3-its-pci-msi.c:94:17: note: (near initialization for 'its_pci_msi_ops')
>> drivers/irqchip/irq-gic-v3-its-pci-msi.c:97:15: error: variable 'its_pci_msi_domain_info' has initializer but incomplete type
    static struct msi_domain_info its_pci_msi_domain_info = {
                  ^
>> drivers/irqchip/irq-gic-v3-its-pci-msi.c:98:2: error: unknown field 'flags' specified in initializer
     .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
     ^
>> drivers/irqchip/irq-gic-v3-its-pci-msi.c:98:12: error: 'MSI_FLAG_USE_DEF_DOM_OPS' undeclared here (not in a function)
     .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
               ^
>> drivers/irqchip/irq-gic-v3-its-pci-msi.c:98:39: error: 'MSI_FLAG_USE_DEF_CHIP_OPS' undeclared here (not in a function)
     .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
                                          ^
>> drivers/irqchip/irq-gic-v3-its-pci-msi.c:99:6: error: 'MSI_FLAG_MULTI_PCI_MSI' undeclared here (not in a function)
         MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
         ^
>> drivers/irqchip/irq-gic-v3-its-pci-msi.c:99:31: error: 'MSI_FLAG_PCI_MSIX' undeclared here (not in a function)
         MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
                                  ^
   drivers/irqchip/irq-gic-v3-its-pci-msi.c:98:11: warning: excess elements in struct initializer
     .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
              ^
   drivers/irqchip/irq-gic-v3-its-pci-msi.c:98:11: note: (near initialization for 'its_pci_msi_domain_info')
>> drivers/irqchip/irq-gic-v3-its-pci-msi.c:100:2: error: unknown field 'ops' specified in initializer
     .ops = &its_pci_msi_ops,
     ^
   drivers/irqchip/irq-gic-v3-its-pci-msi.c:100:9: warning: excess elements in struct initializer
     .ops = &its_pci_msi_ops,
            ^
   drivers/irqchip/irq-gic-v3-its-pci-msi.c:100:9: note: (near initialization for 'its_pci_msi_domain_info')
>> drivers/irqchip/irq-gic-v3-its-pci-msi.c:101:2: error: unknown field 'chip' specified in initializer
     .chip = &its_msi_irq_chip,
     ^
   drivers/irqchip/irq-gic-v3-its-pci-msi.c:101:10: warning: excess elements in struct initializer
     .chip = &its_msi_irq_chip,
             ^
   drivers/irqchip/irq-gic-v3-its-pci-msi.c:101:10: note: (near initialization for 'its_pci_msi_domain_info')
   drivers/irqchip/irq-gic-v3-its-pci-msi.c: In function 'its_pci_msi_init':
>> drivers/irqchip/irq-gic-v3-its-pci-msi.c:120:19: error: implicit declaration of function 'msi_get_domain_info' [-Werror=implicit-function-declaration]
      if (!parent || !msi_get_domain_info(parent)) {
                      ^
>> drivers/irqchip/irq-gic-v3-its-pci-msi.c:126:8: error: implicit declaration of function 'pci_msi_create_irq_domain' [-Werror=implicit-function-declaration]
      if (!pci_msi_create_irq_domain(of_node_to_fwnode(np),
           ^
   drivers/irqchip/irq-gic-v3-its-pci-msi.c: At top level:
   drivers/irqchip/irq-gic-v3-its-pci-msi.c:58:12: warning: 'its_get_pci_alias' defined but not used [-Wunused-function]
    static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
               ^
   cc1: some warnings being treated as errors
--
>> drivers/irqchip/irq-gic-v3-its-platform-msi.c:28:18: error: unknown type name 'msi_alloc_info_t'
           int nvec, msi_alloc_info_t *info)
                     ^
>> drivers/irqchip/irq-gic-v3-its-platform-msi.c:61:15: error: variable 'its_pmsi_ops' has initializer but incomplete type
    static struct msi_domain_ops its_pmsi_ops = {
                  ^
>> drivers/irqchip/irq-gic-v3-its-platform-msi.c:62:2: error: unknown field 'msi_prepare' specified in initializer
     .msi_prepare = its_pmsi_prepare,
     ^
>> drivers/irqchip/irq-gic-v3-its-platform-msi.c:62:17: error: 'its_pmsi_prepare' undeclared here (not in a function)
     .msi_prepare = its_pmsi_prepare,
                    ^
>> drivers/irqchip/irq-gic-v3-its-platform-msi.c:62:17: warning: excess elements in struct initializer
   drivers/irqchip/irq-gic-v3-its-platform-msi.c:62:17: note: (near initialization for 'its_pmsi_ops')
>> drivers/irqchip/irq-gic-v3-its-platform-msi.c:65:15: error: variable 'its_pmsi_domain_info' has initializer but incomplete type
    static struct msi_domain_info its_pmsi_domain_info = {
                  ^
>> drivers/irqchip/irq-gic-v3-its-platform-msi.c:66:2: error: unknown field 'flags' specified in initializer
     .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
     ^
>> drivers/irqchip/irq-gic-v3-its-platform-msi.c:66:12: error: 'MSI_FLAG_USE_DEF_DOM_OPS' undeclared here (not in a function)
     .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
               ^
>> drivers/irqchip/irq-gic-v3-its-platform-msi.c:66:39: error: 'MSI_FLAG_USE_DEF_CHIP_OPS' undeclared here (not in a function)
     .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
                                          ^
   drivers/irqchip/irq-gic-v3-its-platform-msi.c:66:11: warning: excess elements in struct initializer
     .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
              ^
   drivers/irqchip/irq-gic-v3-its-platform-msi.c:66:11: note: (near initialization for 'its_pmsi_domain_info')
>> drivers/irqchip/irq-gic-v3-its-platform-msi.c:67:2: error: unknown field 'ops' specified in initializer
     .ops = &its_pmsi_ops,
     ^
   drivers/irqchip/irq-gic-v3-its-platform-msi.c:67:9: warning: excess elements in struct initializer
     .ops = &its_pmsi_ops,
            ^
   drivers/irqchip/irq-gic-v3-its-platform-msi.c:67:9: note: (near initialization for 'its_pmsi_domain_info')
>> drivers/irqchip/irq-gic-v3-its-platform-msi.c:68:2: error: unknown field 'chip' specified in initializer
     .chip = &its_pmsi_irq_chip,
     ^
   drivers/irqchip/irq-gic-v3-its-platform-msi.c:68:10: warning: excess elements in struct initializer
     .chip = &its_pmsi_irq_chip,
             ^
   drivers/irqchip/irq-gic-v3-its-platform-msi.c:68:10: note: (near initialization for 'its_pmsi_domain_info')
   drivers/irqchip/irq-gic-v3-its-platform-msi.c: In function 'its_pmsi_init':
>> drivers/irqchip/irq-gic-v3-its-platform-msi.c:87:19: error: implicit declaration of function 'msi_get_domain_info' [-Werror=implicit-function-declaration]
      if (!parent || !msi_get_domain_info(parent)) {
                      ^
>> drivers/irqchip/irq-gic-v3-its-platform-msi.c:93:8: error: implicit declaration of function 'platform_msi_create_irq_domain' [-Werror=implicit-function-declaration]
      if (!platform_msi_create_irq_domain(of_node_to_fwnode(np),
           ^
   cc1: some warnings being treated as errors

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 6027 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160604/a75b8a54/attachment-0001.obj>
