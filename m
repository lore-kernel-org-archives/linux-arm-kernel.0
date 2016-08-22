From: lkp@intel.com (kbuild test robot)
Date: Tue, 23 Aug 2016 02:59:15 +0800
Subject: [PATCH 2/2] ARM: dts: add TOPEET itop elite based board
In-Reply-To: <1471875489-11428-3-git-send-email-ayaka@soulik.info>
Message-ID: <201608230255.lGk78RdH%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Randy,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.8-rc3 next-20160822]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Randy-Li/ARM-dts-Add-TOPEET-itop-core-board-SCP-package-version/20160822-222021
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   In file included from arch/arm/boot/dts/exynos4412-itop-elite.dts:17:0:
>> arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi:21:47: fatal error: dt-bindings/clock/samsung,s5m8767.h: No such file or directory
   compilation terminated.

vim +21 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi

42b32682 Randy Li 2016-08-22   5   *			https://www.sumomo.mobi
42b32682 Randy Li 2016-08-22   6   *			Randy Li <ayaka@soulik.info>
42b32682 Randy Li 2016-08-22   7   *			
42b32682 Randy Li 2016-08-22   8   * Device tree source file for TOPEET iTop Exynos 4412 SCP package core 
42b32682 Randy Li 2016-08-22   9   * board which is based on Samsung's Exynos4412 SoC.
42b32682 Randy Li 2016-08-22  10   *
42b32682 Randy Li 2016-08-22  11   * This program is free software; you can redistribute it and/or modify
42b32682 Randy Li 2016-08-22  12   * it under the terms of the GNU General Public License version 2 as
42b32682 Randy Li 2016-08-22  13   * published by the Free Software Foundation.
42b32682 Randy Li 2016-08-22  14  */
42b32682 Randy Li 2016-08-22  15  
42b32682 Randy Li 2016-08-22  16  #include "exynos4412.dtsi"
42b32682 Randy Li 2016-08-22  17  #include "exynos4412-ppmu-common.dtsi"
42b32682 Randy Li 2016-08-22  18  #include "exynos-mfc-reserved-memory.dtsi"
42b32682 Randy Li 2016-08-22  19  #include <dt-bindings/gpio/gpio.h>
42b32682 Randy Li 2016-08-22  20  #include <dt-bindings/input/input.h>
42b32682 Randy Li 2016-08-22 @21  #include <dt-bindings/clock/samsung,s5m8767.h>
42b32682 Randy Li 2016-08-22  22  
42b32682 Randy Li 2016-08-22  23  / {
42b32682 Randy Li 2016-08-22  24  	memory {
42b32682 Randy Li 2016-08-22  25  		reg = <0x40000000 0x40000000>;
42b32682 Randy Li 2016-08-22  26  	};
42b32682 Randy Li 2016-08-22  27  
42b32682 Randy Li 2016-08-22  28  	firmware at 0203F000 {
42b32682 Randy Li 2016-08-22  29  		compatible = "samsung,secure-firmware";

:::::: The code at line 21 was first introduced by commit
:::::: 42b32682968d7e76d32f9db37795784297a284c7 ARM: dts: Add TOPEET itop core board SCP package version

:::::: TO: Randy Li <ayaka@soulik.info>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 58497 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160823/efd26cfe/attachment-0001.obj>
