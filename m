From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Oct 2015 15:01:45 +0900
Subject: [PATCH v12 0/7] arm64: renesas: Add Renesas R8A7795 SoC support
Message-ID: <1445839312-8874-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this patchset adds basic support for the Renesas R-Car H3 (R8A7795) SoC
and its Saovator-X board.


Based on a merge of:
* v4.3-rc1
* clk-shmobile-for-v4.4 branch of 
  git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
  This provides the bindings and includes for the new CPG driver.
  These are queued up by the subsystem maintainer, Mike Turquette,
  for v4.4.

Run-time dependencies:
* The base
* The new GPG driver
  "[PATCH/RFC v4 0/5] clk: shmobile: Add new Renesas CPG/MSSR DT bindings"
  and its dependencies. This may be found in the
  topic/cpg-mssr-v4 branch of
  git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers


For changes see per-patch changelogs.


Gaku Inami (1):
  arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support

Geert Uytterhoeven (2):
  arm64: renesas: r8a7795 dtsi: Add dummy dma-controller nodes
  arm64: renesas: r8a7795 dtsi: Add all SCIF nodes

Kuninori Morimoto (3):
  arm64: renesas: r8a7795: enable PFC
  arm64: renesas: add Salvator-X board support on DTS
  arm64: defconfig: renesas: Enable Renesas r8a7795 SoC

Simon Horman (1):
  MAINTAINERS: Add entry Renesas arm64 architecture

 Documentation/devicetree/bindings/arm/shmobile.txt |   4 +
 MAINTAINERS                                        |   9 ++
 arch/arm64/Kconfig.platforms                       |  17 ++
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/renesas/Makefile               |   4 +
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  62 ++++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 172 +++++++++++++++++++++
 arch/arm64/configs/defconfig                       |   5 +
 8 files changed, 274 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/Makefile
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795.dtsi

-- 
2.1.4
