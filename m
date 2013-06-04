From: mturquette@linaro.org (Mike Turquette)
Date: Mon,  3 Jun 2013 23:39:15 -0700
Subject: [PATCH RFC 0/3] first pass converting omap4 clock data to DT
Message-ID: <1370327958-19776-1-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a very incomplete conversion of a handful of OMAP4 PRCM clocks
from the statically defined clock data in
arch/arm/mach-omap2/cclock44xx_data.c to a new dts file in
arch/arm/boot/dts/omap4-clocks.dtsi.

I am not a DT expert so many of the choices here may be quite disgusting
to look at, or may be on the right path.  In particular I simply include
the new omap4-clocks.dtsi from omap4.dtsi, which feels a bit kludgey.
Also this series depends on the basic clock bindings RFC I posted
earlier today[1].

I actually have an omap4-clock.dtsi file with many more clocks converted
to the mux-clock, divider-clock, fixed-clock, fixed-factor and
(unpublished) gate-clock bindings in my local repo, but it is not
currently booting.  I wanted to get this early preview out regardless.

[1] http://article.gmane.org/gmane.linux.kernel/1501216

Mike Turquette (3):
  clk: omap: introduce clock driver
  ARM: dts: omap4 clock data
  ARM: omap4: register DT clocks & remove old data

 arch/arm/boot/dts/omap4-clocks.dtsi   | 128 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi          |   2 +
 arch/arm/mach-omap2/cclock44xx_data.c |  54 ++------------
 drivers/clk/Makefile                  |   1 +
 drivers/clk/omap/Makefile             |   1 +
 drivers/clk/omap/clk.c                |  55 +++++++++++++++
 include/linux/clk/omap.h              |  24 +++++++
 7 files changed, 217 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap4-clocks.dtsi
 create mode 100644 drivers/clk/omap/Makefile
 create mode 100644 drivers/clk/omap/clk.c
 create mode 100644 include/linux/clk/omap.h

-- 
1.8.1.2
