From: lkp@intel.com (kbuild test robot)
Date: Sat, 3 Mar 2018 11:32:21 +0800
Subject: [PATCH 3/3] drivers: clk: Add ZynqMP clock driver
In-Reply-To: <1519856861-31384-4-git-send-email-jollys@xilinx.com>
References: <1519856861-31384-4-git-send-email-jollys@xilinx.com>
Message-ID: <201803031109.JhmyjZJJ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jolly,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.16-rc3 next-20180302]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jolly-Shah/drivers-clk-Add-ZynqMp-clock-driver-support/20180303-063643
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from drivers/clk/zynqmp/pll.c:9:0:
>> include/linux/clk/zynqmp.h:10:10: fatal error: linux/firmware/xilinx/zynqmp/firmware.h: No such file or directory
    #include <linux/firmware/xilinx/zynqmp/firmware.h>
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +10 include/linux/clk/zynqmp.h

     8	
     9	#include <linux/spinlock.h>
  > 10	#include <linux/firmware/xilinx/zynqmp/firmware.h>
    11	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59115 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180303/53492f92/attachment-0001.gz>
