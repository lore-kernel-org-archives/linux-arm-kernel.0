From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 19 Sep 2014 13:10:17 +0200
Subject: [PATCH v3 0/7] arm: Add basic support for MediaTek MT8127 & MT8135
 SoCs
In-Reply-To: <1411095859-18737-1-git-send-email-srv_yingjoe.chen@mediatek.com>
References: <1411095859-18737-1-git-send-email-srv_yingjoe.chen@mediatek.com>
Message-ID: <541C0F19.9020103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/09/14 05:04, Joe.C wrote:
> This is v3 of adding basic device tree support for MT8127 & MT8135.
> This series is based on Matthias' pull request for mediatek support [1]
> 
> We are planning to upstream drivers for MT8127 & MT8135 SoCs.
> MT8135 is a tablet soc featuring 2 CA7 + 2 CA15. MT8127 is a
> tablet soc with 4 CA7. They share many similar IP components
> with MT65xx series.

The patches look good to me.
I will wait a couple of days if others have comments on them and if not
send a pull request.

Cheers,
Matthias

> 
> Changes in v3:
>  - Changing earlyprintk order and dt-binding based on Matthias' suggestion.
> 
> v2:
>  - Change timer compatible string.
>  - Build dtb for mt8127 & mt8135
>  - Adding earlyprintk support for mt8127 & mt8135
> 
> Joe.C (7):
>   arm: MTK: Add basic support for mt8127
>   arm: mediatek: add dts for 8127 Moose board
>   arm: MTK: Add basic support for mt8135
>   arm: mediatek: add dts for MT8135 evaluation board.
>   dt-bindings: add more chips in documentation for Mediatek SoC
>   arm: dts: Build dtb for mt8127 & mt8135
>   arm: mediatek: Add earlyprintk support for mt8127 & mt8135
> 
>  Documentation/devicetree/bindings/arm/mediatek.txt |  15 ++-
>  arch/arm/Kconfig.debug                             |  20 ++++
>  arch/arm/boot/dts/Makefile                         |   4 +-
>  arch/arm/boot/dts/mt8127-moose.dts                 |  24 +++++
>  arch/arm/boot/dts/mt8127.dtsi                      |  93 +++++++++++++++++
>  arch/arm/boot/dts/mt8135-evbp1.dts                 |  24 +++++
>  arch/arm/boot/dts/mt8135.dtsi                      | 115 +++++++++++++++++++++
>  arch/arm/mach-mediatek/mediatek.c                  |   2 +
>  8 files changed, 293 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm/boot/dts/mt8127-moose.dts
>  create mode 100644 arch/arm/boot/dts/mt8127.dtsi
>  create mode 100644 arch/arm/boot/dts/mt8135-evbp1.dts
>  create mode 100644 arch/arm/boot/dts/mt8135.dtsi
> 
