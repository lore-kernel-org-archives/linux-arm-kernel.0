From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed,  9 Jan 2013 14:44:21 +0100
Subject: [PATCH 0/4] Add devicetree for MBa53 (was: Add devicetree for TQMA53
 embedded module)
Message-ID: <1357739065-9153-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I reworked my previous series, that was just for the SoC module, and added the
MBa53 base board for the TQMA53.
I threw out the usb support, as it does not work with current mainline.

Changes from previous series:
	- remove usb entries
	- add patch to select the debug uart on MBa53
	- add base board MBa53
	- add Makefile entry for imx53-MBa53.dtb
	- reformat DT


Regards,
Steffen


Philipp Zabel (1):
  ARM i.MX53: Add UART2 for low-level debugging

Sascha Hauer (1):
  ARM i.MX53: add dts for the TQ tqma53 module

Steffen Trumtrar (2):
  ARM: dts: imx53: pinctrl update
  ARM i.MX53: dts: add oftree for MBa53 baseboard

 arch/arm/Kconfig.debug              |   10 ++
 arch/arm/boot/dts/Makefile          |    1 +
 arch/arm/boot/dts/imx53-MBa53.dts   |  146 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx53-tqma53.dtsi |  176 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx53.dtsi        |   53 +++++++++++
 arch/arm/include/debug/imx.S        |    7 +-
 6 files changed, 392 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx53-MBa53.dts
 create mode 100644 arch/arm/boot/dts/imx53-tqma53.dtsi

-- 
1.7.10.4
