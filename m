From: Okaya@codeaurora.org (Okaya at codeaurora.org)
Date: Mon, 21 Dec 2015 22:05:24 -0000
Subject: [PATCH V10 7/7] dma: qcom_hidma: add support for object hierarchy
In-Reply-To: <201512191503.k4p1BXza%fengguang.wu@intel.com>
References: <201512191503.k4p1BXza%fengguang.wu@intel.com>
Message-ID: <2c12e9aadc42c51a37e6dd771652aafb.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi Sinan,
>
> [auto build test ERROR on v4.4-rc5]
> [also build test ERROR on next-20151218]
>
> url:
> https://github.com/0day-ci/linux/commits/Sinan-Kaya/dma-add-Qualcomm-Technologies-HIDMA-driver/20151218-010637
> config: sparc64-allmodconfig (attached as .config)
> reproduce:
>         wget
> https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc64
>
> All errors (new ones prefixed by >>):
>
>>> ERROR: "of_irq_parse_one" [drivers/dma/qcom/hdma_mgmt.ko] undefined!
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology
> Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation
>

I am confused about this. The function call is made only if OF is defined.
The function that is being called is defined with extern symbol and
resides in drivers/of/irq.c. how does the sparc arch define OF yet exclude
drivers/of/irq.c
