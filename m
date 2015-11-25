From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 25 Nov 2015 06:35:17 +0000
Subject: [PATCH 0/12] arm64: renesas: r8a7795: sound support
Message-ID: <8737vu8ucv.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

These are r8a7795/salvator-x sound support for latest branch.
(These are posted few month ago and were queued on Simon's branch)

I could have sound by this order

	> git checkout renesas-devel-20151123-v4.4-rc2
	> git merge  geert/topic/cpg-mssr-v6
	> git am -3 ${THESE-PATCH-SET}

These supports 44.1kHz sound only. 48kHz sound needs cs2000 driver
which is posted to ML (clk maintainer accepted ?)
I can send cs2000 support if it was accepted.

Kuninori Morimoto (12):
      arm64: renesas: r8a7795: add AUDIO_DMAC support
      arm64: renesas: r8a7795: Sound SSI PIO support
      arm64: renesas: r8a7795: Sound SSI DMA support
      arm64: renesas: r8a7795: Sound SRC support
      arm64: renesas: r8a7795: Sound DVC support
      arm64: renesas: salvator-x: Sound SSI PIO support
      arm64: renesas: salvator-x: Sound SSI DMA support
      arm64: renesas: salvator-x: Sound SSI DMA support via BUSIF
      arm64: renesas: salvator-x: Sound SRC support
      arm64: renesas: salvator-x: Sound DVC support
      arm64: defconfig: add Renesas R-Car DMAC driver support
      arm64: defconfig: add Renesas sound and AK4613 support

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  94 +++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 253 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/configs/defconfig                       |   6 +++
 3 files changed, 353 insertions(+)
