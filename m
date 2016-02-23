From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 23 Feb 2016 16:49:13 +0000
Subject: [PATCH v3 0/8] arm64: dts: apq8016 dt patches (Set2).
Message-ID: <1456246153-18087-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy, 

Here are few more dt patches (set2) which enables usb and lpass,
with some fixes. I have tested these patches with few changes
to defconfig on DB410C + a usb phy fix.

Thanks,
srini

Changes since v2:
 - fixed usb and usb-id pinctrl nodes as suggested by Bjorn

Changes since v1:
 - moved usb usb2513 and usb_id nodes out of soc
 as suggested by Stephen Boyd.
 - fixed lpass node name, spotted by Stephen Boyd.
 - added new patch to enable bam dma
 - added a fix from Ivan on led mpp pins.


Ivan T. Ivanov (1):
  arm64: dts: qcom: Fix MPP's function used for LED control

Srinivas Kandagatla (7):
  arm64: dts: qcom: add manual pullup setting to otg.
  arm64: dts: qcom: apq8016-sbc: add usb support
  arm64: dts: qcom: add audio pinctrls
  arm64: dts: qcom: add lpass node
  arm64: dts: qcom: apq8016-sbc: enable lpass on DB410c
  arm64: dts: qcom: fix usb digital voltage levels
  arm64: dts: qcom: apq8016-sbc: enable bam dma node.

 .../arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi |   2 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi |  14 ++
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |  42 ++++
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi         | 216 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  29 ++-
 5 files changed, 301 insertions(+), 2 deletions(-)

-- 
1.9.1
