From: jian.hu@amlogic.com (Jian Hu)
Date: Fri, 10 Aug 2018 17:54:26 +0800
Subject: [PATCH 0/2] clk: meson-g12a: Add AO clock controller driver
Message-ID: <1533894868-85815-1-git-send-email-jian.hu@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a Clock driver for Always-On part of
the Amlogic Meson-G12A SoC.

-The patch depends on "clk: meson-g12a: Add EE clock controller driver" patch [1]
the parent clock of ao_clk81 is clk81 clock which provided in EE controller driver;
the file of Makefile modify based on EE controller driver patch.

[1]https://lkml.kernel.org/r/1533890858-113020-3-git-send-email-jian.hu at amlogic.com

Jian Hu (2):
  dt-bindings: clk: meson-g12a: Add G12A AO Clock Bindings
  clk: meson-g12a: Add AO Clock controller driver

 .../bindings/clock/amlogic,gxbb-aoclkc.txt         |   1 +
 drivers/clk/meson/Makefile                         |   2 +-
 drivers/clk/meson/g12a-aoclk.c                     | 170 +++++++++++++++++++++
 drivers/clk/meson/g12a-aoclk.h                     |  36 +++++
 include/dt-bindings/clock/g12a-aoclkc.h            |  28 ++++
 5 files changed, 236 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/meson/g12a-aoclk.c
 create mode 100644 drivers/clk/meson/g12a-aoclk.h
 create mode 100755 include/dt-bindings/clock/g12a-aoclkc.h

-- 
1.9.1
