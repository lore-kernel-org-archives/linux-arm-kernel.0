From: lkp@intel.com (kbuild test robot)
Date: Fri, 6 Jul 2018 17:25:11 +0800
Subject: [PATCH] ARM64: dts: meson-axg: add the audio clock controller
In-Reply-To: <20180705113713.15267-1-jbrunet@baylibre.com>
References: <20180705113713.15267-1-jbrunet@baylibre.com>
Message-ID: <201807061625.HMohw1pJ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome,

I love your patch! Yet something to improve:

[auto build test ERROR on v4.18-rc3]
[also build test ERROR on next-20180705]
[cannot apply to robh/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jerome-Brunet/ARM64-dts-meson-axg-add-the-audio-clock-controller/20180705-221904
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/amlogic/meson-axg-s400.dts:8:0:
>> arch/arm64/boot/dts/amlogic/meson-axg.dtsi:9:10: fatal error: dt-bindings/clock/axg-audio-clkc.h: No such file or directory
    #include <dt-bindings/clock/axg-audio-clkc.h>
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +9 arch/arm64/boot/dts/amlogic/meson-axg.dtsi

   > 9	#include <dt-bindings/clock/axg-audio-clkc.h>
    10	#include <dt-bindings/clock/axg-clkc.h>
    11	#include <dt-bindings/clock/axg-aoclkc.h>
    12	#include <dt-bindings/gpio/meson-axg-gpio.h>
    13	#include <dt-bindings/reset/amlogic,meson-axg-reset.h>
    14	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38747 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180706/b395c40d/attachment-0001.gz>
