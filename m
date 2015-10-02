From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 2 Oct 2015 22:05:13 +0800
Subject: [arm-platforms:irq/msi-map-pci 11/13] include/linux/of_irq.h:80:1:
 error: expected identifier or '(' before '{' token
Message-ID: <201510022211.cUzT45bT%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/msi-map-pci
head:   1ab5975873b783abe6d2f748f54ca5bef44b183f
commit: 5af05cd5fe6352aa1838099ccdce2c597092524c [11/13] of/irq: Use the msi-map property to provide device-specific MSI domain
config: i386-randconfig-s1-201539 (attached as .config)
reproduce:
        git checkout 5af05cd5fe6352aa1838099ccdce2c597092524c
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/base/platform.c:16:0:
>> include/linux/of_irq.h:80:1: error: expected identifier or '(' before '{' token
    {
    ^
>> include/linux/of_irq.h:78:34: warning: 'of_msi_map_get_device_domain' declared 'static' but never defined [-Wunused-function]
    static inline struct irq_domain *of_msi_map_get_device_domain(struct device *dev,
                                     ^

vim +80 include/linux/of_irq.h

    72	static inline struct irq_domain *of_msi_get_domain(struct device *dev,
    73							   struct device_node *np,
    74							   enum irq_domain_bus_token token)
    75	{
    76		return NULL;
    77	}
  > 78	static inline struct irq_domain *of_msi_map_get_device_domain(struct device *dev,
    79								      u32 rid);
  > 80	{
    81		return NULL;
    82	}
    83	#endif

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 20836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151002/157a0825/attachment-0001.obj>
