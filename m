From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 8 Oct 2015 15:20:05 +0800
Subject: [arm-platforms:irq/irq-domain-fwnode-v1 2/16]
 arch/arm/mach-exynos/suspend.c:220:33: error: 'struct irq_domain' has no
 member named 'of_node'
Message-ID: <201510081502.1LnW7Bx3%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/irq-domain-fwnode-v1
head:   a4ae7ebbb7c498e690ff71e936ce45806f5177d8
commit: f874e7d148bd22c2d111b97d40a1d2f15e287de7 [2/16] irqdomain: Convert irqdomain->of_node to fwnode
config: arm-exynos_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout f874e7d148bd22c2d111b97d40a1d2f15e287de7
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the arm-platforms/irq/irq-domain-fwnode-v1 HEAD a4ae7ebbb7c498e690ff71e936ce45806f5177d8 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   arch/arm/mach-exynos/suspend.c: In function 'exynos_pmu_domain_alloc':
>> arch/arm/mach-exynos/suspend.c:220:33: error: 'struct irq_domain' has no member named 'of_node'
     parent_args.np = domain->parent->of_node;
                                    ^

vim +220 arch/arm/mach-exynos/suspend.c

8b283c02 Marc Zyngier 2015-03-11  214  
8b283c02 Marc Zyngier 2015-03-11  215  	for (i = 0; i < nr_irqs; i++)
8b283c02 Marc Zyngier 2015-03-11  216  		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
8b283c02 Marc Zyngier 2015-03-11  217  					      &exynos_pmu_chip, NULL);
8b283c02 Marc Zyngier 2015-03-11  218  
8b283c02 Marc Zyngier 2015-03-11  219  	parent_args = *args;
8b283c02 Marc Zyngier 2015-03-11 @220  	parent_args.np = domain->parent->of_node;
8b283c02 Marc Zyngier 2015-03-11  221  	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_args);
8b283c02 Marc Zyngier 2015-03-11  222  }
8b283c02 Marc Zyngier 2015-03-11  223  

:::::: The code at line 220 was first introduced by commit
:::::: 8b283c025443e4c3a3323c92777f422fa504caa5 ARM: exynos4/5: convert pmu wakeup to stacked domains

:::::: TO: Marc Zyngier <marc.zyngier@arm.com>
:::::: CC: Jason Cooper <jason@lakedaemon.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 21345 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151008/5f25c8c0/attachment-0001.obj>
