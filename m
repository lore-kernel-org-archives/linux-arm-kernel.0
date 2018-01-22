From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Jan 2018 09:29:03 -0800
Subject: [GIT PULL] dts fixes for omaps for v4.16 merge window
Message-ID: <pull-1516642112-325806@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 1cadb0c341079785182a8d00d12ecb0bbef935fb:

  Revert "ARM: dts: dra7: Add properties to enable PCIe x2 lane mode" (2017-12-23 08:18:15 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/dt-pt3-signed

for you to fetch changes up to 0e6e6dcce8d578516ef3aea2c9f9b4d0a0d53194:

  ARM: dts: Nokia N9: add support for up/down keys in the dts (2018-01-19 07:40:13 -0800)

----------------------------------------------------------------
Few omap dts fixes and n9 volume keys update for v4.16 merge window

For now, we need to rely on dts alias for n900 lcd and tvout order
to prevent occasional blank lcd. And we need to reduce the shut down
temperature for dra7 for non-cpu thermal cases.

And looks like we're missing the n9 volume key mappings and there is
active work going happening for n9 at least for postmarketos. So let's
make sure the keys can be actually used as they are the only buttons
on n9 in addition to the power key.

----------------------------------------------------------------
Ivaylo Dimitrov (1):
      ARM: dts: n900: Add aliases for lcd and tvout displays

Pavel Machek (1):
      ARM: dts: Nokia N9: add support for up/down keys in the dts

Ravikumar Kattekola (1):
      ARM: dts: dra7: Reduce shut down temperature of non-cpu thermal zones

 arch/arm/boot/dts/dra7.dtsi      | 16 ++++++++++++++++
 arch/arm/boot/dts/omap3-n9.dts   |  7 +++++++
 arch/arm/boot/dts/omap3-n900.dts |  4 +++-
 3 files changed, 26 insertions(+), 1 deletion(-)
