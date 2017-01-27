From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Jan 2017 10:14:27 +0100
Subject: [GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates for
 v4.11
Message-ID: <cover.1485508214.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM64 based SoC DT updates for v4.11.

This pull request is based on the previous round of
such requests, tagged as renesas-arm64-dt-for-v4.11,
which you have already pulled.


The following changes since commit b2b9443beee5017ebdb3f2be9ef472c73d260481:

  arm64: dts: r8a7795: Add PWM support (2017-01-04 10:00:44 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt2-for-v4.11

for you to fetch changes up to 7e1c23b94ed7f0d2719795a9828402003de5335d:

  arm64: dts: r8a7796: Mark EthernetAVB device node disabled (2017-01-27 10:09:02 +0100)

----------------------------------------------------------------
Second Round of Renesas ARM64 Based SoC DT Updates for v4.11

r8a779[56] SoCs:
* Mark EthernetAVB device node disabled in DT for r8a779[56] SoCs
  - They are enabled as appropriate in board DT files
* Link ARM GIC to clock and clock domain on r8a779[56] SoCs
* Add thermal support

r8a7795 SoC:
* Tidyup audma definition order on r8a7795 SoC
* Add missing power-domains property for SATA

r8a7795/h3ulcb board:
* Add MIX/CTU support as per support present in DT for r8a7796

----------------------------------------------------------------
Geert Uytterhoeven (5):
      arm64: dts: r8a7795: Add missing power-domains property for sata
      arm64: dts: r8a7795: Link ARM GIC to clock and clock domain
      arm64: dts: r8a7796: Link ARM GIC to clock and clock domain
      arm64: dts: r8a7795: Mark EthernetAVB device node disabled
      arm64: dts: r8a7796: Mark EthernetAVB device node disabled

Kuninori Morimoto (2):
      arm64: dts: h3ulcb: follow sound CTU/MIX supports
      arm64: dts: r8a7795: tidyup audma definition order

Wolfram Sang (2):
      arm64: dts: r8a7795: Add R-Car Gen3 thermal support
      arm64: dts: r8a7796: Add R-Car Gen3 thermal support

 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts |   2 +
 arch/arm64/boot/dts/renesas/r8a7795.dtsi       | 195 ++++++++++++++++---------
 arch/arm64/boot/dts/renesas/r8a7796.dtsi       |  62 ++++++++
 3 files changed, 193 insertions(+), 66 deletions(-)
