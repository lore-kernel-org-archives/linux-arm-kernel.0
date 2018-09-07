From: lkp@intel.com (kbuild test robot)
Date: Fri, 7 Sep 2018 13:11:37 +0800
Subject: [PATCH 08/13] nvmem: add a notifier chain
In-Reply-To: <20180905095738.26406-9-brgl@bgdev.pl>
References: <20180905095738.26406-9-brgl@bgdev.pl>
Message-ID: <201809071334.mbXFY6MH%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.19-rc2 next-20180906]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bartosz-Golaszewski/nvmem-rework-of-the-subsystem-for-non-DT-users/20180907-112400
config: i386-randconfig-s3-09061342 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   In file included from drivers//of/of_net.c:10:0:
>> include/linux/nvmem-consumer.h:142:19: error: two or more data types in declaration specifiers
    static inline int int nvmem_unregister_notifier(struct notifier_block *nb)
                      ^~~

vim +142 include/linux/nvmem-consumer.h

   141	
 > 142	static inline int int nvmem_unregister_notifier(struct notifier_block *nb)
   143	{
   144		return -ENOSYS;
   145	}
   146	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 27032 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180907/566153cb/attachment-0001.gz>
