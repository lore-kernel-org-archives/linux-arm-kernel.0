From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 11 May 2018 18:40:14 +0200
Subject: [PATCH v2 00/12] refactor dts and add support for more boards
In-Reply-To: <cover.1523434757.git.sean.wang@mediatek.com>
References: <cover.1523434757.git.sean.wang@mediatek.com>
Message-ID: <df482bb2-df7c-3e65-fc0a-f20c81c2dac3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/11/2018 10:53 AM, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Changes since v1:
> - Dropped several patches which have been merged.
> - Rebased to linux-next-20180410 where those dependent patches including
>   [1] and [2] all have been got merged.
> - Revised according to suggestions and comments on v1, where the major work is
>   to put board-specific nodes into DTS files and to leave the common nodes
>   among boards in DTSI files as done in patch 7,9,10,11 and 12.
> - Merged Ryder Lee's patch for update audio nodes reflecting the latest
>   bindings.
> - Revised commit message.
> 
> The series is to refactor current .dts for allowing more boards can properly
> join and reuse almost the same device node definitions.
> 
> Before we're doing that, some works about enhancements and fixups are being
> made on the dt-binding document and .dts files. In addition, the series has to
> depend on the patch [1][2]. Otherwise, certain build failure would have an
> occurrence.
> 
> [1] arm: dts: mt7623: add PCIe related nodes
> http://lists.infradead.org/pipermail/linux-mediatek/2018-February/012053.html
> 
> [2] dt-bindings: soc: add header files required for MT7623A SCPSYS dt-binding
> http://lists.infradead.org/pipermail/linux-mediatek/2018-February/011930.html
> 
> Ryder Lee (1):
>   arm: dts: mediatek: modify audio related nodes for both MT2701 and
>     MT7623
> 
> Sean Wang (11):
>   dt-bindings: cpufreq: mediatek: use - instead of _ in examples
>   arm: dts: mediatek: converted to using SPDX identifiers
>   arm: dts: mt7623: fix invalid memory node being generated
>   arm: dts: mt7623: fix available memory size on bananapi-r2
>   arm: dts: mt7623: fix all Warnings (unit_address_vs_reg)
>   arm: dts: mt7623: add BTIF, HSDMA and SPI-NOR device nodes
>   arm: dts: mt6323: move node mt6323 leds to mt6323.dtsi
>   arm: dts: mt7623: extend common file reused by all boards with MT7623
>     SoCs
>   arm: dts: mt7623: add MT7623A SoC level DTS
>   arm: dts: mt7623: add MT7623A reference boards
>   arm: dts: mt7623: add MT7623N reference board with eMMC
> 

I merged all but 1/12 which needs to go through rafaels tree and 8/12 which was
already applied from a different series.

You can find them in v4.17-next/soc on git.kernel.org

Regards,
Matthias


>  .../bindings/cpufreq/cpufreq-mediatek.txt          |   6 +-
>  arch/arm/boot/dts/Makefile                         |   3 +
>  arch/arm/boot/dts/mt2701-evb.dts                   |   9 +-
>  arch/arm/boot/dts/mt2701.dtsi                      | 197 ++++----
>  arch/arm/boot/dts/mt6323.dtsi                      |  17 +-
>  arch/arm/boot/dts/mt6580-evbp1.dts                 |   9 +-
>  arch/arm/boot/dts/mt6580.dtsi                      |   9 +-
>  arch/arm/boot/dts/mt6589-aquaris5.dts              |  10 +-
>  arch/arm/boot/dts/mt6589.dtsi                      |  12 +-
>  arch/arm/boot/dts/mt6592-evb.dts                   |   9 +-
>  arch/arm/boot/dts/mt6592.dtsi                      |   9 +-
>  arch/arm/boot/dts/mt7623.dtsi                      | 537 ++++++++++++++++-----
>  arch/arm/boot/dts/mt7623a-rfb-emmc.dts             | 291 +++++++++++
>  arch/arm/boot/dts/mt7623a-rfb-nand.dts             | 337 +++++++++++++
>  arch/arm/boot/dts/mt7623a.dtsi                     |  44 ++
>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts      | 279 ++---------
>  arch/arm/boot/dts/mt7623n-rfb-emmc.dts             | 326 +++++++++++++
>  arch/arm/boot/dts/mt7623n-rfb-nand.dts             |  40 +-
>  arch/arm/boot/dts/mt7623n-rfb.dtsi                 |  12 +-
>  arch/arm/boot/dts/mt8127-moose.dts                 |   9 +-
>  arch/arm/boot/dts/mt8127.dtsi                      |   9 +-
>  arch/arm/boot/dts/mt8135-evbp1.dts                 |   9 +-
>  arch/arm/boot/dts/mt8135.dtsi                      |   9 +-
>  23 files changed, 1576 insertions(+), 616 deletions(-)
>  create mode 100644 arch/arm/boot/dts/mt7623a-rfb-emmc.dts
>  create mode 100644 arch/arm/boot/dts/mt7623a-rfb-nand.dts
>  create mode 100644 arch/arm/boot/dts/mt7623a.dtsi
>  create mode 100644 arch/arm/boot/dts/mt7623n-rfb-emmc.dts
> 
