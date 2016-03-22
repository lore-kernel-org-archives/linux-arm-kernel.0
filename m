From: lkp@intel.com (kbuild test robot)
Date: Wed, 23 Mar 2016 06:23:50 +0800
Subject: [PATCH next 1/2] PCI: keystone: add pci error irq handler
In-Reply-To: <1458676378-24377-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <201603230621.h4pXMyFx%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Murali,

[auto build test ERROR on next-20160322]

url:    https://github.com/0day-ci/linux/commits/Murali-Karicheri/PCI-keystone-add-pci-error-irq-handler/20160323-035516
config: arm-multi_v7_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/pci/host/pci-keystone.c: In function 'ks_pcie_probe':
>> drivers/pci/host/pci-keystone.c:410:16: error: 'node' undeclared (first use in this function)
     ks_pcie->np = node;
                   ^
   drivers/pci/host/pci-keystone.c:410:16: note: each undeclared identifier is reported only once for each function it appears in

vim +/node +410 drivers/pci/host/pci-keystone.c

   404			return PTR_ERR(reg_p);
   405		ks_pcie->device_id = readl(reg_p) >> 16;
   406		devm_iounmap(dev, reg_p);
   407		devm_release_mem_region(dev, res->start, resource_size(res));
   408	
   409		pp->dev = dev;
 > 410		ks_pcie->np = node;
   411		platform_set_drvdata(pdev, ks_pcie);
   412		ks_pcie->clk = devm_clk_get(dev, "pcie");
   413		if (IS_ERR(ks_pcie->clk)) {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 37256 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160323/6eabdc96/attachment-0001.obj>
