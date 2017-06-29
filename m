From: varada@codeaurora.org (Varadarajan Narayanan)
Date: Thu, 29 Jun 2017 11:48:30 +0530
Subject: [PATCH v7 0/4] Add minimal boot support for IPQ8074
Message-ID: <1498717114-338-1-git-send-email-varada@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v7:
    Remove the following clk related patches (Stephen Boyd has picked them)

    Incorporate Bjorn's comment in
	arm64: dts: Add ipq8074 SoC and HK01 board support

    Included Bjorn's and Rob's Ack for rest of the patches.

v6:
  * Include Rob's Ack to the first patch.

v5:
  * Removed the 'NA' binding from documentation

v4:
  * Split the clock patch and addressed a minor comment
    in the clock driver as per stephen's feedback.

v3:
  * Addressed review feedback from Bjorn for pinctrl
     - Unified the names for qpic pads.
     - Corrected the names for pwm pins.
  * Updated pinctrl documentation.
  * Updated the default bootargs in ipq8074-hk01.dts.
  * Updated the gcc clocks driver for removing the
    unused halt_bit in few places.

v2:
  * Addressed review feedback from Stephen
    - Removed cpu-map entries
    - Added mmio-timer nodes
  * Fix sparse warnings in the gcc-ipq8074.c
  * Updated pinctrl documentation

v1:
  https://www.spinics.net/lists/kernel/msg2498734.html
  This series adds minimal board boot support for ipq8074-hk01
  board.


Abhishek Sahu (1):
  arm64: defconfig: Enable qcom ipq8074 clock and pinctrl

Varadarajan Narayanan (3):
  pinctrl: qcom: Add ipq8074 pinctrl driver
  dt-bindings: qcom: Add ipq8074 bindings
  arm64: dts: Add ipq8074 SoC and HK01 board support

 Documentation/devicetree/bindings/arm/qcom.txt     |    2 +
 .../bindings/pinctrl/qcom,ipq8074-pinctrl.txt      |  172 ++++
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts          |   52 +
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              |  194 ++++
 arch/arm64/configs/defconfig                       |    2 +
 drivers/pinctrl/qcom/Kconfig                       |   10 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-ipq8074.c             | 1076 ++++++++++++++++++++
 9 files changed, 1510 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.txt
 create mode 100644 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq8074.dtsi
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq8074.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
