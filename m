From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Fri, 6 Nov 2015 06:33:10 +0000
Subject: [PATCH v6 00/12] arm64: renesas: add sound support
Message-ID: <87egg3k5g6.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

these are v2 patches which add sound support to the r8a7795/Salvator-X.

These patches are an update of Simon's v5 patch-set

The main change to the patches themselves since Morimoto-san's v3 posting
and v4 updates to that posting is to update to new CPG/MSSR bindings via
Geert Uytterhoeven.

It doesn't include cs2000 support since it is not accepted yet.
I will send additional patch if it was accepted.
This patches doesn't include CTU/MIX support either,
because it is too advanced feature at this point.

Base:

* "[PATCH v4 0/3] arm64: renesas: r8a7795: add I2C support"
  This can be found in the topic/r8a7795-i2c-v4 branch of
  my renesas tree on kernel.org.

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

-- 
2.1.4
