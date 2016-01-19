From: lkp@intel.com (kbuild test robot)
Date: Wed, 20 Jan 2016 02:04:02 +0800
Subject: [PATCH V3 08/10] irqchip, gicv3, its: Probe ITS in the ACPI way.
In-Reply-To: <1453209083-3358-9-git-send-email-tn@semihalf.com>
Message-ID: <201601200217.VECZlkZ7%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

[auto build test ERROR on v4.4-rc8]
[cannot apply to tip/irq/core next-20160119]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Tomasz-Nowicki/Introduce-ACPI-world-to-GICv3-ITS-irqchip/20160119-211652
config: arm64-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   drivers/irqchip/irq-gic-v3-its.c: In function 'its_irq_gic_domain_alloc':
>> drivers/irqchip/irq-gic-v3-its.c:1278:2: error: implicit declaration of function 'is_fwnode_irqchip' [-Werror=implicit-function-declaration]
     } else if (is_fwnode_irqchip(domain->parent->fwnode)) {
     ^
   cc1: some warnings being treated as errors

vim +/is_fwnode_irqchip +1278 drivers/irqchip/irq-gic-v3-its.c

  1272		if (irq_domain_get_of_node(domain->parent)) {
  1273			fwspec.fwnode = domain->parent->fwnode;
  1274			fwspec.param_count = 3;
  1275			fwspec.param[0] = GIC_IRQ_TYPE_LPI;
  1276			fwspec.param[1] = hwirq;
  1277			fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
> 1278		} else if (is_fwnode_irqchip(domain->parent->fwnode)) {
  1279			fwspec.fwnode = domain->parent->fwnode;
  1280			fwspec.param_count = 2;
  1281			fwspec.param[0] = hwirq;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 46675 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160120/3b84bc2b/attachment-0001.obj>
