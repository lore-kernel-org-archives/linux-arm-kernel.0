From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 7 May 2017 13:24:51 +0800
Subject: [stericsson:mmc-no-null-mq-v4.11 91/93] block.c:(.init.text+0x0):
 multiple definition of `init_module'
Message-ID: <201705071349.18mdIn1d%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git mmc-no-null-mq-v4.11
head:   6747bffda469bc8236af62c1267613bac0a4bb10
commit: e311f2b40345fb17b74813bd05e734d4e8ef1c89 [91/93] mmc: core: make block layer non-optional
config: x86_64-rhel (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout e311f2b40345fb17b74813bd05e734d4e8ef1c89
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/mmc/core/block.o: In function `mmc_blk_init':
>> block.c:(.init.text+0x0): multiple definition of `init_module'
   drivers/mmc/core/core.o:core.c:(.init.text+0x86c): first defined here
   drivers/mmc/core/block.o: In function `mmc_blk_exit':
>> block.c:(.exit.text+0x0): multiple definition of `cleanup_module'
   drivers/mmc/core/core.o:core.c:(.exit.text+0x0): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38847 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170507/ea018920/attachment-0001.gz>
