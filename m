From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 31 Aug 2016 09:44:55 +0200
Subject: [GIT PULL] Integrator cleanups and DTS
Message-ID: <CACRpkdYBB0rw3uQZnmpsuc_=mf5Ra-HmbRfdm6aT0kn9rn41Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC people,

this is a request to pull a combined cleanup and DTS changes batch
for the Integrators.

Since I have commits such as "move CLCD display to DTS" that is
a single functional change deleting stuff from the boardfile and adding
the same to the DTS, it is a combination of DTS and boardfile patches.
All with the goal to cut down on boardfile code and move to device tree.

The changes require the corresponding changes from the video/fbdev
and clk subsystems to come in, but these are orthogonal and depend
solely on the DTS things coming in place. As the DTS repository is
"kind of external" I am deliverately relaxed about synchronizing changes
here and just optimistically assume they will come in during the merge
window and start working.

There are no compile-time dependencies on fbdev or clk, just runtime,
with the DT changes. This cleanup can be merged totally orthogonally,
and when ARM SoC, fbdev and clk are all merged in the merge window,
the result will compile and boot nicely.

I don't expect any conflicting changes to the Integrator in this merge
window, neither to board files nor DTS.

Please pull it in.

Yours,
Linus Walleij

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/integrator-armsoc-1

for you to fetch changes up to bdb249fce9ad44aab340be3b7a77060114f7193b:

  ARM: integrator: read counter using syscon/regmap (2016-08-31 09:30:34 +0200)

----------------------------------------------------------------
This is a bunch of Integrator changes for v4.9:

- Add and fix a bunch of clocks in the DTS corresponding
  to the new clock support merged into the clk tree.
- Move the CLCD display configuration from boardfile to
  device tree using the new CLCD support merged into the
  fbdev tree.
- Cut some auxdata.
- Cut some static remappings.
- Move the sched_clock() counter to use syscon+regmap.

----------------------------------------------------------------
Linus Walleij (8):
      ARM: dts: set the 24MHz xtal as parent of the UART clock
      ARM: dts: add the Integrator/AP baseboard clocks
      ARM: dts: Add the core module clocks to Integrator/AP
      ARM: dts: add the core module clocks to Integrator/CP
      ARM: integrator: move CP CLCD display to DTS
      ARM: integrator: delete some auxdata
      ARM: integrator: cut down on static maps
      ARM: integrator: read counter using syscon/regmap

 arch/arm/boot/dts/integratorap.dts       |  51 ++++++++++++-
 arch/arm/boot/dts/integratorcp.dts       |  74 ++++++++++++++++---
 arch/arm/mach-integrator/integrator_ap.c |  36 ---------
 arch/arm/mach-integrator/integrator_cp.c | 123 ++++---------------------------
 4 files changed, 126 insertions(+), 158 deletions(-)
