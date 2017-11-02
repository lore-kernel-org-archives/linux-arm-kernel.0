From: lkp@intel.com (kbuild test robot)
Date: Thu, 2 Nov 2017 08:58:51 +0800
Subject: [patch v10 2/4] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
In-Reply-To: <1509365528-28803-3-git-send-email-oleksandrs@mellanox.com>
References: <1509365528-28803-3-git-send-email-oleksandrs@mellanox.com>
Message-ID: <201711020831.fEZEYWBm%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleksandr,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.14-rc7]
[cannot apply to next-20171018]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Oleksandr-Shamray/JTAG-driver-introduction/20171102-045624
config: m68k-allyesconfig (attached as .config)
compiler: m68k-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m68k 

All warnings (new ones prefixed by >>):

>> drivers//jtag/jtag-aspeed.c:704:1: warning: initialization from incompatible pointer type
    };
    ^
   drivers//jtag/jtag-aspeed.c:704:1: warning: (near initialization for 'aspeed_jtag_ops.xfer')

vim +704 drivers//jtag/jtag-aspeed.c

   697	
   698	static const struct jtag_ops aspeed_jtag_ops = {
   699		.freq_get = aspeed_jtag_freq_get,
   700		.freq_set = aspeed_jtag_freq_set,
   701		.status_get = aspeed_jtag_status_get,
   702		.idle = aspeed_jtag_idle,
   703		.xfer = aspeed_jtag_xfer
 > 704	};
   705	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 44335 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171102/e4deb653/attachment-0001.gz>
