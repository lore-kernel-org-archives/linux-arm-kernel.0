From: lkp@intel.com (kbuild test robot)
Date: Sat, 24 Oct 2015 16:41:52 +0800
Subject: [PATCH v3] VFIO: platform: reset: AMD xgbe reset module
In-Reply-To: <1445615913-31825-1-git-send-email-eric.auger@linaro.org>
Message-ID: <201510241614.F4vZ38k0%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

[auto build test ERROR on asm-generic/master -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Eric-Auger/VFIO-platform-reset-AMD-xgbe-reset-module/20151024-000245
config: arm-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:122:27: error: expected declaration specifiers or '...' before string constant
    module_vfio_reset_handler("amd,xgbe-seattle-v1a", vfio_platform_amdxgbe_reset);
                              ^
>> drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:122:51: error: expected declaration specifiers or '...' before 'vfio_platform_amdxgbe_reset'
    module_vfio_reset_handler("amd,xgbe-seattle-v1a", vfio_platform_amdxgbe_reset);
                                                      ^
--
>> /kbuild/src/defs/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:122:27: error: expected declaration specifiers or '...' before string constant
    module_vfio_reset_handler("amd,xgbe-seattle-v1a", vfio_platform_amdxgbe_reset);
                              ^
>> /kbuild/src/defs/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c:122:51: error: expected declaration specifiers or '...' before 'vfio_platform_amdxgbe_reset'
    module_vfio_reset_handler("amd,xgbe-seattle-v1a", vfio_platform_amdxgbe_reset);
                                                      ^

vim +122 drivers/vfio/platform/reset/vfio_platform_amdxgbe.c

   116		if (!count)
   117			pr_warn("%s MAC SW reset failed\n", __func__);
   118	
   119		return 0;
   120	}
   121	
 > 122	module_vfio_reset_handler("amd,xgbe-seattle-v1a", vfio_platform_amdxgbe_reset);
   123	
   124	MODULE_VERSION("0.1");
   125	MODULE_LICENSE("GPL v2");

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 53086 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151024/0ef36dd1/attachment-0001.obj>
