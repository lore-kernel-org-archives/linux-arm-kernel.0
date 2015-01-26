From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 26 Jan 2015 15:27:29 +0100
Subject: [PATCH v4 0/4] Add basic support for Mediatek MT8173 SoC
In-Reply-To: <1421054073-43468-1-git-send-email-eddie.huang@mediatek.com>
References: <1421054073-43468-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <CABuKBeKjGL6puqhqCb6b4=5Qb9+hcm-sGQ7vLxyb2jAFaLYGUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-01-12 10:14 GMT+01:00 Eddie Huang <eddie.huang@mediatek.com>:
> MT8173 is a SoC based on 64bit ARMv8 architecture. It contains 2 CA53 + 2 CA57 cores.
> MT8173 share many HW IP with MT8135 and other MT65xx series. This patchset was tested
> on MT8173 engineer sample, and boot to shell ok.
>
> This series contains document bindings, device tree, defconfig, and one sysirq
> modification for MT8173.
>
> Changes in v4:
> 1. Add sysirq, uart binding documents.
> 2. Disable UART in mt8173.dtsi, enable needed UART in mt8173-evb.dtsi
>
> This patch base on 3.19-rc1, Joe's sysirq patch [1] and test boot to shell with
> Catalin Marinas's arch_timer virtual counter patch [2]
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310335.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/309856.html

Applied to v3.20-next/arm64.
Thanks.

>
> Eddie Huang (3):
>   Document: DT: Add bindings for mediatek MT8173 SoC Platform
>   arm64: dts: Add mediatek MT8173 SoC and evaluation board dts and
>     Makefile
>   arm64: mediatek: Add MT8173 SoC Kconfig and defconfig
>
> Yingjoe Chen (1):
>   irqchip: mtk-sysirq: Get irq number from register resource size
>
>  Documentation/devicetree/bindings/arm/mediatek.txt |   4 +
>  .../bindings/arm/mediatek/mediatek,sysirq.txt      |   1 +
>  .../devicetree/bindings/serial/mtk-uart.txt        |   4 +-
>  arch/arm64/Kconfig                                 |   6 +
>  arch/arm64/boot/dts/Makefile                       |   1 +
>  arch/arm64/boot/dts/mediatek/Makefile              |   5 +
>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |  38 +++++
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi           | 168 +++++++++++++++++++++
>  arch/arm64/configs/defconfig                       |   2 +
>  drivers/irqchip/irq-mtk-sysirq.c                   |  18 ++-
>  10 files changed, 239 insertions(+), 8 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/mediatek/Makefile
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-evb.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8173.dtsi
>
> --
> 1.8.1.1.dirty
>



-- 
motzblog.wordpress.com
