From: tony@atomide.com (Tony Lindgren)
Date: Thu, 30 Oct 2014 09:50:20 -0700
Subject: [GIT PULL] omap fixes against v3.18-rc2
Message-ID: <20141030165019.GA31454@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit cac7f2429872d3733dc3f9915857b1691da2eb2f:

  Linux 3.18-rc2 (2014-10-26 16:48:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/fixes-against-v3.18-rc2

for you to fetch changes up to 4b91f7f3c8b20e073b7bfc098625b37f99789508:

  ARM: OMAP2+: Warn about deprecated legacy booting mode (2014-10-29 12:19:20 -0700)

----------------------------------------------------------------
Few fixes for omaps to enable NAND BCH so devices won't
produce errors when booted with omap2plus_defconfig, and
reduce bloat by making IPV6 a loadable module.

Also let's add a warning about legacy boot being deprecated
for omap3.

We now have things working with device tree, and only omap3 is
still booting in legacy mode. So hopefully this warning will
help move the remaining legacy mode users to boot with device
tree.

As the total reduction of code and static data is somewhere
around 20000 lines of code once we remove omap3 legacy mode
booting, we really do want to make omap3 to boot also in
device tree mode only over the next few merge cycles.

----------------------------------------------------------------
Tony Lindgren (3):
      ARM: omap2plus_defconfig: Fix bloat caused by having ipv6 built-in
      ARM: omap2plus_defconfig: Fix errors with NAND BCH
      ARM: OMAP2+: Warn about deprecated legacy booting mode

 arch/arm/configs/omap2plus_defconfig | 4 ++--
 arch/arm/mach-omap2/omap_device.c    | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)
