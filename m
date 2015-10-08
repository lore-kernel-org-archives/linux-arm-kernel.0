From: lkp@intel.com (kbuild test robot)
Date: Thu, 8 Oct 2015 22:38:24 +0800
Subject: [PATCH v8 4/6] pci: altera: Add Altera PCIe MSI driver
In-Reply-To: <1444297394-3122-5-git-send-email-lftan@altera.com>
Message-ID: <201510082207.69oD4kaL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ley,

[auto build test ERROR on v4.3-rc4 -- if it's inappropriate base, please ignore]

config: sparc-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/of_pci.h:5:0,
                    from drivers/pci//host/pcie-altera.c:22:
>> include/linux/msi.h:199:10: error: unknown type name 'msi_alloc_info_t'
             msi_alloc_info_t *arg);
             ^
   include/linux/msi.h:203:9: error: unknown type name 'msi_alloc_info_t'
            msi_alloc_info_t *arg);
            ^
   include/linux/msi.h:212:12: error: unknown type name 'msi_alloc_info_t'
               msi_alloc_info_t *arg);
               ^
   include/linux/msi.h:213:22: error: unknown type name 'msi_alloc_info_t'
     void  (*msi_finish)(msi_alloc_info_t *arg, int retval);
                         ^
   include/linux/msi.h:214:20: error: unknown type name 'msi_alloc_info_t'
     void  (*set_desc)(msi_alloc_info_t *arg,
                       ^
   drivers/pci//host/pcie-altera.c: In function 'tlp_cfg_dword_read':
   drivers/pci//host/pcie-altera.c:243:12: warning: large integer implicitly truncated to unsigned type [-Woverflow]
      *value = ~0UL; /* return 0xFFFFFFFF if error */
               ^
   drivers/pci//host/pcie-altera.c: In function 'altera_pcie_cfg_read':
   drivers/pci//host/pcie-altera.c:291:12: warning: large integer implicitly truncated to unsigned type [-Woverflow]
      *value = ~0UL;
               ^
   drivers/pci//host/pcie-altera.c: In function 'altera_pcie_parse_request_of_pci_ranges':
   drivers/pci//host/pcie-altera.c:410:2: error: implicit declaration of function 'of_pci_get_host_bridge_resources' [-Werror=implicit-function-declaration]
     err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pcie->resources,
     ^
   cc1: some warnings being treated as errors
--
   In file included from drivers/pci//host/pcie-altera-msi.c:19:0:
>> include/linux/msi.h:199:10: error: unknown type name 'msi_alloc_info_t'
             msi_alloc_info_t *arg);
             ^
   include/linux/msi.h:203:9: error: unknown type name 'msi_alloc_info_t'
            msi_alloc_info_t *arg);
            ^
   include/linux/msi.h:212:12: error: unknown type name 'msi_alloc_info_t'
               msi_alloc_info_t *arg);
               ^
   include/linux/msi.h:213:22: error: unknown type name 'msi_alloc_info_t'
     void  (*msi_finish)(msi_alloc_info_t *arg, int retval);
                         ^
   include/linux/msi.h:214:20: error: unknown type name 'msi_alloc_info_t'
     void  (*set_desc)(msi_alloc_info_t *arg,
                       ^
--
   In file included from drivers/base/platform-msi.c:24:0:
>> include/linux/msi.h:199:10: error: unknown type name 'msi_alloc_info_t'
             msi_alloc_info_t *arg);
             ^
   include/linux/msi.h:203:9: error: unknown type name 'msi_alloc_info_t'
            msi_alloc_info_t *arg);
            ^
   include/linux/msi.h:212:12: error: unknown type name 'msi_alloc_info_t'
               msi_alloc_info_t *arg);
               ^
   include/linux/msi.h:213:22: error: unknown type name 'msi_alloc_info_t'
     void  (*msi_finish)(msi_alloc_info_t *arg, int retval);
                         ^
   include/linux/msi.h:214:20: error: unknown type name 'msi_alloc_info_t'
     void  (*set_desc)(msi_alloc_info_t *arg,
                       ^
   drivers/base/platform-msi.c: In function 'platform_msi_update_dom_ops':
>> drivers/base/platform-msi.c:80:9: error: 'struct msi_domain_ops' has no member named 'msi_init'
     if (ops->msi_init == NULL)
            ^
   drivers/base/platform-msi.c:81:6: error: 'struct msi_domain_ops' has no member named 'msi_init'
      ops->msi_init = platform_msi_init;
         ^
>> drivers/base/platform-msi.c:82:9: error: 'struct msi_domain_ops' has no member named 'set_desc'
     if (ops->set_desc == NULL)
            ^
   drivers/base/platform-msi.c:83:6: error: 'struct msi_domain_ops' has no member named 'set_desc'
      ops->set_desc = platform_msi_set_desc;
         ^
--
   In file included from drivers/pci/msi.c:17:0:
>> include/linux/msi.h:199:10: error: unknown type name 'msi_alloc_info_t'
             msi_alloc_info_t *arg);
             ^
   include/linux/msi.h:203:9: error: unknown type name 'msi_alloc_info_t'
            msi_alloc_info_t *arg);
            ^
   include/linux/msi.h:212:12: error: unknown type name 'msi_alloc_info_t'
               msi_alloc_info_t *arg);
               ^
   include/linux/msi.h:213:22: error: unknown type name 'msi_alloc_info_t'
     void  (*msi_finish)(msi_alloc_info_t *arg, int retval);
                         ^
   include/linux/msi.h:214:20: error: unknown type name 'msi_alloc_info_t'
     void  (*set_desc)(msi_alloc_info_t *arg,
                       ^
>> drivers/pci/msi.c:1218:2: error: unknown field 'set_desc' specified in initializer
     .set_desc = pci_msi_domain_set_desc,
     ^
   drivers/pci/msi.c: In function 'pci_msi_domain_update_dom_ops':
>> drivers/pci/msi.c:1230:10: error: 'struct msi_domain_ops' has no member named 'set_desc'
      if (ops->set_desc == NULL)
             ^
   drivers/pci/msi.c:1231:7: error: 'struct msi_domain_ops' has no member named 'set_desc'
       ops->set_desc = pci_msi_domain_set_desc;
          ^
--
   In file included from kernel/irq/msi.c:16:0:
>> include/linux/msi.h:199:10: error: unknown type name 'msi_alloc_info_t'
             msi_alloc_info_t *arg);
             ^
   include/linux/msi.h:203:9: error: unknown type name 'msi_alloc_info_t'
            msi_alloc_info_t *arg);
            ^
   include/linux/msi.h:212:12: error: unknown type name 'msi_alloc_info_t'
               msi_alloc_info_t *arg);
               ^
   include/linux/msi.h:213:22: error: unknown type name 'msi_alloc_info_t'
     void  (*msi_finish)(msi_alloc_info_t *arg, int retval);
                         ^
   include/linux/msi.h:214:20: error: unknown type name 'msi_alloc_info_t'
     void  (*set_desc)(msi_alloc_info_t *arg,
                       ^
   kernel/irq/msi.c: In function 'msi_domain_alloc':
>> kernel/irq/msi.c:106:29: error: 'struct msi_domain_ops' has no member named 'get_hwirq'
     irq_hw_number_t hwirq = ops->get_hwirq(info, arg);
                                ^
>> kernel/irq/msi.c:117:12: error: 'struct msi_domain_ops' has no member named 'msi_init'
      ret = ops->msi_init(domain, info, virq + i, hwirq + i, arg);
               ^
   kernel/irq/msi.c: At top level:
>> kernel/irq/msi.c:179:11: error: unknown type name 'msi_alloc_info_t'
              msi_alloc_info_t *arg)
              ^
>> kernel/irq/msi.c:199:2: error: unknown field 'get_hwirq' specified in initializer
     .get_hwirq = msi_domain_ops_get_hwirq,
     ^
>> kernel/irq/msi.c:200:2: error: unknown field 'msi_init' specified in initializer
     .msi_init = msi_domain_ops_init,
     ^
>> kernel/irq/msi.c:200:14: error: 'msi_domain_ops_init' undeclared here (not in a function)
     .msi_init = msi_domain_ops_init,
                 ^
>> kernel/irq/msi.c:202:2: error: unknown field 'msi_prepare' specified in initializer
     .msi_prepare = msi_domain_ops_prepare,
     ^
>> kernel/irq/msi.c:203:2: error: unknown field 'set_desc' specified in initializer
     .set_desc = msi_domain_ops_set_desc,
     ^
>> kernel/irq/msi.c:203:2: warning: excess elements in struct initializer
>> kernel/irq/msi.c:203:2: warning: (near initialization for 'msi_domain_ops_default')
   kernel/irq/msi.c: In function 'msi_domain_update_dom_ops':
   kernel/irq/msi.c:215:9: error: 'struct msi_domain_ops' has no member named 'get_hwirq'
     if (ops->get_hwirq == NULL)
            ^
   kernel/irq/msi.c:216:6: error: 'struct msi_domain_ops' has no member named 'get_hwirq'
      ops->get_hwirq = msi_domain_ops_default.get_hwirq;
         ^
   kernel/irq/msi.c:216:42: error: 'struct msi_domain_ops' has no member named 'get_hwirq'
      ops->get_hwirq = msi_domain_ops_default.get_hwirq;
                                             ^
   kernel/irq/msi.c:217:9: error: 'struct msi_domain_ops' has no member named 'msi_init'
     if (ops->msi_init == NULL)
            ^
   kernel/irq/msi.c:218:6: error: 'struct msi_domain_ops' has no member named 'msi_init'
      ops->msi_init = msi_domain_ops_default.msi_init;
         ^
   kernel/irq/msi.c:218:41: error: 'struct msi_domain_ops' has no member named 'msi_init'
      ops->msi_init = msi_domain_ops_default.msi_init;
                                            ^
>> kernel/irq/msi.c:221:9: error: 'struct msi_domain_ops' has no member named 'msi_prepare'
     if (ops->msi_prepare == NULL)
            ^
   kernel/irq/msi.c:222:6: error: 'struct msi_domain_ops' has no member named 'msi_prepare'
      ops->msi_prepare = msi_domain_ops_default.msi_prepare;
         ^
   kernel/irq/msi.c:222:44: error: 'struct msi_domain_ops' has no member named 'msi_prepare'
      ops->msi_prepare = msi_domain_ops_default.msi_prepare;
                                               ^
>> kernel/irq/msi.c:223:9: error: 'struct msi_domain_ops' has no member named 'set_desc'
     if (ops->set_desc == NULL)
            ^
   kernel/irq/msi.c:224:6: error: 'struct msi_domain_ops' has no member named 'set_desc'
      ops->set_desc = msi_domain_ops_default.set_desc;
         ^
   kernel/irq/msi.c:224:41: error: 'struct msi_domain_ops' has no member named 'set_desc'
      ops->set_desc = msi_domain_ops_default.set_desc;
                                            ^
   kernel/irq/msi.c: In function 'msi_domain_alloc_irqs':
   kernel/irq/msi.c:273:2: error: unknown type name 'msi_alloc_info_t'
     msi_alloc_info_t arg;
     ^
   kernel/irq/msi.c:279:12: error: 'struct msi_domain_ops' has no member named 'msi_prepare'
      ret = ops->msi_prepare(domain, dev, nvec, &arg);
               ^
   kernel/irq/msi.c:284:6: error: 'struct msi_domain_ops' has no member named 'set_desc'
      ops->set_desc(&arg, desc);
         ^
   kernel/irq/msi.c:286:19: error: 'struct msi_domain_ops' has no member named 'get_hwirq'
       virq = (int)ops->get_hwirq(info, &arg);
                      ^
>> kernel/irq/msi.c:296:11: error: 'struct msi_domain_ops' has no member named 'msi_finish'
       if (ops->msi_finish)
              ^
   kernel/irq/msi.c:297:8: error: 'struct msi_domain_ops' has no member named 'msi_finish'
        ops->msi_finish(&arg, ret);
           ^
   kernel/irq/msi.c:305:9: error: 'struct msi_domain_ops' has no member named 'msi_finish'
     if (ops->msi_finish)
            ^
   kernel/irq/msi.c:306:6: error: 'struct msi_domain_ops' has no member named 'msi_finish'
      ops->msi_finish(&arg, 0);
         ^
--
   In file included from include/linux/of_pci.h:5:0,
                    from drivers/pci/host/pcie-altera.c:22:
>> include/linux/msi.h:199:10: error: unknown type name 'msi_alloc_info_t'
             msi_alloc_info_t *arg);
             ^
   include/linux/msi.h:203:9: error: unknown type name 'msi_alloc_info_t'
            msi_alloc_info_t *arg);
            ^
   include/linux/msi.h:212:12: error: unknown type name 'msi_alloc_info_t'
               msi_alloc_info_t *arg);
               ^
   include/linux/msi.h:213:22: error: unknown type name 'msi_alloc_info_t'
     void  (*msi_finish)(msi_alloc_info_t *arg, int retval);
                         ^
   include/linux/msi.h:214:20: error: unknown type name 'msi_alloc_info_t'
     void  (*set_desc)(msi_alloc_info_t *arg,
                       ^
   drivers/pci/host/pcie-altera.c: In function 'tlp_cfg_dword_read':
   drivers/pci/host/pcie-altera.c:243:12: warning: large integer implicitly truncated to unsigned type [-Woverflow]
      *value = ~0UL; /* return 0xFFFFFFFF if error */
               ^
   drivers/pci/host/pcie-altera.c: In function 'altera_pcie_cfg_read':
   drivers/pci/host/pcie-altera.c:291:12: warning: large integer implicitly truncated to unsigned type [-Woverflow]
      *value = ~0UL;
               ^
   drivers/pci/host/pcie-altera.c: In function 'altera_pcie_parse_request_of_pci_ranges':
   drivers/pci/host/pcie-altera.c:410:2: error: implicit declaration of function 'of_pci_get_host_bridge_resources' [-Werror=implicit-function-declaration]
     err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pcie->resources,
     ^
   cc1: some warnings being treated as errors

vim +/msi_alloc_info_t +199 include/linux/msi.h

d9109698 Jiang Liu 2014-11-15  193   * @msi_check, @msi_prepare, @msi_finish, @set_desc and @handle_error
d9109698 Jiang Liu 2014-11-15  194   * are callbacks used by msi_irq_domain_alloc_irqs() and related
d9109698 Jiang Liu 2014-11-15  195   * interfaces which are based on msi_desc.
f3cf8bb0 Jiang Liu 2014-11-12  196   */
f3cf8bb0 Jiang Liu 2014-11-12  197  struct msi_domain_ops {
aeeb5965 Jiang Liu 2014-11-15  198  	irq_hw_number_t	(*get_hwirq)(struct msi_domain_info *info,
aeeb5965 Jiang Liu 2014-11-15 @199  				     msi_alloc_info_t *arg);
f3cf8bb0 Jiang Liu 2014-11-12  200  	int		(*msi_init)(struct irq_domain *domain,
f3cf8bb0 Jiang Liu 2014-11-12  201  				    struct msi_domain_info *info,
f3cf8bb0 Jiang Liu 2014-11-12  202  				    unsigned int virq, irq_hw_number_t hwirq,

:::::: The code at line 199 was first introduced by commit
:::::: aeeb59657c35da64068336c20068da237f41ab76 genirq: Provide default callbacks for msi_domain_ops

:::::: TO: Jiang Liu <jiang.liu@linux.intel.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 43438 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151008/1a2be20e/attachment-0001.obj>
