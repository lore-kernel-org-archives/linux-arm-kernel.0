From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 8 Jul 2016 00:47:19 +0800
Subject: [arm-soc:for-next 3/8]
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi:48:41: fatal error:
 dt-bindings/clock/gxbb-clkc.h: No such file or directory
Message-ID: <201607080017.hiQXrLVX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for-next
head:   cdd641aa1c2dbf8b83f3eee0568ac51a165b1c54
commit: 6f5f1e81cdad1d1e019e4dc4b1d532a43a6c3ffe [3/8] Merge branch 'next/dt64' into for-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 6f5f1e81cdad1d1e019e4dc4b1d532a43a6c3ffe
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the arm-soc/for-next HEAD cdd641aa1c2dbf8b83f3eee0568ac51a165b1c54 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts:47:0:
>> arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi:48:41: fatal error: dt-bindings/clock/gxbb-clkc.h: No such file or directory
   compilation terminated.

vim +48 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi

4f24eda8 Andreas F?rber 2016-02-05  42  
4f24eda8 Andreas F?rber 2016-02-05  43  #include <dt-bindings/gpio/gpio.h>
4f24eda8 Andreas F?rber 2016-02-05  44  #include <dt-bindings/interrupt-controller/irq.h>
4f24eda8 Andreas F?rber 2016-02-05  45  #include <dt-bindings/interrupt-controller/arm-gic.h>
f40d437f Carlo Caione   2016-05-02  46  #include <dt-bindings/gpio/meson-gxbb-gpio.h>
6d1a5c93 Neil Armstrong 2016-05-30  47  #include <dt-bindings/reset/amlogic,meson-gxbb-reset.h>
f3abd629 Kevin Hilman   2016-06-14 @48  #include <dt-bindings/clock/gxbb-clkc.h>
4f24eda8 Andreas F?rber 2016-02-05  49  
4f24eda8 Andreas F?rber 2016-02-05  50  / {
4f24eda8 Andreas F?rber 2016-02-05  51  	compatible = "amlogic,meson-gxbb";

:::::: The code at line 48 was first introduced by commit
:::::: f3abd6296168d9d356192b50a92a7a980ca99a2f ARM64: DTS: meson-gxbb: switch ethernet to real clock

:::::: TO: Kevin Hilman <khilman@baylibre.com>
:::::: CC: Kevin Hilman <khilman@baylibre.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 26353 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160708/ec589444/attachment-0001.obj>
