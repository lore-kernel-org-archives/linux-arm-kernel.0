From: lkp@intel.com (kbuild test robot)
Date: Wed, 29 Aug 2018 10:44:43 +0800
Subject: [nomadik:ep93xx 2/13] arch/arm/mach-ep93xx/simone.c:73:20: warning:
 initialization discards 'const' qualifier from pointer target type
Message-ID: <201808291039.ofWeJy3i%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git ep93xx
head:   79832e2c71ea990991254b87532e0c54953ae72f
commit: 89a90d59f41088d36e8c97a82e324c31093df4d3 [2/13] Hack in keys
config: arm-ep93xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 89a90d59f41088d36e8c97a82e324c31093df4d3
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

>> arch/arm/mach-ep93xx/simone.c:73:20: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      .platform_data = &simone_keys_pdata,
                       ^

vim +/const +73 arch/arm/mach-ep93xx/simone.c

    68	
    69	static struct platform_device simone_keys_device = {
    70		.name = "gpio-keys",
    71		.id = -1,
    72		.dev = {
  > 73			.platform_data = &simone_keys_pdata,
    74		},
    75	};
    76	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 15712 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180829/0ef84142/attachment-0001.gz>
