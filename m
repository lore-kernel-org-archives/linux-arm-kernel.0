From: lkp@intel.com (kbuild test robot)
Date: Mon, 20 Aug 2018 08:11:23 +0800
Subject: [PATCH V2] arm64: dts: sdm630 SoC and Sony Pioneer (Xperia XA2)
 support
In-Reply-To: <20180812142317.19991-1-ctatlor97@gmail.com>
References: <20180812142317.19991-1-ctatlor97@gmail.com>
Message-ID: <201808200732.CVi0qVep%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Craig,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on agross/for-next]
[also build test ERROR on v4.18 next-20180817]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Craig-Tatlor/arm64-dts-sdm630-SoC-and-Sony-Pioneer-Xperia-XA2-support/20180813-040803
base:   https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git for-next
config: arm64-allnoconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/qcom/sdm630-pioneer.dtsi:4:0,
                    from arch/arm64/boot/dts/qcom/sdm630-pioneer.dts:6:
>> arch/arm64/boot/dts/qcom/sdm630.dtsi:5:10: fatal error: dt-bindings/clock/qcom,gcc-sdm660.h: No such file or directory
    #include <dt-bindings/clock/qcom,gcc-sdm660.h>
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +5 arch/arm64/boot/dts/qcom/sdm630.dtsi

     3	
     4	#include <dt-bindings/interrupt-controller/arm-gic.h>
   > 5	#include <dt-bindings/clock/qcom,gcc-sdm660.h>
     6	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6666 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180820/4fde0e3a/attachment.gz>
