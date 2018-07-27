From: joel@jms.id.au (Joel Stanley)
Date: Fri, 27 Jul 2018 10:50:46 +0930
Subject: [GIT PULL v2] ARM: aspeed: dts changes for 4.19
Message-ID: <CACPK8XdBARcXsndyvc-roTi1SvYC4U+wHG0v0QPfWr_91wGkBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

Here's the ASPEED device tree bits, minus the FSI related changes.
I've placed the tag earlier on in the series.

We can merge the FSI work separately once Ben has reworked them,
either this time around or for 4.20.

Hopefully I've got my line breaks sorted this time around too.

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git \
      tags/aspeed-4.19-devicetree-no-fsi

for you to fetch changes up to 2450ceaf21798183f51bfdbd7d314635dbb62f4c:

  ARM: dts: aspeed: Add coprocessor interrupt controller (2018-07-25
17:38:03 +0930)

----------------------------------------------------------------
ASPEED device tree updates for 4.19

 - New support for the ASPEED USB host controller and USB vhub (device)
 support

 - Descriptions for the ColdFire processor that is part of the ASPEED
 SoC

 - Small fixes:
  * pwm/tach clock

----------------------------------------------------------------
Benjamin Herrenschmidt (7):
      ARM: dts: aspeed: Add G4 USB pinmux
      ARM: dts: aspeed: Add G5 USB host pinmux
      ARM: dts: aspeed: Add G4 USB Virtual Hub
      ARM: dts: aspeed: Add G5 USB Virtual Hub
      ARM: dts: aspeed: Enable vhub on port A of AST2500 EVB
      ARM: dts: aspeed: Fix Romulus VGA frame buffer
      ARM: dts: aspeed: Add coprocessor interrupt controller

Lei YU (1):
      ARM: dts: aspeed: Use 24MHz fixed clock for pwm

 arch/arm/boot/dts/aspeed-ast2500-evb.dts     | 14 ++++++------
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts |  4 ++--
 arch/arm/boot/dts/aspeed-g4.dtsi             | 26 +++++++++++++++++++--
 arch/arm/boot/dts/aspeed-g5.dtsi             | 34 ++++++++++++++++++++++++++--
 4 files changed, 65 insertions(+), 13 deletions(-)
