From: tremyfr@gmail.com (Philippe Reynes)
Date: Sun, 26 Jul 2015 23:37:47 +0200
Subject: [PATCH v5 0/6] add device tree support for mxc rtc
Message-ID: <1437946673-7402-1-git-send-email-tremyfr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serie add the device tree support for the mxc rtc driver.
To do this, three steps are required :
- define two rtc clocks for imx31 and imx35
- enhance mxc rtc driver to use two clocks (ref and ipg)
- add device tree support to mxc rtc driver

Changelog:
v5: (thanks Shawn Guo, Rob Herring and Alexandre Belloni)
- rename rtc clock to ref
- fix typo in binding documentation
- enable rtc by default on imx27
v4: (thanks Alexandre Belloni)
- add prepare_clock for rtc clock
- split apf27: dt: enable support in two patches
v3: (thanks Fabio Estevam)
- fix typo in imx35 clock comment
v2: (thanks Shawn Guo and Alexandre Belloni)
- add a second clock to imx35
- split the add of clock in a separate patches
- split the dt documentation in a separate patch

Philippe Reynes (6):
  imx31: add a second rtc clock
  imx35: define two clocks for rtc
  rtc: mxc: use a second rtc clock
  dt-binding: document the binding for mxc rtc
  rtc: mxc: add support of device tree
  imx27: dt: add support of internal rtc

 Documentation/devicetree/bindings/rtc/rtc-mxc.txt |   26 +++++++++
 arch/arm/boot/dts/imx27.dtsi                      |    9 +++
 drivers/clk/imx/clk-imx31.c                       |    3 +-
 drivers/clk/imx/clk-imx35.c                       |    6 ++-
 drivers/rtc/rtc-mxc.c                             |   60 ++++++++++++++++-----
 5 files changed, 88 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mxc.txt

-- 
1.7.4.4
