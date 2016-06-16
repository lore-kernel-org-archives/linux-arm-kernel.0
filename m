From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 16 Jun 2016 19:52:11 +0800
Subject: [nomadik:nhk15-clcd 9/14]
 drivers/video/fbdev/amba-clcd-nomadik.c:156:28: warning: unused variable
 'var'
Message-ID: <201606161910.igFgJeqv%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git nhk15-clcd
head:   80109ac8700188687807bba720744d870440a551
commit: 6be6baa6ab55e26554a9f42fe22eb8d8fb28f542 [9/14] videa: ARM CLCD: add special board and panel hooks for Nomadik
config: arm-nhk8815_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 6be6baa6ab55e26554a9f42fe22eb8d8fb28f542
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   drivers/video/fbdev/amba-clcd-nomadik.c: In function 'tpg110_enable':
>> drivers/video/fbdev/amba-clcd-nomadik.c:156:28: warning: unused variable 'var' [-Wunused-variable]
     struct fb_var_screeninfo *var = &fb->fb.var;
                               ^

vim +/var +156 drivers/video/fbdev/amba-clcd-nomadik.c

   140			break;
   141		case 0x7:
   142			dev_info(dev, "800x480 RGB");
   143			break;
   144		default:
   145			dev_info(dev, "ILLEGAL RESOLUTION");
   146			break;
   147		}
   148	
   149		val = tpg110_read_reg(0x03);
   150		dev_info(dev, "resolution is controlled by %s\n",
   151			(val & BIT(7)) ? "software" : "hardware");
   152	}
   153	
   154	static void tpg110_enable(struct clcd_fb *fb)
   155	{
 > 156		struct fb_var_screeninfo *var = &fb->fb.var;
   157		struct device *dev = &fb->dev->dev;
   158		static bool startup = false;
   159		u8 val;
   160	
   161		if (!startup) {
   162			tpg110_startup(dev);
   163			startup = true;
   164		}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 15146 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160616/624ca207/attachment-0001.obj>
