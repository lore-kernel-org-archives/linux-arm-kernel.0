From: lkp@intel.com (kbuild test robot)
Date: Sat, 3 Mar 2018 22:27:53 +0800
Subject: [kernel-hardening] [PATCH 2/2] arm: Kconfig: Add
 ARCH_HAS_FORTIFY_SOURCE
In-Reply-To: <20180228143037.GA3150@pjb1027-Latitude-E5410>
References: <20180228143037.GA3150@pjb1027-Latitude-E5410>
Message-ID: <201803032227.0fjGmsYp%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jinbum,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16-rc3 next-20180302]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jinbum-Park/arm-Add-ARCH_HAS_FORTIFY_SOURCE/20180303-184154
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/boot/compressed/fdt_ro.o: In function `fdt_stringlist_count':
>> fdt_ro.c:(.text+0xc90): undefined reference to `fortify_panic'
   arch/arm/boot/compressed/fdt_ro.o: In function `fdt_stringlist_search':
   fdt_ro.c:(.text+0xd40): undefined reference to `fortify_panic'
   arch/arm/boot/compressed/fdt_ro.o: In function `fdt_stringlist_get':
   fdt_ro.c:(.text+0xe28): undefined reference to `fortify_panic'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65170 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180303/c5bcbe51/attachment-0001.gz>
