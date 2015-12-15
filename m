From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 14 Dec 2015 23:30:42 -0600
Subject: [Patch v2 0/3] Add support for APQ8084 and MSM8916 Regulators
Message-ID: <1450157445-23723-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is a resend of part of the following series:

https://lkml.org/lkml/2015/9/24/561

This adds support for the PMA8084 regulators found on APQ8084 platforms
and the PM8916 regulators found on MSM8916 platforms.  This also adds in the
Documentation dependency required for the regulator patches.  This is a
standalone set of patches that can be taken as a whole.

Changes since v1:
- Added in Documentation dependency

Andy Gross (3):
  soc: qcom: documentation: Update SMD/RPM Docs
  regulator: qcom-smd: Add PM8916 support
  regulator: qcom-smd: Add support for PMA8084

 .../bindings/regulator/qcom,smd-rpm-regulator.txt  | 159 +++++++++++++++++++++
 .../devicetree/bindings/soc/qcom,smd-rpm.txt       | 117 ---------------
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.txt  |  58 ++++++++
 drivers/regulator/qcom_smd-regulator.c             | 159 +++++++++++++++++++++
 4 files changed, 376 insertions(+), 117 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
 delete mode 100644 Documentation/devicetree/bindings/soc/qcom,smd-rpm.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt

-- 
1.9.1
