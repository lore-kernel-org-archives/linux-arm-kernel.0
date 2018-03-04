From: lkp@intel.com (kbuild test robot)
Date: Sun, 4 Mar 2018 11:47:14 +0800
Subject: [PATCH v4 16/22] nvmem: meson-efuse: Do no gate COMPILE_TEST
 with MESON_SM
In-Reply-To: <20180228144106.16363-17-andrew.smirnov@gmail.com>
References: <20180228144106.16363-17-andrew.smirnov@gmail.com>
Message-ID: <201803041136.efjLjhse%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16-rc3 next-20180302]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrey-Smirnov/Verbatim-device-names-and-devm_nvmem_-un-register/20180303-220801
config: sparc64-allyesconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All errors (new ones prefixed by >>):

   `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
   `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
   `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
   `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
   drivers/nvmem/meson-efuse.o: In function `meson_efuse_read':
>> meson-efuse.c:(.text+0x28): undefined reference to `meson_sm_call_read'
   drivers/nvmem/meson-efuse.o: In function `meson_efuse_probe':
>> meson-efuse.c:(.text+0x64): undefined reference to `meson_sm_call'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 53476 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180304/23adb6c9/attachment-0001.gz>
