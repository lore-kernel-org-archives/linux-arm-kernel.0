From: lkp@intel.com (kbuild test robot)
Date: Sun, 14 Feb 2016 14:09:11 +0800
Subject: [PATCH 3/5] irqchip: add platform device driver for mbigen device
In-Reply-To: <1455416191-23616-4-git-send-email-majun258@huawei.com>
Message-ID: <201602141423.fn5CCDUC%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ma,

[auto build test ERROR on tip/irq/core]
[also build test ERROR on v4.5-rc3 next-20160212]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/MaJun/irqchip-Add-support-for-Hisilicon-mbigen-v1-chip/20160214-101957
config: arm64-defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the linux-review/MaJun/irqchip-Add-support-for-Hisilicon-mbigen-v1-chip/20160214-101957 HEAD 9acb433456cd9671c97c0eeb1ccca8cc3b986081 builds fine.
      It only hurts bisectibility.

All error/warnings (new ones prefixed by >>):

   drivers/irqchip/irq-mbigen-v1.c: In function 'mbigen_device_probe':
>> drivers/irqchip/irq-mbigen-v1.c:47:2: error: implicit declaration of function 'devm_ioremap' [-Werror=implicit-function-declaration]
     mgn_chip->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
     ^
>> drivers/irqchip/irq-mbigen-v1.c:47:17: warning: assignment makes pointer from integer without a cast
     mgn_chip->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
                    ^
   cc1: some warnings being treated as errors

vim +/devm_ioremap +47 drivers/irqchip/irq-mbigen-v1.c

    41		if (!mgn_chip)
    42			return -ENOMEM;
    43	
    44		mgn_chip->pdev = pdev;
    45	
    46		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  > 47		mgn_chip->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
    48		if (IS_ERR(mgn_chip->base))
    49			return PTR_ERR(mgn_chip->base);
    50	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 21180 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160214/d5d583fd/attachment-0001.obj>
