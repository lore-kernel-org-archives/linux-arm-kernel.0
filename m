From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 25 Jan 2011 21:44:01 -0700
Subject: [RFC PATCH 0/5] arm/dt: register devices from device tree
Message-ID: <20110126043338.16410.75019.stgit@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

For right now this is only an early implementation and there are
several bugs that prevent all devices from getting registered
correctly, and not all of the dts data is accurate.  However, it
starts to show what a device-tree enabled machine_desc looks like
using the versatile platform as an example, and I wanted to get it out
for people to see.

A significant change in this series compared with the previous version
is that the devicetree clock lookup code has been decoupled from the
common struct clk patches that Jeremy is currently working on.  This
means that there is more machine-specific code than there needs to be
for handling clocks, but it can be removed after a common struct clk
is merged.

This series is based on:

    git://git.secretlab.ca/git/linux-2.6  devicetree/arm

g.

---

Grant Likely (2):
      arm/dt: Add dt machine definition
      arm/versatile: add a device tree versatile platform

Jeremy Kerr (3):
      drivers/amba: probe via device tree
      of: add clock providers
      arm/clkdev: lookup clocks from OF clock providers


 arch/arm/boot/dts/versatile.dts        |  138 ++++++++++++++++++++++++++++++++
 arch/arm/include/asm/mach/arch.h       |    9 ++
 arch/arm/mach-versatile/Kconfig        |    8 ++
 arch/arm/mach-versatile/Makefile       |    1 
 arch/arm/mach-versatile/versatile_ab.c |    6 -
 arch/arm/mach-versatile/versatile_dt.c |  108 +++++++++++++++++++++++++
 arch/arm/mach-versatile/versatile_pb.c |    6 -
 arch/arm/plat-versatile/clock.c        |    2 
 drivers/amba/bus.c                     |   67 ++++++++++++++++
 drivers/clk/clkdev.c                   |    7 ++
 drivers/of/Kconfig                     |    5 +
 drivers/of/Makefile                    |    1 
 drivers/of/clock.c                     |  133 +++++++++++++++++++++++++++++++
 include/linux/amba/bus.h               |    5 +
 include/linux/of_clk.h                 |   36 ++++++++
 15 files changed, 520 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/boot/dts/versatile.dts
 create mode 100644 arch/arm/mach-versatile/versatile_dt.c
 create mode 100644 drivers/of/clock.c
 create mode 100644 include/linux/of_clk.h

-- 
Signature
