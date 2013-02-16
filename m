From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 16 Feb 2013 15:46:03 -0500
Subject: [GIT PULL 4/4] ARM: mvebu: dt changes with deps for v3.9
Message-ID: <20130216204603.GK23237@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 836dc9e3fbbab0c30aa6e664417225f5c1fb1c39:

  Linux 3.8-rc7 (2013-02-09 08:20:39 +1100)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/dt_deps_for_v3.9

for you to fetch changes up to 5082d43000dcedd465059957026bfaef0d7f7cfb:

  Dove: Thermal: Add DT node and enable in defconfig (2013-02-16 19:07:16 +0000)

----------------------------------------------------------------
mvebu dt with deps for v3.9

This series of patches have external dependencies on driver maintainer trees.
If this pull request doesn't merge easily, let me know and I'll resend for
v3.10.

 - mvebu gpio expander for Mirabox
 - kirkwood cpufreq driver
 - thermal sensor for kirkwood and dove

depends on:
 - mvebu/dt
 - gpio/for-next up to 89f5df0
 - linux-pm/pm-cpufreq up to 2a4bd9f
 - thermal/next up to 74ffa64

----------------------------------------------------------------
Andrew Lunn (3):
      arm: kirkwood: Instantiate cpufreq driver
      arm: kirkwood: Enable cpufreq and ondemand on kirkwood_defconfig
      Dove: Thermal: Add DT node and enable in defconfig

Gregory CLEMENT (1):
      arm: mvebu: enable gpio expander over i2c on Mirabox platform

Jason Cooper (4):
      Merge branch 'mvebu/dt' into mvebu/dt_with_deps
      Merge up to commit '89f5df0' from gpio/for-next into mvebu/dt_deps
      Merge up to commit '2a4bd9f' from linux-pm/pm-cpufreq into
mvebu/dt_deps
      Merge up to commit '74ffa64' from thermal/next into mvebu/dt_deps

Nobuhiro Iwamatsu (1):
      ARM: Kirkwood: Add support thermal sensor for 88F6282 and 88F6283

5082d43 Dove: Thermal: Add DT node and enable in defconfig
 arch/arm/boot/dts/dove.dtsi     | 5 +++++
 arch/arm/configs/dove_defconfig | 2 ++
 2 files changed, 7 insertions(+)
2f3e409 ARM: Kirkwood: Add support thermal sensor for 88F6282 and 88F6283
 arch/arm/boot/dts/kirkwood-6282.dtsi | 6 ++++++
 arch/arm/configs/kirkwood_defconfig  | 2 ++
 2 files changed, 8 insertions(+)
0be2cc0 arm: kirkwood: Enable cpufreq and ondemand on kirkwood_defconfig
 arch/arm/configs/kirkwood_defconfig | 3 +++
 1 file changed, 3 insertions(+)
e3f202d arm: kirkwood: Instantiate cpufreq driver
 arch/arm/Kconfig                                  |  1 +
 arch/arm/boot/dts/kirkwood.dtsi                   | 13 +++++++++++++
 arch/arm/mach-kirkwood/board-dt.c                 |  2 ++
 arch/arm/mach-kirkwood/common.c                   | 23 +++++++++++++++++++++++
 arch/arm/mach-kirkwood/common.h                   |  2 ++
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |  2 ++
 6 files changed, 43 insertions(+)
9a16f9a arm: mvebu: enable gpio expander over i2c on Mirabox platform
 arch/arm/boot/dts/armada-370-mirabox.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

The above was built with 'git log --oneline --stat --summary --no-merges
--first-parent v3.8-rc7..tags/dt_deps_for_v3.9'.  It's not perfect, but
it handles the merges better than anything else I've tried.  Ideas
welcomed.

thx,

Jason.
