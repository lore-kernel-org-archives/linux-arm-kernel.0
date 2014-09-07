From: info@lategoodbye.de (Stefan Wahren)
Date: Sun,  7 Sep 2014 13:37:46 +0200
Subject: [PATCH RFC 0/3] ARM: regulator: add Freescale MXS regulator driver
Message-ID: <1410089869-6611-1-git-send-email-info@lategoodbye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series draft should adds support for Freescale i.MX23, i.MX28 
on-chip regulators. I'm new to regulator drivers and need early feedback for 
the driver's stage before i go in the wrong direction.

The information about the i.MX28 regulators are from chapter 11 of the 
reference manual [1].

This driver based on the Freescale high level [2] and low level driver [3], 
but contains the following changes:

* devictree support
* code cleanup

Please bear in mind that the code is not tested against real hardware and 
it's not expected to work.

I'm not sure if it's correct, but these series based on the for-next branch
of Mark Brown's regulator repository.

Any comments about the code are welcome.

[1] - http://cache.freescale.com/files/dsp/doc/ref_manual/MCIMX28RM.pdf
[2] - http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/regulator/mxs-regulator.c?h=imx_2.6.35_maintain
[3] - http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/arch/arm/mach-mx28/power.c?h=imx_2.6.35_maintain

Stefan Wahren (3):
  DT: add binding for MXS regulator
  ARM: regulator: add Freescale MXS regulator driver
  DT: ARM: mxs: enable regulator support for i.MX28

 .../bindings/regulator/mxs-regulator.txt           |  38 ++
 arch/arm/boot/dts/imx28.dtsi                       |  50 ++-
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/mxs-regulator.c                  | 411 +++++++++++++++++++++
 5 files changed, 508 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mxs-regulator.txt
 create mode 100644 drivers/regulator/mxs-regulator.c

-- 
1.8.1.4
