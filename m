From: lkp@intel.com (kbuild test robot)
Date: Wed, 16 Mar 2016 19:32:59 +0800
Subject: [PATCH] PCI: designware: move remaining rc setup code to
 dw_pcie_setup_rc()
In-Reply-To: <1458124582-2511-1-git-send-email-jszhang@marvell.com>
Message-ID: <201603161909.UvSGV4Nv%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,

[auto build test WARNING on pci/next]
[also build test WARNING on next-20160316]
[cannot apply to v4.5]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Jisheng-Zhang/PCI-designware-move-remaining-rc-setup-code-to-dw_pcie_setup_rc/20160316-184353
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: i386-randconfig-i1-201611 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers/pci/host/pcie-designware.c: In function 'dw_pcie_host_init':
>> drivers/pci/host/pcie-designware.c:437:6: warning: unused variable 'val' [-Wunused-variable]
     u32 val;
         ^

vim +/val +437 drivers/pci/host/pcie-designware.c

f342d940 Jingoo Han             2013-09-06  421  	irq_set_chip_and_handler(irq, &dw_msi_irq_chip, handle_simple_irq);
f342d940 Jingoo Han             2013-09-06  422  	irq_set_chip_data(irq, domain->host_data);
f342d940 Jingoo Han             2013-09-06  423  
f342d940 Jingoo Han             2013-09-06  424  	return 0;
f342d940 Jingoo Han             2013-09-06  425  }
f342d940 Jingoo Han             2013-09-06  426  
f342d940 Jingoo Han             2013-09-06  427  static const struct irq_domain_ops msi_domain_ops = {
f342d940 Jingoo Han             2013-09-06  428  	.map = dw_pcie_msi_map,
f342d940 Jingoo Han             2013-09-06  429  };
f342d940 Jingoo Han             2013-09-06  430  
a43f32d6 Matwey V. Kornilov     2015-02-19  431  int dw_pcie_host_init(struct pcie_port *pp)
4b1ced84 Jingoo Han             2013-07-31  432  {
4b1ced84 Jingoo Han             2013-07-31  433  	struct device_node *np = pp->dev->of_node;
4dd964df Kishon Vijay Abraham I 2014-07-17  434  	struct platform_device *pdev = to_platform_device(pp->dev);
cbce7900 Zhou Wang              2015-10-29  435  	struct pci_bus *bus, *child;
4dd964df Kishon Vijay Abraham I 2014-07-17  436  	struct resource *cfg_res;
9cdce1cd Zhou Wang              2015-10-29 @437  	u32 val;
9cdce1cd Zhou Wang              2015-10-29  438  	int i, ret;
0021d22b Zhou Wang              2015-10-29  439  	LIST_HEAD(res);
0021d22b Zhou Wang              2015-10-29  440  	struct resource_entry *win;
f342d940 Jingoo Han             2013-09-06  441  
4dd964df Kishon Vijay Abraham I 2014-07-17  442  	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
4dd964df Kishon Vijay Abraham I 2014-07-17  443  	if (cfg_res) {
adf70fc0 Pratyush Anand         2014-09-05  444  		pp->cfg0_size = resource_size(cfg_res)/2;
adf70fc0 Pratyush Anand         2014-09-05  445  		pp->cfg1_size = resource_size(cfg_res)/2;

:::::: The code at line 437 was first introduced by commit
:::::: 9cdce1cdc0c40e6c2e85ed9ca13c32adaa5fe0c5 Revert "PCI: designware: Program ATU with untranslated address"

:::::: TO: Zhou Wang <wangzhou1@hisilicon.com>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 27787 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160316/52e17eac/attachment-0001.obj>
