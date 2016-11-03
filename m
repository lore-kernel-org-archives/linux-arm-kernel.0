From: lkp@intel.com (kbuild test robot)
Date: Thu, 3 Nov 2016 09:59:24 +0800
Subject: [PATCH v1 03/11] drivers: soc: hisi: Add support for Hisilicon
 Djtag driver
In-Reply-To: <1478101374-18778-4-git-send-email-anurup.m@huawei.com>
Message-ID: <201611030929.mZbmU1lT%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tan,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.9-rc3 next-20161028]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Anurup-M/perf-arm64-Support-for-Hisilicon-SoC-Hardware-event-counters/20161102-235009
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `djtag_readwrite_v2':
>> binder.c:(.text+0x10cd64): undefined reference to `__const_udelay'
   binder.c:(.text+0x10cd98): undefined reference to `__const_udelay'
   drivers/built-in.o: In function `djtag_readwrite_v1':
   binder.c:(.text+0x10cf10): undefined reference to `__const_udelay'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59446 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161103/4196e252/attachment-0001.gz>
