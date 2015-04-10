From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 10 Apr 2015 13:33:07 +0100
Subject: [PATCH v2 00/12] ARM: dts: apq8064 dt patches
In-Reply-To: <1428567674-10672-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1428567674-10672-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1428669187-10775-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks all for reviewing v1 patches.

Hi Kumar, 

Now that the rpm redesign dependency is resolved, If its not too late could you
queue these dt patches for v4.1-rc1 or v4.1-rc2.

I tested these patches on APQ8064 based IFC6410 and CMQS600 board with SATA/USB/HDMI.
I also rebased these patches on top of your qcom/dt branch.

Thanks,
srini

Changes since v1
 * Made regulators board specific, as suggested by Bjorn.
 * Used correct IRQF flags for rpm, spotted by Bjorn.
 * Fixed serial lable to be more appropriate, spotted by Bjorn.

Nicolas Dechesne (2):
  ARM: dts: apq8064: Add usb host support to CM QS-600
  ARM: dts: apq8064: Add USB OTG support for CM QS-600

Pramod Gurav (1):
  ARM: dts: apq8064-ifc6410: Add DT alias for serial port

Rob Clark (1):
  ARM: dts: apq8064: Add MDP support

Srinivas Kandagatla (8):
  ARM: dts: apq8064: add RPM regulators support
  ARM: dts: apq8064-ifc6410: Add basic regulators
  ARM: dts: apq8064: Add usb host support.
  ARM: dts: apq8064: Add USB OTG support
  ARM: dts: apq8064: Add SATA controller support.
  ARM: dts: apq8064-cm-qs600: Add basic regulators.
  ARM: dts: apq8064: Move i2c1 pinctrl to apq8064.dtsi
  ARM: dts: apq8064: add i2c3 node for panel.

 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 100 ++++++++++
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts  | 136 +++++++++++++-
 arch/arm/boot/dts/qcom-apq8064.dtsi         | 280 +++++++++++++++++++++++++++-
 3 files changed, 507 insertions(+), 9 deletions(-)

-- 
1.9.1
