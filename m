From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 11 Sep 2016 22:44:20 +0200
Subject: [GIT PULL] Allwinner DT changes for 4.9, take 2
Message-ID: <20160911204420.GA11949@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull the following branch for 4.9, based on top of the previous
one.

To maintain bisectability, while avoiding some un-trivial merge
conflicts, I had to merge the clk branch that I've sent a PR to Mike
and Stephen. This branch will of course be stable.

Thanks!
Maxime

The following changes since commit bdc2601b02d31974b5765b93ac263b2eeab2e07c:

  Merge branch 'sunxi/clk-for-4.9' into sunxi/dt-for-4.9 (2016-09-10 11:45:28 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-4.9-2

for you to fetch changes up to 7a988a4dd29a8cfcf405a12441533d765d25a6b8:

  ARM: dts: gr8: Add support for the GR8 evaluation board (2016-09-11 22:23:17 +0200)

----------------------------------------------------------------
Allwinner DT changes for 4.9, take 2

A second set of device tree changes, this time switching a few SoCs to the
new sunxi-ng clock framework. We also added the support for a new SoC
(NextThing GR8 and its evaluation board), and the support for the DRM
driver in the A33.

----------------------------------------------------------------
Chen-Yu Tsai (2):
      ARM: dts: sun6i: switch A31/A31s to new CCU clock bindings
      ARM: dts: sun8i: Move A23/A33 usbphy and usb_otg nodes to common dtsi

Maxime Ripard (3):
      ARM: sun8i: Convert the A23 and A33 to the CCU
      ARM: sun8i: a33: Add display pipeline
      ARM: sun8i: a23/a33: Add RGB666 pins

Myl?ne Josserand (2):
      ARM: dts: Add NextThing GR8 dtsi
      ARM: dts: gr8: Add support for the GR8 evaluation board

 arch/arm/boot/dts/Makefile           |    1 +
 arch/arm/boot/dts/ntc-gr8-evb.dts    |  342 +++++++++++
 arch/arm/boot/dts/ntc-gr8.dtsi       | 1087 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/sun6i-a31.dtsi     |  424 +++----------
 arch/arm/boot/dts/sun8i-a23-a33.dtsi |  295 +++------
 arch/arm/boot/dts/sun8i-a23.dtsi     |   80 +--
 arch/arm/boot/dts/sun8i-a33.dtsi     |  236 +++++---
 7 files changed, 1791 insertions(+), 674 deletions(-)
 create mode 100644 arch/arm/boot/dts/ntc-gr8-evb.dts
 create mode 100644 arch/arm/boot/dts/ntc-gr8.dtsi

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160911/08fd7c31/attachment.sig>
