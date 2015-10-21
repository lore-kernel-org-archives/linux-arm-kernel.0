From: majun258@huawei.com (majun (F))
Date: Wed, 21 Oct 2015 13:57:02 +0800
Subject: [PATCH RESEND v6 3/4] irqchip:create irq domain for each mbigen
 device
In-Reply-To: <201510210208.Hkd8XMxI%fengguang.wu@intel.com>
References: <201510210208.Hkd8XMxI%fengguang.wu@intel.com>
Message-ID: <5627292E.6050708@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2015/10/21 2:43, kbuild test robot ??:
> Hi Ma,
> 
> [auto build test ERROR on tip/irq/core -- if it's inappropriate base, please suggest rules for selecting the more suitable base]
> 
> url:    https://github.com/0day-ci/linux/commits/MaJun/irqchip-support-mbigen-interrupt-controller/20151020-202450
> config: arm64-allyesconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    drivers/irqchip/irq-mbigen.c:84:14: error: 'mbigen_eoi_irq' undeclared here (not in a function)
>      .irq_eoi =  mbigen_eoi_irq,
>                  ^
>    drivers/irqchip/irq-mbigen.c:85:19: error: 'mbigen_set_type' undeclared here (not in a function)
>      .irq_set_type =  mbigen_set_type,
>                       ^

I'll fix this error in v7

>    drivers/irqchip/irq-mbigen.c: In function 'mbigen_irq_domain_alloc':
>>> drivers/irqchip/irq-mbigen.c:150:2: error: implicit declaration of function 'platform_msi_domain_alloc' [-Werror=implicit-function-declaration]
>      err = platform_msi_domain_alloc(domain, virq, nr_irqs);
>      ^
>>> drivers/irqchip/irq-mbigen.c:159:2: error: implicit declaration of function 'platform_msi_get_host_data' [-Werror=implicit-function-declaration]
>      mgn_chip = platform_msi_get_host_data(domain);
>      ^
>>> drivers/irqchip/irq-mbigen.c:159:11: warning: assignment makes pointer from integer without a cast
>      mgn_chip = platform_msi_get_host_data(domain);
>               ^
>    drivers/irqchip/irq-mbigen.c: In function 'mbigen_device_probe':
>>> drivers/irqchip/irq-mbigen.c:202:2: error: implicit declaration of function 'platform_msi_create_device_domain' [-Werror=implicit-function-declaration]
>      domain = platform_msi_create_device_domain(&pdev->dev, num_msis,
>      ^
>    drivers/irqchip/irq-mbigen.c:202:9: warning: assignment makes pointer from integer without a cast
>      domain = platform_msi_create_device_domain(&pdev->dev, num_msis,

My patch based on Marc's patch
https://lkml.org/lkml/2015/10/15/545

So, please apply this patch first.

Thanks!
Ma Jun
