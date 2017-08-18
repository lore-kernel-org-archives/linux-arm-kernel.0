From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Aug 2017 10:19:34 +0200
Subject: [GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates for
 v4.14
Message-ID: <cover.1502961153.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM64 based SoC DT updates for v4.14.

This pull request is based on the previous round of
such requests, tagged as renesas-arm64-dt-for-v4.14,
which I have already sent a pull-request for.


The following changes since commit 4725f2b8805718a65dcbce8668710f145df797a8:

  arm64: dts: renesas: r8a7795: add hsusb ch3 device node (2017-07-27 17:19:05 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt2-for-v4.14

for you to fetch changes up to 1fa0b494f6b17f8094b1b380f7cc1cb89f4878dc:

  arm64: dts: r8a77995: add pfc device node (2017-08-17 11:03:44 +0200)

----------------------------------------------------------------
Second Round of Renesas ARM64 Based SoC DT Updates for v4.14

* Add PFC device node to R-Car D3 (r8a77995)

  This is a step towards enabling devices that use multiplexed pins
  - including ethernet - on boards that use the r8a7796 SoC.

* Add USB nodes to R-Car M3-W (r8a7796)

  This is a step towards enabling USB devices on boards that
  use the r8a7796 SoC.

* Use newly added Gen-3 fallback compat string

  This is consistent with ongoing efforts to use per-generation
  fallback strings where appropriate across devices found
  on R-Car SoCs. The aim of the effort being to strike a balance
  between the limited information available about the compatibility
  of devices found on different SoCs and the desire to ease enabling
  devices on new SoCs.

  This has no run-time effect due to the presence of a per-SoC
  compat string.

* Cleanup whitespace and extra LVDS port label

  Minor cleanups, no run-time effect.

----------------------------------------------------------------
Laurent Pinchart (1):
      arm64: dts: salvator-common: Remove extra LVDS port label

Simon Horman (2):
      arm64: dts: r8a7795: Use R-Car SATA Gen3 fallback compat string
      arm64: dts: r8a7795: correct whitespace of companion property

Yoshihiro Shimoda (6):
      arm64: dts: r8a7796: add usb2_phy device nodes
      arm64: dts: r8a7796: add USB2.0 Host (EHCI/OHCI) device nodes
      arm64: dts: r8a7796: Add USB3.0 host device node
      arm64: dts: r8a7796: Add USB-DMAC device nodes
      arm64: dts: r8a7796: Add HSUSB device node
      arm64: dts: r8a77995: add pfc device node

 arch/arm64/boot/dts/renesas/r8a7795.dtsi         |  11 ++-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi         | 113 +++++++++++++++++++++--
 arch/arm64/boot/dts/renesas/r8a77995.dtsi        |   5 +
 arch/arm64/boot/dts/renesas/salvator-common.dtsi |   4 -
 4 files changed, 116 insertions(+), 17 deletions(-)
