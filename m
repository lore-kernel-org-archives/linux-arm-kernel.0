From: lkp@intel.com (kbuild test robot)
Date: Sun, 6 Mar 2016 18:51:19 +0800
Subject: [PATCH 2/2] arm64: tegra: Jetson-TX1: Add DT entry for system
 PMIC MAX77620
In-Reply-To: <1456751211-14341-2-git-send-email-ldewangan@nvidia.com>
Message-ID: <201603061816.5RCjo7Lz%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laxman,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.5-rc6 next-20160304]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Laxman-Dewangan/arm64-tegra-Add-DT-entry-for-keys-used-in-Jetson-TX1/20160229-212214
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: arm64-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts:5:38: fatal error: dt-bindings/mfd/max77620.h: No such file or directory
    #include <dt-bindings/mfd/max77620.h>
                                         ^
   compilation terminated.

vim +5 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts

     1	/dts-v1/;
     2	
     3	#include "tegra210-p2180.dtsi"
     4	#include "tegra210-p2597.dtsi"
   > 5	#include <dt-bindings/mfd/max77620.h>
     6	#include <dt-bindings/input/input.h>
     7	
     8	/ {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 48281 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160306/4083d80c/attachment-0001.obj>
