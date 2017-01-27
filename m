From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu, 26 Jan 2017 16:47:23 -0800
Subject: [PATCH 0/5] Updated qcom dts for new USB driver
Message-ID: <20170127004728.22490-1-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches updates the existing usb chipidea bindings
for the newly merged usb driver. It allows us to move
away from the split ehci-msm and ci_hdrc_msm drivers, and unify
them with one chipidea driver.

I've left out HSIC, so it can be sent seperately.

Bird, Tim (1):
  ARM: dts: qcom: add charger otg regulator

Stephen Boyd (4):
  ARM: dts: qcom: Remove s4/5vs1,2 from RPM pm8941 control
  ARM: dts: qcom-msm8974: Add HS usb node and OTG detection mechanisms
  ARM: dts: qcom-apq8064: Collapse usb support into one node
  arm64: dts: qcom: Collapse usb support into one node

 .../arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts |  49 +++----
 arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts |  21 +--
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts        |  54 ++++---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts         |  54 ++++---
 .../arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts |  16 +--
 arch/arm/boot/dts/qcom-apq8064.dtsi                | 156 ++++++++++++---------
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts     |  20 +++
 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   |   1 -
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  53 ++++++-
 arch/arm/boot/dts/qcom-pm8941.dtsi                 |  36 ++++-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |  34 ++---
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  62 ++++----
 12 files changed, 321 insertions(+), 235 deletions(-)

-- 
2.10.0.297.gf6727b0
