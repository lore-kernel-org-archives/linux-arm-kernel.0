From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Nov 2014 23:52:53 +0100
Subject: Fwd: [arm-soc:next/soc 1/1] WARNING: vmlinux.o(.text+0x730e38):
 Section mismatch in reference from the function brcmstb_gisb_arb_probe() to
 the function .init.text:hook_fault_code()
Message-ID: <22844091.DkblDJL9Ph@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The problem was introduced by f1bee783dd37 "bus: brcmstb_gisb: register the
fault code hook", as hook_fault_code is an __init function and is now
called from a probe function.

	Arnd

----------  Forwarded Message  ----------

Subject: [arm-soc:next/soc 1/1] WARNING: vmlinux.o(.text+0x730e38): Section mismatch in reference from the function brcmstb_gisb_arb_probe() to the function .init.text:hook_fault_code()
Date: Wednesday 12 November 2014, 06:41:51
From: kbuild test robot <fengguang.wu@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: kbuild-all at 01.org, Arnd Bergmann <arnd@arndb.de>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git next/soc
head:   dc680b989d519952e0e0d37204fec850925a0225
commit: dc680b989d519952e0e0d37204fec850925a0225 [1/1] ARM: fix multiplatform allmodcompile
config: arm-allmodconfig (attached as .config)
reproduce:
  wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
  chmod +x ~/bin/make.cross
  git checkout dc680b989d519952e0e0d37204fec850925a0225
  # save the attached .config to linux build tree
  make.cross ARCH=arm 

All warnings:

>> WARNING: vmlinux.o(.text+0x730e38): Section mismatch in reference from the function brcmstb_gisb_arb_probe() to the function .init.text:hook_fault_code()
   The function brcmstb_gisb_arb_probe() references
   the function __init hook_fault_code().
   This is often because brcmstb_gisb_arb_probe lacks a __init
   annotation or the annotation of hook_fault_code is wrong.

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
-----------------------------------------
