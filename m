From: lkp@intel.com (kbuild test robot)
Date: Wed, 30 May 2018 04:08:53 +0800
Subject: [patch v22 1/4] drivers: jtag: Add JTAG core driver
In-Reply-To: <1527503652-21975-2-git-send-email-oleksandrs@mellanox.com>
References: <1527503652-21975-2-git-send-email-oleksandrs@mellanox.com>
Message-ID: <201805300309.xm57deLw%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleksandr,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.17-rc7 next-20180529]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Oleksandr-Shamray/JTAG-driver-introduction/20180529-195609
config: sh-allmodconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All errors (new ones prefixed by >>):

>> drivers/jtag/jtag.c:288:13: error: static declaration of 'devm_jtag_unregister' follows non-static declaration
    static void devm_jtag_unregister(struct device *dev, void *res)
                ^~~~~~~~~~~~~~~~~~~~
   In file included from drivers/jtag/jtag.c:9:0:
   include/linux/jtag.h:38:6: note: previous declaration of 'devm_jtag_unregister' was here
    void devm_jtag_unregister(struct device *dev, void *res);
         ^~~~~~~~~~~~~~~~~~~~

vim +/devm_jtag_unregister +288 drivers/jtag/jtag.c

   287	
 > 288	static void devm_jtag_unregister(struct device *dev, void *res)
   289	{
   290		jtag_unregister(*(struct jtag **)res);
   291	}
   292	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 47739 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180530/5fd33601/attachment-0001.gz>
