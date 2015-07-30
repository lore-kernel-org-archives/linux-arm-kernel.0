From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 31 Jul 2015 00:24:18 +0200
Subject: [PATCH 0/9] LPC18xx DTS changes for 4.3 part2
Message-ID: <1438295067-24407-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is some more LPC18xx dts changes for v4.3. This is the dts
changes for the drivers that will go in for v4.3. Note that the
USB phy driver is not in next yet, but is queued on Kishon's phy
next repo.

Changes include:

 - Add USB OTG phy, PL111 LCD controller and PL172 memory
   controller nodes to lpc18xx.dtsi

 - Enable USB0 on EA4357 Dev Kit

 - Add static memory devices on EA4357 Dev Kit

 - Enable UART0 pinmux and Ethernet on Hitex Eval Board
   from Ariel D'Alessandro

 - Add static memory devices on Hitex Eval Board

Changes are also available in the git repository at:

  https://github.com/manabian/linux-lpc.git tags/lpc18xx_dts_for_4.3-part2


Ariel D'Alessandro (2):
  ARM: dts: lpc4350-hitex-eval: add pinctrl and uart0 muxing
  ARM: dts: lpc4350-hitex-eval: add ethernet

Joachim Eastwood (7):
  ARM: dts: lpc18xx: add usb otg phy node
  ARM: dts: lpc18xx: add pl111 lcd controller node
  ARM: dts: lpc18xx: add pl172 memory-controller node
  ARM: dts: lpc4357-ea4357: add usb0
  ARM: dts: lpc4357-ea4357: add emc pins and static memory devices
  ARM: dts: lpc4357-ea4357: add mmio-gpio leds
  ARM: dts: lpc4350-hitex-eval: add emc pins and static memory devices

 arch/arm/boot/dts/lpc18xx.dtsi              |  32 ++++
 arch/arm/boot/dts/lpc4350-hitex-eval.dts    | 244 +++++++++++++++++++++++++++
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts | 253 ++++++++++++++++++++++++++++
 3 files changed, 529 insertions(+)

-- 
1.8.0
