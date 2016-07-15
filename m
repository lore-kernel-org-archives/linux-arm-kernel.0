From: njaigane@codeaurora.org (njaigane at codeaurora.org)
Date: Fri, 15 Jul 2016 12:26:50 +0530
Subject: [PATCH 0/4] Qualcomm IPQ4019 Audio driver addition
Message-ID: <1468565811-18654-1-git-send-email-njaigane@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaiganesh Narayanan <njaigane@codeaurora.org>

These patches add the support for Qualcomm IPQ4019 ASoC
with the ALSA based audio drivers. The patches are broken

1. Device Tree support
2. Audio clock driver support
3. TLMM / Pinctrl support
4. ALSA audio drivers

Jaiganesh Narayanan (4):
  qcom: ipq4019: Add ipq4019 ASoC device tree changes
  qcom: ipq4019: ASoC clock driver support
  qcom: ipq4019: ASoC tlmm/pinctrl support
  qcom: ipq4019: Add ASoC driver modules

 .../bindings/sound/qca,ipq4019-audio-adss.txt      |  20 +
 .../bindings/sound/qca,ipq4019-audio.txt           |  13 +
 .../bindings/sound/qca,ipq4019-codec.txt           |  15 +
 .../devicetree/bindings/sound/qca,ipq4019-i2s.txt  |  33 +
 .../devicetree/bindings/sound/qca,ipq4019-i2s1.txt |  29 +
 .../devicetree/bindings/sound/qca,ipq4019-i2s2.txt |  29 +
 .../devicetree/bindings/sound/qca,ipq4019-mbox.txt |  23 +
 .../bindings/sound/qca,ipq4019-pcm-i2s.txt         |  15 +
 .../bindings/sound/qca,ipq4019-pcm-i2s1.txt        |  15 +
 .../bindings/sound/qca,ipq4019-pcm-i2s2.txt        |  15 +
 .../bindings/sound/qca,ipq4019-pcm-spdif.txt       |  15 +
 .../bindings/sound/qca,ipq4019-pcm-tdm.txt         |  15 +
 .../bindings/sound/qca,ipq4019-spdif.txt           |  35 +
 .../bindings/sound/qca,ipq4019-stereo.txt          |  17 +
 .../devicetree/bindings/sound/qca,ipq4019-tdm.txt  |  33 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi      | 195 ++++-
 arch/arm/boot/dts/qcom-ipq4019.dtsi                | 247 +++++-
 drivers/clk/qcom/Kconfig                           |   8 +
 drivers/clk/qcom/Makefile                          |   2 +
 drivers/clk/qcom/adcc-ipq4019.c                    | 700 +++++++++++++++++
 drivers/clk/qcom/clk-qcapll.c                      | 197 +++++
 drivers/clk/qcom/clk-qcapll.h                      |  60 ++
 drivers/clk/qcom/clk-rcg.h                         |  68 +-
 drivers/clk/qcom/clk-rcg2.c                        | 699 ++++++++++++++++-
 drivers/clk/qcom/common.c                          |   9 +-
 drivers/clk/qcom/common.h                          |   3 +-
 drivers/pinctrl/qcom/pinctrl-ipq4019.c             | 116 ++-
 include/dt-bindings/clock/qca,adcc-ipq4019.h       |  45 ++
 include/dt-bindings/clock/qcom,gcc-ipq4019.h       |   4 +-
 include/dt-bindings/sound/ipq4019-audio.h          |  37 +
 sound/soc/qcom/Kconfig                             |  47 ++
 sound/soc/qcom/Makefile                            |   1 +
 sound/soc/qcom/ipq4019/Makefile                    |  16 +
 sound/soc/qcom/ipq4019/ipq4019-adss.c              | 407 ++++++++++
 sound/soc/qcom/ipq4019/ipq4019-adss.h              | 432 +++++++++++
 sound/soc/qcom/ipq4019/ipq4019-codec.c             | 475 ++++++++++++
 sound/soc/qcom/ipq4019/ipq4019-codec.h             |  91 +++
 sound/soc/qcom/ipq4019/ipq4019-cpu-dai.c           | 687 +++++++++++++++++
 sound/soc/qcom/ipq4019/ipq4019-mbox.c              | 825 +++++++++++++++++++++
 sound/soc/qcom/ipq4019/ipq4019-mbox.h              | 146 ++++
 sound/soc/qcom/ipq4019/ipq4019-pcm-i2s.c           | 609 +++++++++++++++
 sound/soc/qcom/ipq4019/ipq4019-pcm-spdif.c         | 664 +++++++++++++++++
 sound/soc/qcom/ipq4019/ipq4019-pcm-tdm.c           | 609 +++++++++++++++
 sound/soc/qcom/ipq4019/ipq4019-pcm.h               |  37 +
 sound/soc/qcom/ipq4019/ipq4019-stereo.c            | 313 ++++++++
 sound/soc/qcom/ipq4019/ipq4019.c                   | 121 +++
 46 files changed, 8135 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-audio-adss.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-codec.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-i2s1.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-i2s2.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-mbox.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-i2s1.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-i2s2.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-tdm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-stereo.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-tdm.txt
 create mode 100644 drivers/clk/qcom/adcc-ipq4019.c
 create mode 100644 drivers/clk/qcom/clk-qcapll.c
 create mode 100644 drivers/clk/qcom/clk-qcapll.h
 create mode 100644 include/dt-bindings/clock/qca,adcc-ipq4019.h
 create mode 100644 include/dt-bindings/sound/ipq4019-audio.h
 create mode 100644 sound/soc/qcom/ipq4019/Makefile
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-adss.c
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-adss.h
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-codec.c
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-codec.h
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-cpu-dai.c
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-mbox.c
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-mbox.h
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-pcm-i2s.c
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-pcm-spdif.c
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-pcm-tdm.c
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-pcm.h
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-stereo.c
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
