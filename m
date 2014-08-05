From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 5 Aug 2014 17:59:52 +0200
Subject: [PATCH 0/3] arm: mediatek: Add support for GIC interrupt polarity
 extension.
In-Reply-To: <1407250690-2858-1-git-send-email-srv_yingjoe.chen@mediatek.com>
References: <1407250690-2858-1-git-send-email-srv_yingjoe.chen@mediatek.com>
Message-ID: <CABuKBeKiVaj39eZUq-A0RxbsLbZ7G85+QDxt5HkZrjMZ=n77Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-08-05 16:58 GMT+02:00 Joe.C <srv_yingjoe.chen@mediatek.com>:
> This series add support for mediatek GIC interrupt polarity extension.
> Several components in mediatek SoC have low level triggered interrupt and
> require this support.
>
> This also correct 6589 timer irq polarity. Previous version works because
> 6589 boot loader already set correct polarity for timer interrupt.

Please use the get_maintainer.pl script to get all the addresses this
patch set should be send to.
Traffic on mailinglists is quite high so it's not sure that the
maintainer will see your patches.
If they get them as a personal email the probability that the review
your patch is much higher.

>
> The patch set is based on Matthias's Mediatek basic support for v3.17 [1].
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/272561.html
>
> Joe.C (3):
>   irqchip: gic: Change irq type check when extension is present
>   arm: mediatek: Add support for GIC interrupt polarity extension.
>   dt-bindings: add bindings for mediatek intpol
>
>  .../interrupt-controller/mediatek,intpol.txt       | 16 ++++++
>  arch/arm/boot/dts/mt6589.dtsi                      |  7 ++-
>  arch/arm/mach-mediatek/Makefile                    |  2 +-
>  arch/arm/mach-mediatek/common.h                    | 19 +++++++
>  arch/arm/mach-mediatek/intpol.c                    | 61 ++++++++++++++++++++++
>  arch/arm/mach-mediatek/mediatek.c                  | 10 ++++
>  drivers/irqchip/irq-gic.c                          | 27 ++++++----
>  7 files changed, 131 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,intpol.txt
>  create mode 100644 arch/arm/mach-mediatek/common.h
>  create mode 100644 arch/arm/mach-mediatek/intpol.c
>
> --
> 1.8.1.1.dirty
>



-- 
motzblog.wordpress.com
