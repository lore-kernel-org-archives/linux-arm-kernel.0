From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 17 Oct 2012 13:33:21 -0500
Subject: [PATCH 0/2] ARM: OMAP2+: Add device-tree support for 32kHz counter
Message-ID: <1350498803-22150-1-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds device-tree support for the 32kHz counter on OMAP2+ devices,
which is used as the default kernel clock-source for OMAP devices.

Boot tested on OMAP2420 H4, OMAP3430 Beagle Board and OMAP4430 Panda Board
with and without device-tree present.

Based and dependent upon OMAP2+ series that adds device-tree support for
DMTIMERs [1].

[1] http://marc.info/?l=linux-omap&m=135049690119218&w=2

Jon Hunter (2):
  ARM: dts: OMAP: Add counter-32k nodes
  ARM: OMAP2+: Add device-tree support for 32kHz counter

 .../devicetree/bindings/arm/omap/counter32k.txt    |   15 +++++++++++
 arch/arm/boot/dts/omap2420.dtsi                    |    6 +++++
 arch/arm/boot/dts/omap2430.dtsi                    |    6 +++++
 arch/arm/boot/dts/omap3.dtsi                       |    6 +++++
 arch/arm/boot/dts/omap4.dtsi                       |    6 +++++
 arch/arm/mach-omap2/timer.c                        |   28 +++++++++++++++++++-
 6 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/counter32k.txt

-- 
1.7.9.5
