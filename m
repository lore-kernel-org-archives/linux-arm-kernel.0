From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Tue, 26 Aug 2014 15:45:53 +0300
Subject: [PATCH v2 0/3] pinctrl: qcom: Add APQ8084 pinctrl support
Message-ID: <1409057156-1201-1-git-send-email-gdjakov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches adds pinctrl support for the Qualcomm APQ8084 platform.
The first patch adds the pin definitions. The second patch contains the
devicetree binding documentation. The last patch adds the DT node.

Tested on IFC6540 board.

Changes since v1:
 - Updated the total number of pins (suggested by Bjorn Andersson)
 - Added the missing pin info (provided by Andy Gross)
 - Updated groups and functions to be consistent with other pinctrls.
   (suggested by Andy Gross)
 - Removed unused functions, qdss and test pins. (suggested by Andy Gross)
 - Updated the documentation with the possible functions.

Georgi Djakov (3):
  pinctrl: qcom: Add APQ8084 pinctrl support
  dt: Document Qualcomm APQ8084 pinctrl binding
  ARM: dts: qcom: Add TLMM DT node for APQ8084

 .../bindings/pinctrl/qcom,apq8084-pinctrl.txt      |  104 ++
 arch/arm/boot/dts/qcom-apq8084.dtsi                |   10 +
 drivers/pinctrl/qcom/Kconfig                       |    8 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-apq8084.c             | 1243 ++++++++++++++++++++
 5 files changed, 1366 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,apq8084-pinctrl.txt
 create mode 100644 drivers/pinctrl/qcom/pinctrl-apq8084.c

-- 
1.7.9.5
