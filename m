From: srv_yingjoe.chen@mediatek.com (Joe.C)
Date: Fri, 22 Aug 2014 17:23:50 +0800
Subject: [RESEND PATCH v2 0/4] arm: mediatek: Add support for GIC
 interrupt polarity extension.
In-Reply-To: <1407895884-18131-1-git-send-email-srv_yingjoe.chen@mediatek.com>
References: <1407895884-18131-1-git-send-email-srv_yingjoe.chen@mediatek.com>
Message-ID: <1408699430.27728.92.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi, ARM soc maintainers,

Please help to review this series, I think this should go through 
ARM soc tree.

We plan to upstream drivers for MT8135. MT8135 is a big/little soc
featuring 2 CA7 + 2 CA15, and sharing many similar IP components with
mt65xx. Many components of 65xx series & 8135 require this support.

Joe.C


On Wed, 2014-08-13 at 10:11 +0800, Joe.C wrote:
> [Sorry, resend to include all maintainers.]
> 
> This series add support for mediatek GIC interrupt polarity extension.
> Several components in mediatek SoC have low level triggered interrupt and
> require this support.
> 
> This also correct 6589 timer irq polarity. Previous version works because
> 6589 boot loader already set correct polarity for timer interrupt.
> 
> The patch set is based on Matthias's Mediatek basic support for v3.17 [1].
> 
> v2:
> - Make mt6589.dtsi changes as a separate commit as Matthias suggest.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/272561.html
> 
> Joe.C (4):
>   irqchip: gic: Change irq type check when extension is
>   arm: mediatek: Add support for GIC interrupt polarity
>   arm: mediatek: Add intpol in mt6589.dtsi
>   dt-bindings: add bindings for mediatek intpol
> 
>  Documentation/devicetree/bindings/interrupt-controller/mediatek,intpol.txt |   16 ++
>  arch/arm/boot/dts/mt6589.dtsi                                              |    7 -
>  arch/arm/mach-mediatek/Makefile                                            |    2
>  arch/arm/mach-mediatek/common.h                                            |   19 +++
>  arch/arm/mach-mediatek/intpol.c                                            |   61 ++++++++++
>  arch/arm/mach-mediatek/mediatek.c                                          |   10 +
>  drivers/irqchip/irq-gic.c                                                  |   27 ++--
>  7 files changed, 131 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,intpol.txt
>  create mode 100644 arch/arm/mach-mediatek/common.h
>  create mode 100644 arch/arm/mach-mediatek/intpol.c
