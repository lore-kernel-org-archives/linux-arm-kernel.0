From: guodong.xu@linaro.org (Guodong Xu)
Date: Mon, 25 Aug 2014 21:39:39 +0800
Subject: [PATCH 0/2] Hi6421 MFD driver
Message-ID: <1408973982-2072-1-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset add MFD driver for Hi6421 SoC.

It's based on my previous v6 patchset for Hi6421 MFD & regulator driver. But
since regulator part is applied, I rebased the MFD part to v3.17-rc1, merged
review feedback from Lee Jones, solved conflict in Makefile, and fixed a build
error.

Hi6421 is a PMIC SoC designed and manufactured by HiSilicon Ltd. It includes
multi-functions, such as regulators, codec, ADCs, Coulomb counter, etc.
Hi6421 can be used in various Hi3620 SoC based boards. Registers in Hi6421 are
memory bus mapped, so in this design they are accessed by regmap-mmio APIs.

---
changes in this version:
 * merge conflict in drivers/mfd/Makefile
 * use devm_ioremap_resource, as devm_request_and_ioremap is deprecated and
    now removed.
 * incorporate feedback from maintainer
    - Documentation as a separate patch
    - dts node rename from 'pmic' to 'hi6421'
based on v6 patchset for Hi6421 MFD & regulator

Guodong Xu (3):
  Documentation: mfd: add docs for hi6421 dt
  mfd: Add hi6421 PMIC core driver
  ARM: dts: hi3620-hi4511: Add HI6421 MFD and regulator nodes

 Documentation/devicetree/bindings/mfd/hi6421.txt |  38 ++++
 arch/arm/boot/dts/hi3620-hi4511.dts              | 233 +++++++++++++++++++++++
 drivers/mfd/Kconfig                              |  13 ++
 drivers/mfd/Makefile                             |   1 +
 drivers/mfd/hi6421-pmic-core.c                   | 112 +++++++++++
 include/linux/mfd/hi6421-pmic.h                  |  42 ++++
 6 files changed, 439 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/hi6421.txt
 create mode 100644 drivers/mfd/hi6421-pmic-core.c
 create mode 100644 include/linux/mfd/hi6421-pmic.h

-- 
1.9.1
