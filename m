From: agross@codeaurora.org (Andy Gross)
Date: Tue, 13 Oct 2015 16:50:33 -0500
Subject: [GIT PULL] qcom dt changes for 4.4
Message-ID: <1444773033-24532-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git at git.codeaurora.org:quic/kernel/agross-msm.git tags/qcom-dt-for-4.4

for you to fetch changes up to 04edde250c3753798475f0a4dc0275dd52f707bd:

  ARM: dts: msm8974: fix typo in "disabled" property (2015-10-13 16:40:03 -0500)

----------------------------------------------------------------
Qualcomm ARM Based Device Tree Updates for v4.4

* Add DT binding document for SMEM
* Add SMD, RPM, and Regulator nodes on MSM8974
* Remove extra reg element from iadc device
* Remove redunandant i2c pinctrl properties on APQ8064
* Remove unnecessary eeprom label on IFC6410
* Remove unnecessary eeprom label from QS600
* Add PM8921 RTC support on APQ8064
* Add PM8921 pwrkey support on APQ8064
* Prefix GSBI6 uart pins on APQ8064 correctly
* Add missing GSBI7 uart pinctrl on APQ8064
* Add missing GSBI7 uart pinctrl on IFC6410
* Add missing GSBI7 pinctrl uart property on QS600
* Add pwrseq support for WLAN on IFC6410
* Add pwrseq support for WLAN on QS600
* Add notify led support on IFC6410
* Add SD card detect support onQS600
* Add #power-domain-cells property to documentation
* Add Qualcomm SMBB binding document
* Add PM8941 charge node
* Fix typo in disabled property on MSM8974

----------------------------------------------------------------
Bjorn Andersson (2):
      soc: qcom: Add device tree binding for SMEM
      ARM: dts: msm8974: Add smd, rpm and regulator nodes

Courtney Cavin (2):
      dt-binding: power: Add Qualcomm SMBB binding
      ARM: dts: qcom-pm8941: Add charger node

Michael Opdenacker (1):
      ARM: dts: msm8974: fix typo in "disabled" property

Rajendra Nayak (1):
      arm: dts: qcom: Add #power-domain-cells property

Srinivas Kandagatla (13):
      ARM: dts: apq8064: remove redundant i2c pinctrl properties
      ARM: dts: ifc6410: remove unnecessary eeprom label
      ARM: dts: qs600: remove unnecessary eeprom label
      ARM: dts: apq8064: add pm8921 rtc
      ARM: dts: apq8064: add pm8921 pwrkey support
      ARM: dts: apq8064: Prefix the gsbi6 uart pins correctly
      ARM: dts: apq8064: add missing gsbi7 uart pinctrl
      ARM: dts: ifc6410: Add missing pinctrl to gsbi7 uart
      ARM: dts: qs600: Add missing pinctrl property for gsbi7 uart
      ARM: dts: ifc6410: Add pwrseq support for WLAN
      ARM: dts: qs600: add pwrseq support to WLAN
      ARM: dts: apq8064-ifc6410: add notify led support.
      ARM: dts: qs600: Add SD card detect support.

Stephen Boyd (1):
      ARM: dts: qcom: Remove extra reg element from iadc device

 .../devicetree/bindings/clock/qcom,gcc.txt         |    4 +
 .../devicetree/bindings/clock/qcom,mmcc.txt        |    4 +
 .../devicetree/bindings/power_supply/qcom_smbb.txt |  131 ++++++++++++++++++++
 .../devicetree/bindings/soc/qcom/qcom,smem.txt     |   57 +++++++++
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts        |   48 ++++++-
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts         |   60 +++++++--
 arch/arm/boot/dts/qcom-apq8064.dtsi                |   43 ++++++-
 arch/arm/boot/dts/qcom-apq8084.dtsi                |    1 +
 arch/arm/boot/dts/qcom-msm8974.dtsi                |   78 +++++++++++-
 arch/arm/boot/dts/qcom-pm8941.dtsi                 |   24 +++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |    1 +
 11 files changed, 434 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power_supply/qcom_smbb.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smem.txt
