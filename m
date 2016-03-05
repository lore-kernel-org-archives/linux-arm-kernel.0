From: lkp@intel.com (kbuild test robot)
Date: Sun, 6 Mar 2016 02:16:41 +0800
Subject: [PATCH v3 net-next 7/9] net: mvneta: bm: add support for
 hardware buffer management
In-Reply-To: <1457198221-21752-8-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <201603060254.FU6qyCZg%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcin,

[auto build test ERROR on v4.5-rc6]
[also build test ERROR on next-20160304]
[cannot apply to net-next/master robh/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Gregory-CLEMENT/API-set-for-HW-Buffer-management/20160306-012250
config: arm-multi_v7_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `mvneta_rx_refill':
   :(.text+0x2b4168): undefined reference to `mvneta_frag_alloc'
   :(.text+0x2b4258): undefined reference to `mvneta_frag_free'
   drivers/built-in.o: In function `mvneta_remove':
>> :(.text+0x2b4aec): undefined reference to `mvneta_bm_pool_destroy'
   :(.text+0x2b4b04): undefined reference to `mvneta_bm_pool_destroy'
   drivers/built-in.o: In function `mvneta_cleanup_rxqs':
   :(.text+0x2b52ec): undefined reference to `mvneta_frag_free'
   drivers/built-in.o: In function `mvneta_poll':
   :(.text+0x2b579c): undefined reference to `mvneta_bm_pool_refill'
   drivers/built-in.o: In function `mvneta_bm_update_mtu':
>> :(.text+0x2b65d0): undefined reference to `mvneta_bm_bufs_free'
   :(.text+0x2b6614): undefined reference to `mvneta_bm_pool_destroy'
   :(.text+0x2b662c): undefined reference to `mvneta_bm_pool_destroy'
   :(.text+0x2b6694): undefined reference to `mvneta_bm_bufs_add'
   drivers/built-in.o: In function `mvneta_probe':
>> :(.text+0x2b6eac): undefined reference to `mvneta_bm_pool_use'
   :(.text+0x2b6f5c): undefined reference to `mvneta_bm_pool_use'
   :(.text+0x2b73cc): undefined reference to `mvneta_bm_pool_destroy'
   :(.text+0x2b73e4): undefined reference to `mvneta_bm_pool_destroy'
   :(.text+0x2b7ab4): undefined reference to `mvneta_bm_pool_destroy'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 36571 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160306/a8596d58/attachment-0001.obj>
