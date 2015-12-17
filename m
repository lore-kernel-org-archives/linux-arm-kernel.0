From: lkp@intel.com (kbuild test robot)
Date: Thu, 17 Dec 2015 21:44:56 +0800
Subject: [PATCH V2 02/10] irqchip / GICv3: Add ACPI support for GICv3+
 initialization
In-Reply-To: <1450353133-15992-3-git-send-email-tn@semihalf.com>
Message-ID: <201512172109.NUSKIrEK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

[auto build test ERROR on v4.4-rc4]
[also build test ERROR on next-20151217]
[cannot apply to tip/irq/core v4.4-rc5]

url:    https://github.com/0day-ci/linux/commits/Tomasz-Nowicki/Introduce-ACPI-world-to-GICv3-ITS-irqchip/20151217-195910
config: arm-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/irqchip/irq-gic-v3.c: In function 'gic_irq_domain_translate':
>> drivers/irqchip/irq-gic-v3.c:768:2: error: implicit declaration of function 'is_fwnode_irqchip' [-Werror=implicit-function-declaration]
     if (is_fwnode_irqchip(fwspec->fwnode)) {
     ^
   cc1: some warnings being treated as errors

vim +/is_fwnode_irqchip +768 drivers/irqchip/irq-gic-v3.c

   762			}
   763	
   764			*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
   765			return 0;
   766		}
   767	
 > 768		if (is_fwnode_irqchip(fwspec->fwnode)) {
   769			if(fwspec->param_count != 2)
   770				return -EINVAL;
   771	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 53975 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151217/e540faaf/attachment-0001.obj>
