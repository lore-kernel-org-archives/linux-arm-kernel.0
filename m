From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri, 10 Jan 2014 13:52:57 +0100
Subject: [PATCH 0/2] ARM: i.MX53: add support for MCIMX53-START-R
Message-ID: <1389358379-26196-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

The START-R is almost the same as the START (aka qsb), but has a different
pmic.

To support both, this series moves the common nodes to a new dtsi and has only
the pmic nodes with their respective i2c1 pinctrl in the dts.
Patch 2/2 is based on earlier work from Paul Liu.

The series is rebased to the tag imx-dt-3.14 on Shawns tree.

Regards,
Steffen

Steffen Trumtrar (2):
  ARM: i.MX53: dts: move common QSB nodes to new file
  ARM: i.MX53: dts: add support for MCIMX53-START-R

 arch/arm/boot/dts/Makefile                         |   1 +
 .../dts/{imx53-qsb.dts => imx53-qsb-common.dtsi}   |  98 --------
 arch/arm/boot/dts/imx53-qsb.dts                    | 249 +--------------------
 arch/arm/boot/dts/imx53-qsrb.dts                   | 158 +++++++++++++
 4 files changed, 160 insertions(+), 346 deletions(-)
 copy arch/arm/boot/dts/{imx53-qsb.dts => imx53-qsb-common.dtsi} (69%)
 create mode 100644 arch/arm/boot/dts/imx53-qsrb.dts

-- 
1.8.5.2
