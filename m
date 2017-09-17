From: hanetzer@startmail.com (Marty E. Plummer)
Date: Sun, 17 Sep 2017 03:23:24 -0500
Subject: [RFC RESEND 0/3] Add support for Hisilicon Hi3521A SoC
Message-ID: <20170917082327.10058-1-hanetzer@startmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

I'd like the community's feedback on the following patchset. I've attempted to
split my changes up in what I believe to be a sensible setup.

The device I'm working against is the 'SamsungSV SDR-B74301' HD CCTV surveillance
system, which uses a Hisilicon Hi3521A arm SoC as its basis.

Resending due to a typo, s/primcell/primecell/

Marty E. Plummer (3):
  clk: hisilicon: add CRG driver Hi3521A SoC
  arm: hisi: enable Hi3521A SoC
  arm: dts: add Hi3521A dts

 arch/arm/boot/dts/Makefile                |   2 +
 arch/arm/boot/dts/hi3521a-rs-dm290e.dts   |  52 +++++
 arch/arm/boot/dts/hi3521a.dtsi            | 310 ++++++++++++++++++++++++++++++
 arch/arm/mach-hisi/Kconfig                |   6 +
 drivers/clk/hisilicon/Kconfig             |   7 +
 drivers/clk/hisilicon/Makefile            |   1 +
 drivers/clk/hisilicon/crg-hi3521a.c       | 207 ++++++++++++++++++++
 include/dt-bindings/clock/hi3521a-clock.h |  34 ++++
 8 files changed, 619 insertions(+)
 create mode 100644 arch/arm/boot/dts/hi3521a-rs-dm290e.dts
 create mode 100644 arch/arm/boot/dts/hi3521a.dtsi
 create mode 100644 drivers/clk/hisilicon/crg-hi3521a.c
 create mode 100644 include/dt-bindings/clock/hi3521a-clock.h

-- 
2.14.1
