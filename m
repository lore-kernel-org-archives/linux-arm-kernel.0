From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 20 Nov 2014 20:14:34 +0000
Subject: [PATCH RFC 0/3] power: mxs_power: add driver for mxs power subsystem
Message-ID: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for Freescale i.MX23, i.xM28 power subsystem.

The idea for this driver was born in the discussion with Mark Rutland
about the mxs-regulator driver [1].

The main use is to trigger driver probing of the underlying DT child nodes
like on-chip regulators. But it's also the first step for cpufreq-dt support.

[1] - https://lkml.org/lkml/2014/9/29/283

Stefan Wahren (3):
  DT: add binding for mxs power subsystem
  power: mxs_power: add driver for mxs power subsystem
  ARM: dts: enable power subsystem for i.MX28

 .../devicetree/bindings/power/mxs_power.txt        |   23 ++
 arch/arm/boot/dts/imx28.dtsi                       |    6 +-
 drivers/power/Kconfig                              |    8 +
 drivers/power/Makefile                             |    1 +
 drivers/power/mxs_power.c                          |  226 ++++++++++++++++++++
 5 files changed, 263 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/power/mxs_power.txt
 create mode 100644 drivers/power/mxs_power.c

--
1.7.9.5
