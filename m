From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jun 2016 09:59:42 +0900
Subject: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v4.8
Message-ID: <cover.1465347183.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC DT updates for v4.8.


The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt-for-v4.8

for you to fetch changes up to 21cc405c8a6332ddad2d2751a9723b2b3e227a05:

  arm64: dts: r8a7795: Drop 0x from unit address of gic (2016-05-30 10:18:01 +0900)

----------------------------------------------------------------
Renesas ARM64 Based SoC DT Updates for v4.8

* Fix W=1 dtc warnings and other cleanups
* Enable watchdog timer
* Enable DMA for I2C
* Increase the size of GIC-400 mapped registers: be nicer to hypervisors
* Support RTS/CTS hardware flow control

----------------------------------------------------------------
Geert Uytterhoeven (4):
      arm64: dts: salvator-x: SCIF1 supports RTS/CTS hardware flow control
      arm64: dts: r8a7795: Use SYSC "always-on" PM Domain for RWDT node
      arm64: dts: r8a7795: Fix W=1 dtc warnings
      arm64: dts: salvator-x: Fix W=1 dtc warnings

Niklas S?derlund (1):
      arm64: dts: r8a7795: enable DMA for I2C

Pooya Keshavarzi (1):
      arm64: dts: r8a7795: Increase the size of GIC-400 mapped registers

Simon Horman (1):
      arm64: dts: r8a7795: Drop 0x from unit address of gic

Wolfram Sang (2):
      arm64: dts: r8a7795: Add RWDT node
      arm64: dts: salvator-x: Enable watchdog timer

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 14 +++-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 98 ++++++++++++++--------
 2 files changed, 71 insertions(+), 41 deletions(-)
