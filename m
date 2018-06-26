From: lkp@intel.com (kbuild test robot)
Date: Tue, 26 Jun 2018 18:58:53 +0800
Subject: [PATCH 2/2] drm/rockchip: vop: add px30 vop support
In-Reply-To: <1530003215-46593-3-git-send-email-hjc@rock-chips.com>
References: <1530003215-46593-3-git-send-email-hjc@rock-chips.com>
Message-ID: <201806261816.oFTCzr7b%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sandy,

I love your patch! Yet something to improve:

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on v4.18-rc2 next-20180626]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sandy-Huang/add-support-rockchip-px30-VOP/20180626-171044
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/rockchip/rockchip_vop_reg.c:668:2: error: expected '}' before '{' token
     { .compatible = "rockchip,px30-vop-big",
     ^

vim +668 drivers/gpu/drm/rockchip/rockchip_vop_reg.c

   660	
   661	static const struct of_device_id vop_driver_dt_match[] = {
   662		{ .compatible = "rockchip,rk3036-vop",
   663		  .data = &rk3036_vop },
   664		{ .compatible = "rockchip,rk3126-vop",
   665		  .data = &rk3126_vop },
   666		{ .compatible = "rockchip,px30-vop-lit",
   667		  .data = &rk3126_vop }
 > 668		{ .compatible = "rockchip,px30-vop-big",
   669		  .data = &rk3126_vop }
   670		{ .compatible = "rockchip,rk3288-vop",
   671		  .data = &rk3288_vop },
   672		{ .compatible = "rockchip,rk3368-vop",
   673		  .data = &rk3368_vop },
   674		{ .compatible = "rockchip,rk3366-vop",
   675		  .data = &rk3366_vop },
   676		{ .compatible = "rockchip,rk3399-vop-big",
   677		  .data = &rk3399_vop_big },
   678		{ .compatible = "rockchip,rk3399-vop-lit",
   679		  .data = &rk3399_vop_lit },
   680		{ .compatible = "rockchip,rk3228-vop",
   681		  .data = &rk3228_vop },
   682		{ .compatible = "rockchip,rk3328-vop",
   683		  .data = &rk3328_vop },
   684		{},
   685	};
   686	MODULE_DEVICE_TABLE(of, vop_driver_dt_match);
   687	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38863 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180626/f19b95d4/attachment-0001.gz>
