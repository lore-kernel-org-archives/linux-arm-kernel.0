From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 Oct 2015 15:23:55 +0900
Subject: [PATCH v11 0/8] arm64: renesas: Add Renesas R8A7795 SoC support
Message-ID: <1444890243-6978-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this pathcset adds basic support for the Renesas R-Car H3 (R8A7795) SoC
and its Saovator-X board.

This series has undergone a number of rounds of development and review
on the linux-sh mailing list. This is the first posting to a wider audience
from which we are now seeking review.

It is anticpated that the CPG bindings used this patchset will be
changed before they hit mainline and thus this patchset will need
to be updated accordinly. Reviwers are advised to skip over that portion
of this patchset unless they have a particlar interest in that discussion.


Based on v4.3-rc1.

Further run-time dependencies are included in the
topic/gen3-latest branch of Geert Uytterhoeven's renesas-drivers tree.
which currently includes these patches less the MAINTAINERS update.

To aid review (and Geert's branch preparation) this series is available in
the topic/arm64-rcar-gen3-v11 branch of the my renesas tree.

Gaku Inami (1):
  arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support

Geert Uytterhoeven (3):
  arm64: renesas: r8a7795 dtsi: Add all common divider clocks
  arm64: renesas: r8a7795 dtsi: Add dummy dma-controller nodes
  arm64: renesas: r8a7795 dtsi: Add all SCIF nodes

Kuninori Morimoto (3):
  arm64: renesas: r8a7795: enable PFC
  arm64: renesas: add Salvator-X board support on DTS
  arm64: defconfig: renesas: Enable Renesas r8a7795 SoC

Simon Horman (1):
  MAINTAINERS: Add entry Renesas arm64 architecture

 Documentation/devicetree/bindings/arm/shmobile.txt |   4 +
 MAINTAINERS                                        |  10 +
 arch/arm64/Kconfig.platforms                       |  17 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/renesas/Makefile               |   4 +
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  62 ++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 384 +++++++++++++++++++++
 arch/arm64/configs/defconfig                       |   5 +
 include/dt-bindings/clock/r8a7795-clock.h          |  44 +++
 9 files changed, 531 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/Makefile
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795.dtsi
 create mode 100644 include/dt-bindings/clock/r8a7795-clock.h

-- 
2.1.4
