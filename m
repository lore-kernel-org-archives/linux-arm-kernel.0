From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 27 Jan 2016 15:50:38 +0800
Subject: [PATCH 01/15] arm: use of_platform_default_populate() to populate
 default bus
In-Reply-To: <201601271506.AiWVACC3%fengguang.wu@intel.com>
References: <201601271506.AiWVACC3%fengguang.wu@intel.com>
Message-ID: <56A876CE.2030707@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/1/27 15:08, kbuild test robot wrote:
> Hi Kefeng,
> 
> [auto build test ERROR on v4.5-rc1]
> [cannot apply to arm-soc/for-next next-20160127]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Kefeng-Wang/use-of_platform_default_populate-to-populate-default-bus/20160127-123512
> config: arm-at91_dt_defconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/arm/mach-at91/at91rm9200.c: In function 'at91rm9200_dt_device_init':
>>> arch/arm/mach-at91/at91rm9200.c:34:2: error: implicit declaration of function 'of_platform__default_populate' [-Werror=implicit-function-declaration]
>      of_platform__default_populate(NULL, NULL, soc_dev);

sorry for the typo, fix in v2.

>      ^
>    cc1: some warnings being treated as errors
> 
> vim +/of_platform__default_populate +34 arch/arm/mach-at91/at91rm9200.c
> 
>     28		struct device *soc_dev = NULL;
>     29	
>     30		soc = at91_soc_init(rm9200_socs);
>     31		if (soc != NULL)
>     32			soc_dev = soc_device_to_device(soc);
>     33	
>   > 34		of_platform__default_populate(NULL, NULL, soc_dev);
>     35	
>     36		arm_pm_idle = at91rm9200_idle;
>     37		at91rm9200_pm_init();
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
