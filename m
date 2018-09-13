From: lkp@intel.com (kbuild test robot)
Date: Thu, 13 Sep 2018 08:34:19 +0800
Subject: [PATCH v3 10/21] nvmem: change the signature of nvmem_unregister()
In-Reply-To: <20180912075129.25185-11-brgl@bgdev.pl>
References: <20180912075129.25185-11-brgl@bgdev.pl>
Message-ID: <201809130842.7chpMsT2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.19-rc3 next-20180912]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bartosz-Golaszewski/nvmem-rework-of-the-subsystem-for-non-DT-users/20180913-071053
config: m68k-sun3_defconfig (attached as .config)
compiler: m68k-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=m68k 

All warnings (new ones prefixed by >>):

   In file included from include/linux/rtc.h:18:0,
                    from include/linux/alarmtimer.h:8,
                    from include/linux/posix-timers.h:9,
                    from include/linux/posix-clock.h:26,
                    from drivers//ptp/ptp_clock.c:26:
   include/linux/nvmem-provider.h: In function 'devm_nvmem_unregister':
>> include/linux/nvmem-provider.h:101:9: warning: return makes integer from pointer without a cast [-Wint-conversion]
     return ERR_PTR(-ENOSYS);
            ^~~~~~~~~~~~~~~~

vim +101 include/linux/nvmem-provider.h

    97	
    98	static inline int
    99	devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
   100	{
 > 101		return ERR_PTR(-ENOSYS);
   102	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 12115 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180913/2b626a26/attachment.gz>
