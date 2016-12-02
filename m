From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 Dec 2016 22:22:44 +0100
Subject: [GIT PULL] ARM: SoC fixes for v4.9
Message-ID: <2721179.8qhQrQsmQ2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 9c763584b7c8911106bb77af7e648bef09af9d80:

  Linux 4.9-rc6 (2016-11-20 13:52:19 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 909e481e2467f202b97d42beef246e8829416a85:

  arm64: dts: juno: fix cluster sleep state entry latency on all SoC versions (2016-12-02 17:28:17 +0100)

----------------------------------------------------------------
ARM: SoC fixes for v4.9

This should be the last set of bugfixes for arm-soc in v4.9.
None of these are critical regressions, but it would be nice
to still get them merged.

- On the Juno platform, the idle latency was described wrong,
  leading to suboptimal cpuidle tuning.

- Also on the same platform, PCI I/O space was set up incorrectly
  and could not work.

- On the sti platform, a syntactically incorrect DT entry caused
  warnings.

- The newly added 'gr8' platform has somewhat confusing file
  names, which we rename for consistency.

----------------------------------------------------------------
Arnd Bergmann (2):
      Merge tag 'sunxi-fixes-for-4.9-2' of https://git.kernel.org/.../mripard/linux into fixes
      Merge tag 'sti-dt-for-v4.9-rc-round2' of git://git.kernel.org/.../pchotard/sti into fixes

Jeremy Linton (1):
      arm64: dts: juno: Correct PCI IO window

Loic Pallardy (1):
      ARM: dts: STiH407-family: fix i2c nodes

Maxime Ripard (1):
      ARM: gr8: Rename the DTSI and relevant DTS

Sudeep Holla (1):
      arm64: dts: juno: fix cluster sleep state entry latency on all SoC versions

 arch/arm/boot/dts/Makefile                               |  2 +-
 arch/arm/boot/dts/stih407-family.dtsi                    | 16 ++++++++++++++++
 arch/arm/boot/dts/{ntc-gr8-evb.dts => sun5i-gr8-evb.dts} |  2 +-
 arch/arm/boot/dts/{ntc-gr8.dtsi => sun5i-gr8.dtsi}       |  0
 arch/arm64/boot/dts/arm/juno-base.dtsi                   |  2 +-
 arch/arm64/boot/dts/arm/juno-r1.dts                      |  2 +-
 arch/arm64/boot/dts/arm/juno-r2.dts                      |  2 +-
 arch/arm64/boot/dts/arm/juno.dts                         |  2 +-
 8 files changed, 22 insertions(+), 6 deletions(-)
 rename arch/arm/boot/dts/{ntc-gr8-evb.dts => sun5i-gr8-evb.dts} (99%)
 rename arch/arm/boot/dts/{ntc-gr8.dtsi => sun5i-gr8.dtsi} (100%)
