From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 18 Feb 2017 22:41:22 +0100
Subject: ARM: SoC fixes for v4.10
Message-ID: <5133141.CpkHmg62Ix@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7089db84e356562f8ba737c29e472cc42d530dbc:

  Linux 4.10-rc8 (2017-02-12 13:03:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 69e05170ef0d0c00e1098dd6a625b44f39903a6a:

  ARM: multi_v7_defconfig: enable Qualcomm RPMCC (2017-02-18 22:34:52 +0100)

----------------------------------------------------------------
ARM: SoC fixes for v4.10

Two more bugfixes that came in during this week:

- one defconfig change to enable a vital driver used on some Qualcomm
  based phones. This was already queued for 4.11, but the maintainer
  asked to have it in 4.10 after all.

- One regression fix for the reset controller framework, this got
  broken by a typo in the 4.10 merge window.

----------------------------------------------------------------
Andy Gross (1):
      ARM: multi_v7_defconfig: enable Qualcomm RPMCC

Arnd Bergmann (1):
      Merge tag 'reset-for-4.10-fixes' of https://git.pengutronix.de/git/pza/linux into fixes

Jerome Brunet (1):
      reset: fix shared reset triggered_count decrement on error

 arch/arm/configs/multi_v7_defconfig | 1 +
 drivers/reset/core.c                | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
