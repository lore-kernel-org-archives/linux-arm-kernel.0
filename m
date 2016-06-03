From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 4 Jun 2016 03:48:57 +0800
Subject: [arm-soc:to-build 2/141] include/linux/msi.h:183:21: fatal error:
 asm/msi.h: No such file or directory
Message-ID: <201606040355.CeGpLjsw%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git to-build
head:   48e65edd714769af2c23ed7e1017a948cb6595d3
commit: c46fdaaeee93303072445308258de071140e1ce5 [2/141] PCI: designware: select PCI_MSI_IRQ_DOMAIN
config: frv-allmodconfig (attached as .config)
compiler: frv-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout c46fdaaeee93303072445308258de071140e1ce5
        # save the attached .config to linux build tree
        make.cross ARCH=frv 

All errors (new ones prefixed by >>):

   In file included from kernel/irq/chip.c:14:0:
>> include/linux/msi.h:183:21: fatal error: asm/msi.h: No such file or directory
    #include <asm/msi.h>
                        ^
   compilation terminated.

vim +183 include/linux/msi.h

c2791b806 Yijing Wang      2014-11-11  167  struct msi_controller {
0cbdcfcf4 Thierry Reding   2013-08-09  168  	struct module *owner;
0cbdcfcf4 Thierry Reding   2013-08-09  169  	struct device *dev;
0d5a6db3a Thomas Petazzoni 2013-08-09  170  	struct device_node *of_node;
0d5a6db3a Thomas Petazzoni 2013-08-09  171  	struct list_head list;
0cbdcfcf4 Thierry Reding   2013-08-09  172  
c2791b806 Yijing Wang      2014-11-11  173  	int (*setup_irq)(struct msi_controller *chip, struct pci_dev *dev,
0cbdcfcf4 Thierry Reding   2013-08-09  174  			 struct msi_desc *desc);
339e5b44e Lucas Stach      2015-09-18  175  	int (*setup_irqs)(struct msi_controller *chip, struct pci_dev *dev,
339e5b44e Lucas Stach      2015-09-18  176  			  int nvec, int type);
c2791b806 Yijing Wang      2014-11-11  177  	void (*teardown_irq)(struct msi_controller *chip, unsigned int irq);
0cbdcfcf4 Thierry Reding   2013-08-09  178  };
0cbdcfcf4 Thierry Reding   2013-08-09  179  
f3cf8bb0d Jiang Liu        2014-11-12  180  #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
d9109698b Jiang Liu        2014-11-15  181  
aeeb59657 Jiang Liu        2014-11-15  182  #include <linux/irqhandler.h>
d9109698b Jiang Liu        2014-11-15 @183  #include <asm/msi.h>
d9109698b Jiang Liu        2014-11-15  184  
f3cf8bb0d Jiang Liu        2014-11-12  185  struct irq_domain;
552c494a7 Marc Zyngier     2015-11-23  186  struct irq_domain_ops;
f3cf8bb0d Jiang Liu        2014-11-12  187  struct irq_chip;
f3cf8bb0d Jiang Liu        2014-11-12  188  struct device_node;
be5436c83 Marc Zyngier     2015-10-13  189  struct fwnode_handle;
f3cf8bb0d Jiang Liu        2014-11-12  190  struct msi_domain_info;
f3cf8bb0d Jiang Liu        2014-11-12  191  

:::::: The code at line 183 was first introduced by commit
:::::: d9109698be6e7439e6082aa00d79d4556114739b genirq: Introduce msi_domain_alloc/free_irqs()

:::::: TO: Jiang Liu <jiang.liu@linux.intel.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 44455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160604/e116c871/attachment-0001.obj>
