From: lkp@intel.com (kbuild test robot)
Date: Fri, 14 Apr 2017 14:03:44 +0800
Subject: [PATCH 3/4] net: macb: Add hardware PTP support
In-Reply-To: <1492090763-15686-1-git-send-email-rafalo@cadence.com>
Message-ID: <201704141429.nTfzVN8r%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafal,

[auto build test ERROR on net-next/master]
[also build test ERROR on v4.11-rc6 next-20170413]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Rafal-Ozieblo/net-macb-Add-support-for-PTP-timestamps-in-DMA-descriptors/20170414-001330
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the linux-review/Rafal-Ozieblo/net-macb-Add-support-for-PTP-timestamps-in-DMA-descriptors/20170414-001330 HEAD 3b878618e04f866388fd62f6c44752e50b15658a builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `macb_interrupt':
>> kfifo_buf.c:(.text+0xeabd8): undefined reference to `macb_ptp_int'
>> kfifo_buf.c:(.text+0xeac6c): undefined reference to `gem_ptp_txstamp'
   drivers/built-in.o: In function `gem_rx':
>> kfifo_buf.c:(.text+0xebbd8): undefined reference to `gem_ptp_rxstamp'
>> drivers/built-in.o:(.data+0xa5e0): undefined reference to `gem_ptp_init'
>> drivers/built-in.o:(.data+0xa5e4): undefined reference to `gem_ptp_remove'
>> drivers/built-in.o:(.data+0xa5f4): undefined reference to `gem_get_hwtst'
>> drivers/built-in.o:(.data+0xa5f8): undefined reference to `gem_set_hwtst'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 22468 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170414/7e8e6b3b/attachment-0001.gz>
