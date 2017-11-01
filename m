From: lkp@intel.com (kbuild test robot)
Date: Thu, 2 Nov 2017 06:14:21 +0800
Subject: [patch v10 2/4] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
In-Reply-To: <1509365528-28803-3-git-send-email-oleksandrs@mellanox.com>
References: <1509365528-28803-3-git-send-email-oleksandrs@mellanox.com>
Message-ID: <201711020628.gDB79T0F%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleksandr,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.14-rc7]
[cannot apply to next-20171018]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Oleksandr-Shamray/JTAG-driver-introduction/20171102-045624
config: blackfin-allyesconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All errors (new ones prefixed by >>):

>> drivers//jtag/jtag-aspeed.c:703:10: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .xfer = aspeed_jtag_xfer
             ^~~~~~~~~~~~~~~~
   drivers//jtag/jtag-aspeed.c:703:10: note: (near initialization for 'aspeed_jtag_ops.xfer')
   cc1: some warnings being treated as errors

vim +703 drivers//jtag/jtag-aspeed.c

   697	
   698	static const struct jtag_ops aspeed_jtag_ops = {
   699		.freq_get = aspeed_jtag_freq_get,
   700		.freq_set = aspeed_jtag_freq_set,
   701		.status_get = aspeed_jtag_status_get,
   702		.idle = aspeed_jtag_idle,
 > 703		.xfer = aspeed_jtag_xfer
   704	};
   705	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 46048 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171102/67c9eb57/attachment-0001.gz>
