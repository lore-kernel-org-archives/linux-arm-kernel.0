From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 8 Apr 2016 15:57:39 +0200
Subject: [PATCH] phy: phy-mt65xx-usb3: add support for mt2701 platform
In-Reply-To: <1460106832-25360-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1460106832-25360-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <5707B8D3.4070605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/04/16 11:13, Chunfeng Yun wrote:
> A new compatible string, "mediatek,mt2701-u3phy", is added.
>
> Some register settings to avoid RX sensitivity level degradation
> which may arise on mt8173 platform are separated from other
> platforms.
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>   .../devicetree/bindings/phy/phy-mt65xx-usb.txt     |    4 +-
>   drivers/phy/Kconfig                                |    5 +-
>   drivers/phy/phy-mt65xx-usb3.c                      |   77 +++++++++++++-------
>   3 files changed, 57 insertions(+), 29 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt b/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
> index 00100cf..8d2a62f 100644
> --- a/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
> @@ -4,7 +4,9 @@ mt65xx USB3.0 PHY binding
>   This binding describes a usb3.0 phy for mt65xx platforms of Medaitek SoC.
>
>   Required properties (controller (parent) node):
> - - compatible	: should be "mediatek,mt8173-u3phy"
> + - compatible	: should be one or more of

If there are more then one, which value will avoid_rx_sen_degradation 
have? There should be only one compatible.

Apart from that normally the dts documentation parts are separate patches.

Regards,
Matthias
