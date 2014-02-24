From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon, 24 Feb 2014 18:07:47 +0100
Subject: [PATCH 0/2] ARM: dts: OMAP4: Add support for DuoVero/Parlor
Message-ID: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit, Tony,

Here is a device tree to support the OMAP4430-based Gumstix DuoVero
with the Parlor expansion boards. All peripherals should be working
with current 3.14-rc4, except:

- GPMC ethernet (needs patches [1])
- TWL6040 init may fail (will send a bug report to ML)
- The HDMI output depends on Tomi's DSS series [2] (not yet merged)

I split the HDMI part into a second patch, so it can be merged with the DSS
series, even if the nodes could be merged independently.

Regards,
Florian

[1] http://thread.gmane.org/gmane.linux.ports.arm.omap/110662
[2] http://thread.gmane.org/gmane.linux.ports.arm.kernel/295881


Florian Vaussard (2):
  ARM: dts: Add support for OMAP4 Gumstix DuoVero/Parlor
  ARM: dts: duovero-parlor: Add HDMI output

 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/omap4-duovero-parlor.dts         | 182 +++++++++++++++
 arch/arm/boot/dts/omap4-duovero.dtsi               | 252 +++++++++++++++++++++
 4 files changed, 438 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap4-duovero-parlor.dts
 create mode 100644 arch/arm/boot/dts/omap4-duovero.dtsi

-- 
1.8.1.2
