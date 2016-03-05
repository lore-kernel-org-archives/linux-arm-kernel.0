From: lkp@intel.com (kbuild test robot)
Date: Sun, 6 Mar 2016 02:40:16 +0800
Subject: [PATCH v3 net-next 9/9] net: mvneta: Use the new hwbm framework
In-Reply-To: <1457198221-21752-10-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <201603060227.TkSZowaP%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

[auto build test ERROR on v4.5-rc6]
[cannot apply to net-next/master robh/for-next next-20160304]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Gregory-CLEMENT/API-set-for-HW-Buffer-management/20160306-012250
config: arm-multi_v7_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `mvneta_remove':
   :(.text+0x2b49d4): undefined reference to `mvneta_bm_pool_destroy'
   :(.text+0x2b49ec): undefined reference to `mvneta_bm_pool_destroy'
   drivers/built-in.o: In function `mvneta_bm_update_mtu':
   :(.text+0x2b52e8): undefined reference to `mvneta_bm_bufs_free'
   :(.text+0x2b532c): undefined reference to `mvneta_bm_pool_destroy'
   :(.text+0x2b5344): undefined reference to `mvneta_bm_pool_destroy'
>> :(.text+0x2b53ac): undefined reference to `hwbm_pool_add'
   drivers/built-in.o: In function `mvneta_probe':
   :(.text+0x2b5a74): undefined reference to `mvneta_bm_pool_use'
   :(.text+0x2b5b24): undefined reference to `mvneta_bm_pool_use'
   :(.text+0x2b5fa4): undefined reference to `mvneta_bm_pool_destroy'
   :(.text+0x2b5fbc): undefined reference to `mvneta_bm_pool_destroy'
   :(.text+0x2b6698): undefined reference to `mvneta_bm_pool_destroy'
   drivers/built-in.o: In function `mvneta_poll':
>> :(.text+0x2b7e98): undefined reference to `hwbm_pool_refill'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 36571 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160306/5abdd897/attachment-0001.obj>
