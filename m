From: lkp@intel.com (kbuild test robot)
Date: Thu, 13 Sep 2018 09:46:33 +0800
Subject: [PATCH v3 10/21] nvmem: change the signature of nvmem_unregister()
In-Reply-To: <20180912075129.25185-11-brgl@bgdev.pl>
References: <20180912075129.25185-11-brgl@bgdev.pl>
Message-ID: <201809130947.r1VaquGX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.19-rc3 next-20180912]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bartosz-Golaszewski/nvmem-rework-of-the-subsystem-for-non-DT-users/20180913-071053
config: powerpc-allnoconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   In file included from include/linux/rtc.h:18:0,
                    from arch/powerpc/kernel/time.c:52:
   include/linux/nvmem-provider.h: In function 'devm_nvmem_unregister':
>> include/linux/nvmem-provider.h:101:9: error: return makes integer from pointer without a cast [-Werror=int-conversion]
     return ERR_PTR(-ENOSYS);
            ^~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

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
Size: 5832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180913/f211186e/attachment.gz>
