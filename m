From: narmstrong@baylibre.com (Neil Armstrong)
Date: Sat,  3 Sep 2016 14:53:44 +0200
Subject: [PATCH v4 0/2] ARM: dts: Add support for the MDM9615
Message-ID: <20160903125346.18451-1-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support the Qualcomm MDM9615 in the Sierra Wireless WP8548
Modules, add the MDM9615 DTSI and update its dt-bindings.

This patchset depends on pinctrl [merged], clk [merged], pmic [merged] and arm-soc [merged] patchsets.

This patchset is part of a global SoC + Module + Board support for the
Sierra Wireless mangOH Board support with the WP8548 module.

Changes since v3 at http://lkml.kernel.org/r/1471951850-29842-1-git-send-email-narmstrong at baylibre.com :
 - Cleanup interrupts types and masks

Changes since v2 at http://lkml.kernel.org/r/1471525661-2563-1-git-send-email-narmstrong at baylibre.com :
 - Cleanup interrupts types
 - Moved dummy regulator to "/regulators" node
 - Fixed ssbi mpp/gpio compatibles
 - Removed pinctrl syscon

Changes since v1 at : http://lkml.kernel.org/r/1466159704-22774-1-git-send-email-narmstrong at baylibre.com
 - Added cxo_board clock node
 - Added secondary pm8921 compatibles
 - Dropped corner regulator
 - Dropped USB nodes

Neil Armstrong (2):
  ARM: dts: Add MDM9615 dtsi
  dt-bindings: qcom: Add MDM9615 bindings

 Documentation/devicetree/bindings/arm/qcom.txt |   1 +
 arch/arm/boot/dts/qcom-mdm9615.dtsi            | 557 +++++++++++++++++++++++++
 2 files changed, 558 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-mdm9615.dtsi

-- 
2.7.0
