From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 08:53:07 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for v4.6
Message-ID: <cover.1456443769.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC DT updates
for v4.6.

This pull request is based on the previous round of
such requests, tagged as renesas-dt-for-v4.6,
which you have already pulled.


The following changes since commit c3373b09ba0391bcd9e992b0a2ce52d48d33e47b:

  ARM: dts: silk: Enable SCIF_CLK frequency and pins (2016-02-09 19:43:28 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v4.6

for you to fetch changes up to d92df7e59909940b2b65523981aa0ddb4327047a:

  ARM: dts: r8a7790: use fallback etheravb compatibility string (2016-02-25 13:12:37 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Updates for v4.6

* Add L2 cache-controller nodes to r8a779[0134] and r8a73a4
* Add etheravb support to r8a7794
* Correct JP3 jumper description on Porter
* Enable thermal zone on  r8a779[013]
* Replace gpio-key, wakeup with wakeup-source property on r8a7794
* Use demuxer for IIC0/I2C0 on lager
* Use fallback etheravb, pci and pcie compatibility strings as appropriate

----------------------------------------------------------------
Geert Uytterhoeven (5):
      ARM: dts: r8a73a4: Add L2 cache-controller nodes
      ARM: dts: r8a7790: Add L2 cache-controller nodes
      ARM: dts: r8a7791: Add L2 cache-controller node
      ARM: dts: r8a7793: Add L2 cache-controller node
      ARM: dts: r8a7794: Add L2 cache-controller node

Kuninori Morimoto (3):
      ARM: dts: r8a7790: enable to use thermal-zone
      ARM: dts: r8a7791: enable to use thermal-zone
      ARM: dts: r8a7793: enable to use thermal-zone

Sergei Shtylyov (3):
      ARM: dts: porter: fix JP3 jumper description
      ARM: dts: r8a7794: add EtherAVB clock
      ARM: dts: r8a7794: add EtherAVB support

Simon Horman (7):
      ARM: dts: r8a7790: use fallback pcie compatibility string
      ARM: dts: r8a7791: use fallback pcie compatibility string
      ARM: dts: r8a7790: use fallback pci compatibility string
      ARM: dts: r8a7791: use fallback pci compatibility string
      ARM: dts: r8a7794: use fallback pci compatibility string
      ARM: dts: r8a7794: replace gpio-key, wakeup with wakeup-source property
      ARM: dts: r8a7790: use fallback etheravb compatibility string

Wolfram Sang (1):
      ARM: dts: r8a7790: lager: use demuxer for IIC0/I2C0

 arch/arm/boot/dts/r8a73a4.dtsi            | 17 +++++++++
 arch/arm/boot/dts/r8a7790-lager.dts       | 32 +++++++++++++++--
 arch/arm/boot/dts/r8a7790.dtsi            | 57 +++++++++++++++++++++++++++----
 arch/arm/boot/dts/r8a7791-porter.dts      |  4 +--
 arch/arm/boot/dts/r8a7791.dtsi            | 40 +++++++++++++++++++---
 arch/arm/boot/dts/r8a7793-gose.dts        | 22 ++++++------
 arch/arm/boot/dts/r8a7793.dtsi            | 33 ++++++++++++++++--
 arch/arm/boot/dts/r8a7794.dtsi            | 31 ++++++++++++++---
 include/dt-bindings/clock/r8a7794-clock.h |  1 +
 9 files changed, 203 insertions(+), 34 deletions(-)
