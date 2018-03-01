From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 2 Mar 2018 02:10:35 +0800
Subject: [xlnx:master 1405/1438] drivers/crypto/zynqmp-sha.c:31:10: fatal
 error: linux/soc/xilinx/zynqmp/firmware.h: No such file or directory
Message-ID: <201803020232.TMXbcMDA%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   807fdad49dd7b39688d91c60925994956cfafef4
commit: 55ddcf001d16a1490c8d3ba54a685229eba606b7 [1405/1438] soc: zynqmp: Deprecate legacy PM driver
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 55ddcf001d16a1490c8d3ba54a685229eba606b7
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> drivers/crypto/zynqmp-sha.c:31:10: fatal error: linux/soc/xilinx/zynqmp/firmware.h: No such file or directory
    #include <linux/soc/xilinx/zynqmp/firmware.h>
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
>> drivers/crypto/zynqmp-rsa.c:27:10: fatal error: linux/soc/xilinx/zynqmp/firmware.h: No such file or directory
    #include <linux/soc/xilinx/zynqmp/firmware.h>
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +31 drivers/crypto/zynqmp-sha.c

6aa92efb Nava kishore Manne 2017-09-19 @31  #include <linux/soc/xilinx/zynqmp/firmware.h>
6aa92efb Nava kishore Manne 2017-09-19  32  

:::::: The code at line 31 was first introduced by commit
:::::: 6aa92efb058fe13225b5ee06e2d6ca5f221e505f crypto: zynqmp-sha: Adopted SHA3 support for ZynqMP Soc

:::::: TO: Nava kishore Manne <nava.manne@xilinx.com>
:::::: CC: Michal Simek <michal.simek@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62067 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180302/a350fca6/attachment-0001.gz>
