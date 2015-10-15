From: lkp@intel.com (kbuild test robot)
Date: Fri, 16 Oct 2015 04:37:05 +0800
Subject: [RFC PATCH 3/4] drm/rockchip: Convert the probe function to the
 generic drm_of_component_probe()
In-Reply-To: <1444925470-9963-4-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <201510160457.f1rnaH9x%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liviu,

[auto build test ERROR on drm/drm-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Liviu-Dudau/drm-Introduce-generic-probe-function-for-component-based-masters/20151016-001417
config: arm-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   drivers/gpu/drm/rockchip/rockchip_drm_drv.c: In function 'rockchip_drm_dma_attach_device':
>> drivers/gpu/drm/rockchip/rockchip_drm_drv.c:48:6: warning: unused variable 'ret' [-Wunused-variable]
     int ret;
         ^
   drivers/gpu/drm/rockchip/rockchip_drm_drv.c: In function 'rockchip_drm_platform_probe':
>> drivers/gpu/drm/rockchip/rockchip_drm_drv.c:457:2: error: implicit declaration of function 'drm_of_component_probe' [-Werror=implicit-function-declaration]
     int ret = drm_of_component_probe(&pdev->dev, compare_of,
     ^
   cc1: some warnings being treated as errors

vim +/drm_of_component_probe +457 drivers/gpu/drm/rockchip/rockchip_drm_drv.c

   451		.bind = rockchip_drm_bind,
   452		.unbind = rockchip_drm_unbind,
   453	};
   454	
   455	static int rockchip_drm_platform_probe(struct platform_device *pdev)
   456	{
 > 457		int ret = drm_of_component_probe(&pdev->dev, compare_of,
   458						 &rockchip_drm_ops);
   459	
   460		/* keep compatibility with old code that was returning -ENODEV */

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 53719 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151016/21a5ad5b/attachment-0001.obj>
