From: lkp@intel.com (kbuild test robot)
Date: Tue, 22 May 2018 10:25:55 +0800
Subject: [PATCH 05/15] drm/sun4i: Add TCON TOP driver
In-Reply-To: <20180519183127.2718-6-jernej.skrabec@siol.net>
References: <20180519183127.2718-6-jernej.skrabec@siol.net>
Message-ID: <201805221029.2c86CYZs%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jernej,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on v4.17-rc6 next-20180517]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jernej-Skrabec/Add-support-for-R40-HDMI-pipeline/20180521-131839
base:   git://people.freedesktop.org/~airlied/linux.git drm-next
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

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
Size: 43346 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180522/9eadc9f2/attachment-0001.gz>
