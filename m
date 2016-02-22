From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Feb 2016 13:34:28 -0800
Subject: [GIT PULL] omap fixes against v4.5-rc5, fixes more onenand corruption
Message-ID: <20160222213427.GU13417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit cf26f1137333251f3515dea31f95775b99df0fd5:

  ARM: OMAP2+: Fix omap_device for module reload on PM runtime forbid (2016-02-12 08:56:52 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.5/fixes-rc5

for you to fetch changes up to 3f315c5b850fa7aff73f50de8e316b98f611a32b:

  ARM: OMAP2+: Fix onenand initialization to avoid filesystem corruption (2016-02-22 09:24:10 -0800)

----------------------------------------------------------------
Two omap fixes for omaps against v4.5-rc5:

- Yet another fix for n900 onenand to avoid corruption. This time to
  fix the issue of mounting onenand back and forth between the original
  maemo kernel and mainline Linux kernel. And it also seems there will
  be two more fixes coming via the MTD tree as issues were discovered
  also in the onenand driver during testing.

- Revert tps65217 regulator clean up as it breaks MMC for am335x
  variants. The proper way to clean this up is just to rename the
  tps65217.dtsi file into tps65217-am335x.dtsi as a similar setup
  is used on many am335x boards.

----------------------------------------------------------------
Ivaylo Dimitrov (1):
      ARM: OMAP2+: Fix onenand initialization to avoid filesystem corruption

Peter Ujfalusi (1):
      Revert "regulator: tps65217: remove tps65217.dtsi file"

 .../devicetree/bindings/regulator/tps65217.txt     | 10 ----
 arch/arm/boot/dts/am335x-bone-common.dtsi          | 14 ++----
 arch/arm/boot/dts/am335x-chilisom.dtsi             | 14 +-----
 arch/arm/boot/dts/am335x-nano.dts                  | 14 +-----
 arch/arm/boot/dts/am335x-pepper.dts                | 14 +-----
 arch/arm/boot/dts/am335x-sl50.dts                  | 13 +----
 arch/arm/boot/dts/tps65217.dtsi                    | 56 ++++++++++++++++++++++
 arch/arm/mach-omap2/gpmc-onenand.c                 |  6 +--
 8 files changed, 70 insertions(+), 71 deletions(-)
 create mode 100644 arch/arm/boot/dts/tps65217.dtsi
