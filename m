From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 7 Aug 2017 11:43:07 +0800
Subject: [GIT PULL 3/3] Allwinner dts64 changes for 4.14
In-Reply-To: <20170807031910.66qj742m3egmdex5@wens.csie.org>
Message-ID: <20170807034307.5gw5ircl6eexsbfq@wens.csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

We still have a couple of dts64 patches in our tree that are not
included in this pull request. These add missing aliases for the
Ethernet controllers we enabled in 4.13-rc1. So we are aiming to
rework them as fixes for 4.13. Otherwise this is just a fairly
routine set of patches enabling the PMIC.

Thanks
ChenYu


The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt64-for-4.14

for you to fetch changes up to 78c3cbc80fec105d12a0f9aabe628090ae9c1749:

  arm64: allwinner: a64: add AXP803 PMIC support to SoPine and the baseboard (2017-07-24 09:56:00 +0200)

----------------------------------------------------------------
Allwinner arm64 DT changes for 4.14

The usual improvement patches:

  - R_INTC interrupt controller enabled for the A64 SoC

  - AXP803 PMIC added and enabled on the Pine64 and SoPine boards

----------------------------------------------------------------
Icenowy Zheng (5):
      arm64: allwinner: a64: add NMI (R_INTC) controller on A64
      arm64: allwinner: a64: add AXP803 node to Pine64 device tree
      arm64: allwinner: a64: add DTSI file for AXP803 PMIC
      arm64: allwinner: a64: enable AXP803 regulators for Pine64
      arm64: allwinner: a64: add AXP803 PMIC support to SoPine and the baseboard

 arch/arm64/boot/dts/allwinner/axp803.dtsi          | 150 +++++++++++++++++++++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 113 ++++++++++++++++
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  |  23 ++++
 .../boot/dts/allwinner/sun50i-a64-sopine.dtsi      |  86 ++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |   9 ++
 5 files changed, 381 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/axp803.dtsi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170807/53ff2ce9/attachment.sig>
