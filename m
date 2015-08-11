From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 12 Aug 2015 00:42:30 +0800
Subject: [GIT PULL 2/3] ARM: imx: device tree changes for 4.3
In-Reply-To: <1439311351-5268-1-git-send-email-shawnguo@kernel.org>
References: <1439311351-5268-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1439311351-5268-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc maintainers,

This is the i.MX device tree updates for 4.3.  To resolve the dependency
between imx6ul clock driver and DTS files on those clock ID definitions,
the i.MX clock changes are pulled into the branch.  But since i.MX clock
drivers are now in drivers/clk/imx/ folder, I sent the clock changes to
Mike and Stephen.  I've already asked them to keep my clock branch
stable/non-reabasable.  So it should be safe pull this DT change set
into arm-soc.

Shawn

The following changes since commit 787b4271a6a0c09775241770782b22762f40bd6e:

  clk: imx: add imx6ul clk tree support (2015-07-14 15:02:13 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.3

for you to fetch changes up to 360325755336893869c419013ec0e33757432cbb:

  ARM: dts: imx6ul: add snvs power key support (2015-08-11 23:15:27 +0800)

----------------------------------------------------------------
The i.MX device tree updates for 4.3:
 - Add audio and eTSEC device support and update dspi node for LS1021A.
 - Add initial i.MX6UL and imx6ul-14x14-evk board support, and enable
   a bunch of device support for i.MX6UL, including RTC, power key, USB,
   QSPI, and dual FEC.
 - Enable HDMI and LVDS dual display support for a few imx6qdl boards.
 - Support of imx6sl-warp board rev1.12, the version which will be
   publicly available for the customers.
 - A few i.MX7D device additions, watchdog, cortex-a7 coresight
   components, RTC, power key, power off.
 - Some Vybrid updates: add device support for I2C, QSPI, eSDHC etc.,
   update ADC node, and define stdout-path property.
 - A few random updates for i.MX27 and i.MX53 devices.

----------------------------------------------------------------
Alison Wang (1):
      ARM: dts: ls1021a: Add dts nodes for audio on LS1021A

Anson Huang (4):
      ARM: dts: imx6sx: correct property name for wakeup source
      ARM: dts: imx6ul: enable GPC as extended interrupt controller
      ARM: dts: imx6ul: add RTC support
      ARM: dts: imx6ul: add snvs power key support

Claudiu Manoil (2):
      ARM: dts: ls1021a: Add the eTSEC controller nodes
      ARM: dts: ls1021a: Enable the eTSEC ports on QDS and TWR

Cory Tusar (4):
      ARM: dts: vf610: Extend I2C support to all available buses.
      ARM: dts: vf610: Add missing QuadSPI register mapping and names.
      ARM: dts: vfxxx: Include support for qspi1 functionality.
      ARM: dts: vfxxx: Include support for esdhc0 functionality.

Fabio Estevam (7):
      ARM: dts: imx6sl-warp: Add the SD2_RESET pin
      ARM: dts: imx6qdl-sabreauto: Add HDMI support
      ARM: dts: imx6qdl-sabresd: Allow HDMI and LVDS to work simultaneously
      ARM: dts: imx6sl-warp: Add changes for rev1.12
      ARM: dts: imx6qdl-sabrelite: Allow HDMI and LVDS to work simultaneously
      ARM: dts: imx6qdl-nitrogen6x: Allow HDMI and LVDS to work simultaneously
      ARM: dts: imx6qdl-sabreauto: Allow HDMI and LVDS to work simultaneously

Frank Li (11):
      ARM: dts: imx7d: add watch dog support
      ARM: dts: imx6sx: enable snvs power key
      ARM: dts: imx7d: add cortex-a7 coresight component
      Document: dt: binding: imx: update document for imx6ul support
      ARM: dts: add i.mx6ul pin function include file
      ARM: dts: imx: add imx6ul and imx6ul evk board support
      ARM: dts: imx: update snvs to use syscon access register
      ARM: dts: imx6ul: add usb host and function support
      ARM: dts: imx6ul: fix low case define in imx6ul-pinfunc.h
      ARM: dts: imx6ul: add qspi support
      ARM: dts: imx7d: enable snvs rtc, onoffkey and power off

Fugang Duan (2):
      ARM: dts: imx: add fec1 and fec2 nodes for SOC i.MX6UL
      ARM: dts: imx6ul-14x14-evk: add fec1 and fec2 support

Haikun Wang (1):
      ARM: dts: ls1021a: Update 'dspi' device node compatible string

Lucas Stach (1):
      ARM: dts: imx53-qsb: select open-drain mode for i2c1 pads

Peter Chen (1):
      ARM: imx6qdl-sabreauto.dtsi: enable USB support

Peter Seiderer (2):
      ARM: dts: nitrogen6x: add CAN support
      ARM: dts: sabrelite: add CAN support

Philippe Reynes (1):
      ARM: dts: imx27: add support of internal rtc

Sanchayan Maity (1):
      ARM: dts: vfxxx: Add io-channel-cells property for ADC node

Shengjiu Wang (1):
      ARM: dts: imx6qdl-sabreauto: Add audio support

Stefan Agner (2):
      ARM: dts: vf-colibri: define stdout-path property
      ARM: dts: add property for maximum ADC clock frequencies

Tim Harvey (1):
      ARM: dts: ventana: add UHS-I support for Ventana boards

 .../devicetree/bindings/clock/imx6ul-clock.txt     |  13 +
 .../bindings/pinctrl/fsl,imx6ul-pinctrl.txt        |  36 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/imx27.dtsi                       |   9 +
 arch/arm/boot/dts/imx53-qsb-common.dtsi            |   5 +-
 arch/arm/boot/dts/imx53-qsrb.dts                   |  14 +-
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              |   1 -
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |  35 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |  35 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |  34 +-
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi              |   1 -
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi              |   1 -
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |  39 +
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           | 137 +++
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |  39 +
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   7 +
 arch/arm/boot/dts/imx6qdl.dtsi                     |  52 +-
 arch/arm/boot/dts/imx6sl-warp.dts                  |  32 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |  21 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |  28 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dts             | 343 ++++++++
 arch/arm/boot/dts/imx6ul-pinfunc.h                 | 938 +++++++++++++++++++++
 arch/arm/boot/dts/imx6ul.dtsi                      | 707 ++++++++++++++++
 arch/arm/boot/dts/imx7d.dtsi                       | 260 +++++-
 arch/arm/boot/dts/ls1021a-qds.dts                  |  89 ++
 arch/arm/boot/dts/ls1021a-twr.dts                  |  81 ++
 arch/arm/boot/dts/ls1021a.dtsi                     | 106 ++-
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi          |   2 +-
 arch/arm/boot/dts/vfxxx.dtsi                       |  85 +-
 29 files changed, 3062 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx6ul-clock.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/imx6ul-14x14-evk.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imx6ul.dtsi
