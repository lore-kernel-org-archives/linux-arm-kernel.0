From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 20 Nov 2018 11:28:25 +0100
Subject: [PATCH 1/2] spi: mediatek: Add bindings for mediatek MT7629 soc
 platform
In-Reply-To: <1542703268-17285-2-git-send-email-leilk.liu@mediatek.com>
References: <1542703268-17285-1-git-send-email-leilk.liu@mediatek.com>
 <1542703268-17285-2-git-send-email-leilk.liu@mediatek.com>
Message-ID: <7bc1777c-fb24-d150-c13f-658c2a33cd71@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/11/2018 09:41, Leilk Liu wrote:
> This patch adds a DT binding documentation for the MT7629 soc.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>  .../devicetree/bindings/spi/spi-mt65xx.txt         |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> index 7940940..6cc4e87 100644
> --- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> @@ -6,6 +6,7 @@ Required properties:
>      - mediatek,mt2712-spi: for mt2712 platforms
>      - mediatek,mt6589-spi: for mt6589 platforms
>      - mediatek,mt7622-spi: for mt7622 platforms
> +    - mediatek,mt7629-spi: for mt7629 platforms

That's ok, as you add support in the driver. As it actually doesn't change
anything in the driver itself you could just describe the binding as something like:
" mediatek,mt7629-spi", "mediatek,mt7622-spi": for mt7629 platforms

This way the driver will just probe the driver using the fallback (mt7622)
compatible, but if you realize in the future that you will need to distinguish
between the two SoCs, you can add a mt7629 compatible.

Just as information for the future :)

Regards,
Matthias
