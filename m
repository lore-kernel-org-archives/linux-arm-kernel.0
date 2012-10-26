From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 26 Oct 2012 18:10:39 +0100
Subject: [GIT PULL] vexpress: soc changes for v3.8
In-Reply-To: <201210261700.52195.arnd@arndb.de>
References: <1350579917.4984.19.camel@hornet>
 <201210261645.00157.arnd@arndb.de> <1351270481.9454.34.camel@hornet>
 <201210261700.52195.arnd@arndb.de>
Message-ID: <1351271439.9454.36.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-10-26 at 18:00 +0100, Arnd Bergmann wrote:
> Right, it works in -next. Can you rebase the soc changes on top of the
> stuff that went into Mike's tree and resubmit so it also builds in
> arm-soc?

Sure (if I understood you correctly ;-)

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.linaro.org/people/pawelmoll/linux.git vexpress-clk-soc

for you to fetch changes up to 60b3bee64022489ef66a4f56284ccf68b29bd7a9:

  ARM: vexpress: Remove motherboard dependencies in the DTS files (2012-10-26 18:06:11 +0100)

----------------------------------------------------------------
Pawel Moll (7):
      clk: Versatile Express clock generators ("osc") driver
      clk: Common clocks implementation for Versatile Express
      mfd: Versatile Express config infrastructure
      mfd: Versatile Express system registers driver
      ARM: vexpress: Add config bus components and clocks to DTs
      ARM: vexpress: Start using new Versatile Express infrastructure
      ARM: vexpress: Remove motherboard dependencies in the DTS files

 .../devicetree/bindings/arm/vexpress-sysreg.txt    |   50 ++
 Documentation/devicetree/bindings/arm/vexpress.txt |   98 +++-
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi            |  146 +++++-
 arch/arm/boot/dts/vexpress-v2m.dtsi                |  146 +++++-
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts        |  121 ++++-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |  186 ++++++-
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts            |   84 ++-
 arch/arm/boot/dts/vexpress-v2p-ca9.dts             |  136 ++++-
 arch/arm/include/asm/hardware/sp810.h              |    6 +-
 arch/arm/mach-vexpress/Kconfig                     |    4 +-
 arch/arm/mach-vexpress/Makefile                    |    2 +-
 arch/arm/mach-vexpress/ct-ca9x4.c                  |   41 +-
 arch/arm/mach-vexpress/include/mach/motherboard.h  |   81 ---
 arch/arm/mach-vexpress/platsmp.c                   |    3 +-
 arch/arm/mach-vexpress/v2m.c                       |  349 ++++---------
 drivers/clk/Kconfig                                |    8 +-
 drivers/clk/versatile/Makefile                     |    2 +
 drivers/clk/versatile/clk-vexpress-osc.c           |  150 ++++++
 drivers/clk/versatile/clk-vexpress.c               |  142 +++++
 drivers/mfd/Kconfig                                |    6 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/vexpress-config.c                      |  277 ++++++++++
 drivers/mfd/vexpress-sysreg.c                      |  552 ++++++++++++++++++++
 include/linux/vexpress.h                           |  121 +++++
 24 files changed, 2293 insertions(+), 419 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vexpress-sysreg.txt
 create mode 100644 drivers/clk/versatile/clk-vexpress-osc.c
 create mode 100644 drivers/clk/versatile/clk-vexpress.c
 create mode 100644 drivers/mfd/vexpress-config.c
 create mode 100644 drivers/mfd/vexpress-sysreg.c
 create mode 100644 include/linux/vexpress.h
