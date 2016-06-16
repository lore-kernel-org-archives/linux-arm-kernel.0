From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 16 Jun 2016 19:23:30 +0800
Subject: [nomadik:nhk15-clcd 6/14] drivers/video/fbdev/amba-clcd.c:606:
 undefined reference to `of_find_backlight_by_node'
Message-ID: <201606161928.GZfUQYBR%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git nhk15-clcd
head:   80109ac8700188687807bba720744d870440a551
commit: 1f57a81fe4b0221b7a5b1ce9fad2b4d1492395ac [6/14] video: ARM CLCD: backlight support for OF
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 1f57a81fe4b0221b7a5b1ce9fad2b4d1492395ac
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `clcdfb_of_get_backlight':
>> drivers/video/fbdev/amba-clcd.c:606: undefined reference to `of_find_backlight_by_node'
   drivers/video/fbdev/amba-clcd.c:606:(.text+0x68f1c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `of_find_backlight_by_node'

vim +606 drivers/video/fbdev/amba-clcd.c

   600		if (!panel)
   601			return -ENODEV;
   602	
   603		/* Look up the optional backlight phandle */
   604		backlight = of_parse_phandle(panel, "backlight", 0);
   605		if (backlight) {
 > 606			clcd_panel->backlight = of_find_backlight_by_node(backlight);
   607			of_node_put(backlight);
   608	
   609			if (!clcd_panel->backlight)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 25987 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160616/1244617c/attachment-0001.obj>
