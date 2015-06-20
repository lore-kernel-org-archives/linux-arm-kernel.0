From: tremyfr@gmail.com (Philippe Reynes)
Date: Sat, 20 Jun 2015 19:12:34 +0200
Subject: [PATCH v3 0/6] add device tree support for mxc rtc
Message-ID: <1434820360-21935-1-git-send-email-tremyfr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serie add the device tree support for the mxc rtc driver.
To do this, three steps are required :
- define two rtc clocks for imx31 and imx35
- enhance mxc rtc driver to use two clocks (rtc and ipg)
- add device tree support to mxc rtc driver

Changelog:
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
  rtc: mxc: add support of device tree
  dt-binding: document the binding for mxc rtc
  apf27: dt: add support of internal rtc

 Documentation/devicetree/bindings/rtc/rtc-mxc.txt |   27 ++++++++++++
 arch/arm/boot/dts/imx27-apf27.dts                 |    4 ++
 arch/arm/boot/dts/imx27.dtsi                      |   10 +++++
 arch/arm/mach-imx/clk-imx31.c                     |    3 +-
 arch/arm/mach-imx/clk-imx35.c                     |    6 ++-
 drivers/rtc/rtc-mxc.c                             |   45 ++++++++++++++++-----
 6 files changed, 83 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mxc.txt

-- 
1.7.4.4
