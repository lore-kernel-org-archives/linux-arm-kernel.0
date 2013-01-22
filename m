From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Tue, 22 Jan 2013 03:12:53 -0300
Subject: [PATCH 0/3] clock driver for sunxi
Message-ID: <1358835176-7197-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

This patchset adds basic clock support for sunxi devices. Currently, it
implements support for the two oscillators, the main PLL, the CPU mux,
and its three divisor clocks. With this in place, it is possible to
write a cpufreq driver and have it work.

I have tested this driver successfully on a Cubieboard (A10, sun4i)
using the cpufreq driver from the linux-sunxi tree after minor
modifications (the clock names are not the same).

Any feedback will be highly appreciated

Thanks,

--
Emilio

Emilio L?pez (3):
  clk: arm: sunxi: Add a new clock driver for sunxi SOCs
  arm: sunxi: Add clock definitions for the new clock driver
  arm: sunxi: Add useful information about sunxi clocks

 Documentation/arm/sunxi/clocks.txt                |  56 +++++
 Documentation/devicetree/bindings/clock/sunxi.txt |  47 ++++
 arch/arm/boot/dts/sunxi.dtsi                      |  55 ++++-
 drivers/clk/Makefile                              |   2 +-
 drivers/clk/clk-sunxi.c                           |  30 ---
 drivers/clk/sunxi/Makefile                        |   5 +
 drivers/clk/sunxi/clk-factors.c                   | 175 ++++++++++++++
 drivers/clk/sunxi/clk-factors.h                   |  25 ++
 drivers/clk/sunxi/clk-fixed-gate.c                | 152 +++++++++++++
 drivers/clk/sunxi/clk-fixed-gate.h                |  13 ++
 drivers/clk/sunxi/clk-sunxi.c                     | 265 ++++++++++++++++++++++
 11 files changed, 788 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/arm/sunxi/clocks.txt
 create mode 100644 Documentation/devicetree/bindings/clock/sunxi.txt
 delete mode 100644 drivers/clk/clk-sunxi.c
 create mode 100644 drivers/clk/sunxi/Makefile
 create mode 100644 drivers/clk/sunxi/clk-factors.c
 create mode 100644 drivers/clk/sunxi/clk-factors.h
 create mode 100644 drivers/clk/sunxi/clk-fixed-gate.c
 create mode 100644 drivers/clk/sunxi/clk-fixed-gate.h
 create mode 100644 drivers/clk/sunxi/clk-sunxi.c

-- 
1.8.1.1
