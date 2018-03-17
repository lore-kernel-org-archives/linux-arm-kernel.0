From: collinsd@codeaurora.org (David Collins)
Date: Fri, 16 Mar 2018 18:09:09 -0700
Subject: [PATCH 0/2] regulator: add QCOM RPMh regulator driver
Message-ID: <cover.1521246069.git.collinsd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds a driver and device tree binding documentation for
PMIC regulator control via Resource Power Manager-hardened (RPMh) on some
Qualcomm Technologies, Inc. SoCs such as SDM845.  RPMh is a hardware block
which contains several accelerators which are used to manage various
hardware resources that are shared between the processors of the SoC.  The
final hardware state of a regulator is determined within RPMh by performing
max aggregation of the requests made by all of the processors.

The RPMh regulator driver depends upon the RPMh driver [1] and command DB
driver [2] which are both still undergoing review.

Thanks,
David

[1]: https://lkml.org/lkml/2018/3/9/979
[2]: https://lkml.org/lkml/2018/3/14/787

David Collins (2):
  regulator: add QCOM RPMh regulator driver
  dt-bindings: regulator: add QCOM RPMh regulator bindings

 .../bindings/regulator/qcom,rpmh-regulator.txt     |  246 +++++
 drivers/regulator/Kconfig                          |    9 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/qcom_rpmh-regulator.c            | 1124 ++++++++++++++++++++
 .../dt-bindings/regulator/qcom,rpmh-regulator.h    |   40 +
 5 files changed, 1420 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
 create mode 100644 drivers/regulator/qcom_rpmh-regulator.c
 create mode 100644 include/dt-bindings/regulator/qcom,rpmh-regulator.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
