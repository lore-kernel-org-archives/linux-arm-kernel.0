From: collinsd@codeaurora.org (David Collins)
Date: Fri, 13 Apr 2018 19:50:33 -0700
Subject: [PATCH v2 0/2] regulator: add QCOM RPMh regulator driver
Message-ID: <cover.1523673467.git.collinsd@codeaurora.org>
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

Changes since v1 [3]:
 - Addressed review feedback from Doug, Mark, and Stephen
 - Replaced set_voltage()/get_voltage() callbacks with set_voltage_sel()/
   get_voltage_sel()
 - Added set_bypass()/get_bypass() callbacks for BOB pass-through mode
   control
 - Removed top-level PMIC data structures
 - Removed initialization variables from structs and passed them as
   function parameters
 - Removed various comments and error messages
 - Simplified mode handling
 - Refactored per-PMIC rpmh-regulator data specification
 - Simplified probe function
 - Moved header into DT patch
 - Removed redundant property listings from DT binding documentation

Thanks,
David

[1]: https://lkml.org/lkml/2018/4/5/480
[2]: https://lkml.org/lkml/2018/4/10/714
[3]: https://lkml.org/lkml/2018/3/16/1431

David Collins (2):
  regulator: dt-bindings: add QCOM RPMh regulator bindings
  regulator: add QCOM RPMh regulator driver

 .../bindings/regulator/qcom,rpmh-regulator.txt     | 207 +++++
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/qcom_rpmh-regulator.c            | 910 +++++++++++++++++++++
 .../dt-bindings/regulator/qcom,rpmh-regulator.h    |  36 +
 5 files changed, 1163 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
 create mode 100644 drivers/regulator/qcom_rpmh-regulator.c
 create mode 100644 include/dt-bindings/regulator/qcom,rpmh-regulator.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
