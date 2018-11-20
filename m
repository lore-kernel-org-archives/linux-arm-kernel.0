From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 20 Nov 2018 15:49:05 +0100
Subject: [v4, PATCH 2/2] dt-binding: mediatek-dwmac: add binding document
 for MediaTek MT2712 DWMAC
In-Reply-To: <1542705696-18507-3-git-send-email-biao.huang@mediatek.com>
References: <1542705696-18507-1-git-send-email-biao.huang@mediatek.com>
 <1542705696-18507-3-git-send-email-biao.huang@mediatek.com>
Message-ID: <20181120144905.GD18335@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +Optional properties:
> +- mediatek,tx-delay: TX clock delay macro value. Range is 0~31. Default is 0.
> +	It should be defined for rgmii/rgmii-rxid/mii interface.
> +- mediatek,rx-delay: RX clock delay macro value. Range is 0~31. Default is 0.
> +	It should be defined for rgmii/rgmii-txid/mii/rmii interface.
> +- mediatek,fine-tune: boolean property, if present indicates that fine delay
> +	is selected for rgmii interface.
> +	If present, tx-delay/rx-delay is 170+/-50ps per stage.
> +	Else tx-delay/rx-delay of coarse delay macro is 0.55+/-0.2ns per stage.
> +	This property do not apply to non-rgmii PHYs.
> +	Only coarse-tune delay is supported for mii/rmii PHYs.

Didn't Rob say to express the delay in pS, and have the driver convert
that to values to put into registers. That is what i would prefer.

     Andrew
