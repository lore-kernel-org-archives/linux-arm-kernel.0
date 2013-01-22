From: tony@atomide.com (Tony Lindgren)
Date: Tue, 22 Jan 2013 11:18:02 -0800
Subject: [GIT PULL] omap fixes for v3.8-rc4
Message-ID: <20130122191801.GQ22517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7d1f9aeff1ee4a20b1aeb377dd0f579fe9647619:

  Linux 3.8-rc4 (2013-01-17 19:25:45 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8-rc4/fixes-signed

for you to fetch changes up to 7662a9c60fee25d7234da4be6d8eab2b2ac88448:

  ARM: OMAP2+: omap4-panda: add UART2 muxing for WiLink shared transport (2013-01-21 10:39:53 -0800)

----------------------------------------------------------------
Minimal omap fixes for the -rc series:

- A build fix for recently merged omap DRM changes

- Regression fixes from the common clock framework conversion
  for omap4 audio and omap2 reboot

- Regression fix for pandaboard WLAN control UART muxing caused by
  u-boot only muxing essential pins nowadays

- Timer iteration fix for CONFIG_OF_DYNAMIC

- A section mismatch fix for ocp2scp init

----------------------------------------------------------------
Jon Hunter (1):
      ARM: OMAP2: Fix missing omap2xxx_clkt_vps_late_init function calls

Luciano Coelho (1):
      ARM: OMAP2+: omap4-panda: add UART2 muxing for WiLink shared transport

Pantelis Antoniou (1):
      ARM: OMAP2+: DT node Timer iteration fix

Peter Ujfalusi (2):
      ARM: OMAP4: clock data: Lock ABE DPLL on all revisions
      ARM: OMAP4: hwmod_data: Correct IDLEMODE for McPDM

Rob Clark (1):
      ARM: OMAP2+: fix build break for omapdrm

Tony Lindgren (2):
      Merge tag 'omap-fixes-b-for-v3.8-rc' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.8-rc4/fixes
      ARM: OMAP2+: Fix section warning for omap_init_ocp2scp()

 arch/arm/mach-omap2/board-omap4panda.c     |  6 ++++++
 arch/arm/mach-omap2/cclock2420_data.c      |  2 ++
 arch/arm/mach-omap2/cclock2430_data.c      |  2 ++
 arch/arm/mach-omap2/cclock44xx_data.c      | 13 ++++++-------
 arch/arm/mach-omap2/devices.c              |  2 +-
 arch/arm/mach-omap2/drm.c                  |  3 ++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  6 +++++-
 arch/arm/mach-omap2/timer.c                |  8 ++------
 8 files changed, 26 insertions(+), 16 deletions(-)
