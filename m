From: marvin24@gmx.de (Marc Dietrich)
Date: Tue,  1 Nov 2011 21:37:02 +0100
Subject: [PATCH v4 0/3] paz00 updates for 3.3
Message-ID: <cover.1320173572.git.marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the following three patches are intended for the 3.3 merge window and are based
on linux-next.

The first one adds wakeup support similar to seaboard, but with the difference
that the wakeup gpio is connected to the embedded controller instead of a real
gpio key.

The second patch adds device tree support for the nvec driver. This way we can
make use of it without adding more platform devices to the board files (and it
is also modern to do so).

The final one adds device tree support for paz00. The way the nvec it is
initialized will probably change in the future, but we like to include it for
now as it makes debugging easier.

The patches are against linux-next from Nov 1st.

Thanks

Marc

Changes since v3
    - use of_property_read_u32 in nvec
    - also disable uart-e in the device tree

Changes since v2
    - remove the mem= from the bootargs, this is handled by the memory property
      already
    - change the root device until the sdhci init order can be changed
    - do not init unused serial ports
    - add dt documentation for nvec
    - remove CONFIG_OF #ifdefs from nvec.c
    - exchange the order of patch 2 and 3
Changes since v1
    - replace addition of the embedded controller to the board file by a device-tree
      based implementation.

Marc Dietrich (3):
  ARM: tegra: paz00: add support for wakeup gpio key
  staging: nvec: add device tree support
  arm/dt: tegra: add dts file for paz00

 .../devicetree/bindings/nvec/nvec_nvidia.txt       |    9 ++
 arch/arm/boot/dts/tegra-paz00.dts                  |   82 ++++++++++++++++++++
 arch/arm/mach-tegra/Makefile                       |    1 +
 arch/arm/mach-tegra/Makefile.boot                  |    1 +
 arch/arm/mach-tegra/board-dt.c                     |    3 +
 arch/arm/mach-tegra/board-paz00.c                  |   27 +++++++
 arch/arm/mach-tegra/board-paz00.h                  |    3 +
 drivers/staging/nvec/nvec.c                        |   30 +++++++-
 8 files changed, 154 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvec/nvec_nvidia.txt
 create mode 100644 arch/arm/boot/dts/tegra-paz00.dts

-- 
1.7.5.4
