From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 14 May 2018 17:21:44 +0100
Subject: [GIT PULL] ARM: dts: vexpress: updates for v4.18
Message-ID: <20180514162144.GA8409@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC team,

Please pull !

Note that the commit restructuring motherboard dtsi touches the file
in ARM64 DT but that's because of the way the file gets included and
it's not something newly introduced here.

Regards,
Sudeep

--

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/vexpress-updates-4.18

for you to fetch changes up to b67b00eeddac0fea494d6339618ffd3da071c2e4:

  ARM: dts: vexpress: replace '_' with '-' in node names (2018-05-11 14:12:32 +0100)

----------------------------------------------------------------
ARMv7 Vexpress updates/cleanups for v4.18

1. Syntactic restructuring of motherboard include file so that it can be
   included at the top of any other DTS file as it should be rather than
   existing include in the middle of the file at a specific location

2. Use of standard GPIO controller bindings for few sysreg components
   like LED, MMC Write Protect/Card Detect and Flash Write Protect
   to fix some of the new DTC warnings

3. Cleanup to replace all underscores('_') with hyphens('-') in the
   device node names

----------------------------------------------------------------
Linus Walleij (1):
      ARM: dts: vexpress: Restructure motherboard includes

Sudeep Holla (2):
      ARM: dts: vexpress: use standard gpio bindings for sys_{led,mci,flash}
      ARM: dts: vexpress: replace '_' with '-' in node names

 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi            | 712 +++++++++++----------
 arch/arm/boot/dts/vexpress-v2m.dtsi                | 710 ++++++++++----------
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts        |   3 +-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |   9 +-
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts            |   5 +-
 arch/arm/boot/dts/vexpress-v2p-ca9.dts             |   5 +-
 .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts      |   5 +-
 7 files changed, 732 insertions(+), 717 deletions(-)
