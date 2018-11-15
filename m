From: pn@denx.de (Parthiban Nallathambi)
Date: Thu, 15 Nov 2018 13:47:43 +0100
Subject: [PATCH v7 0/5] Add Actions Semi S700 pinctrl support
Message-ID: <20181115124748.268286-1-pn@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds pinctrl support for Actions Semi S700 SoC.
Pinmux functions are only accessible for pin groups while pinconf
parameters are available for both pin groups and individual pins.

pinctrl driver is verified using the Cubieboard7.

common functionalities from s900 is moved for all Actions Semi
SoC's usage.
Common pad control configurations are moved to SoC specific

dts entry for pinctrl depends on clock driver which is still under review:
https://patchwork.kernel.org/patch/10533959/

Thanks,
Saravanan
Parthiban

Changelog in v2
- GPIO Interrupt support is added
- Device tree entry for GPIO and Interrupt configured
- GPIO and pinctrl define reorder, commit message findings fixed

depends on owl GPIO Interrupt support
https://patchwork.kernel.org/patch/10483477/

Chnagelog in v3
- Fixed 0-DAY bisectibility error

Chnagelog in v4
- Fixed 0-DAY sparse warnings on static declaration

Chnagelog in v5
- Rebase to mainline

Chnagelog in v6
- Rebase to 4.20-rc2 mainline
- Fixed nitpick findings in v5

Chnagelog in v7
- Fixed nitpick in dt-binding
- Rebase to current mainline

Saravanan Sekar (5):
  pinctrl: actions: define constructor generic to Actions Semi SoC's
  pinctrl: actions: define pad control configurtion to SoC specific
  dt-bindings: pinctrl: Add bindings for Actions Semi S700 SoC
  pinctrl: actions: Add Actions Semi S700 pinctrl driver
  arm64: dts: actions: Add pinctrl node for Actions Semi S700

 .../bindings/pinctrl/actions,s700-pinctrl.txt |  170 ++
 arch/arm64/boot/dts/actions/s700.dtsi         |   16 +
 drivers/pinctrl/actions/Kconfig               |    6 +
 drivers/pinctrl/actions/Makefile              |    1 +
 drivers/pinctrl/actions/pinctrl-owl.c         |   71 +-
 drivers/pinctrl/actions/pinctrl-owl.h         |  142 +-
 drivers/pinctrl/actions/pinctrl-s700.c        | 1912 +++++++++++++++++
 drivers/pinctrl/actions/pinctrl-s900.c        |  205 +-
 8 files changed, 2324 insertions(+), 199 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/actions,s700-pinctrl.txt
 create mode 100644 drivers/pinctrl/actions/pinctrl-s700.c

-- 
2.17.2
