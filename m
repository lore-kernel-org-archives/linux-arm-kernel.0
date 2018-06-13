From: lkp@intel.com (kbuild test robot)
Date: Wed, 13 Jun 2018 15:07:34 +0800
Subject: [PATCH v2 05/27] drm/sun4i: Add TCON TOP driver
In-Reply-To: <20180612200036.21483-6-jernej.skrabec@siol.net>
References: <20180612200036.21483-6-jernej.skrabec@siol.net>
Message-ID: <201806131342.27geZR8n%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jernej,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on v4.17 next-20180612]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jernej-Skrabec/clk-sunxi-ng-r40-Add-minimal-rate-for-video-PLLs/20180613-041046
base:   git://people.freedesktop.org/~airlied/linux.git drm-next
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/gpu/drm/sun4i/sun8i_tcon_top.o: In function `init_module':
>> sun8i_tcon_top.c:(.init.text+0x0): multiple definition of `init_module'
   drivers/gpu/drm/sun4i/sun8i_mixer.o:sun8i_mixer.c:(.init.text+0x0): first defined here
   drivers/gpu/drm/sun4i/sun8i_tcon_top.o: In function `cleanup_module':
>> sun8i_tcon_top.c:(.exit.text+0x0): multiple definition of `cleanup_module'
   drivers/gpu/drm/sun4i/sun8i_mixer.o:sun8i_mixer.c:(.exit.text+0x0): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 43418 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180613/44b6eb84/attachment-0001.gz>
