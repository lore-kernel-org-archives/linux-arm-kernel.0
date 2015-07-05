From: jogo@openwrt.org (Jonas Gorski)
Date: Sun, 5 Jul 2015 18:55:18 +0200
Subject: [PATCH v2 2/4] dt-bindings: ARM: Mediatek: Document devicetree
 bindings for spi bus
In-Reply-To: <1435583070-9600-3-git-send-email-leilk.liu@mediatek.com>
References: <1435583070-9600-1-git-send-email-leilk.liu@mediatek.com>
 <1435583070-9600-3-git-send-email-leilk.liu@mediatek.com>
Message-ID: <CAOiHx=nLx14VTrm_buqbZX15Ry+YQnNfEmWuimUvk9_5zrgjng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 29, 2015 at 3:04 PM, Leilk Liu <leilk.liu@mediatek.com> wrote:
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>  .../devicetree/bindings/spi/spi-mt65xx.txt         | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-mt65xx.txt
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> new file mode 100644
> index 0000000..04c28fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> @@ -0,0 +1,32 @@
> +MTK SPI device

"SPI device" lets me think "SPI slave device", not "SPI master
controller", so maybe call it "MTK SPI Controller"?

> +
> +Required properties:
> +- compatible: should be one of the following.
> +    - mediatek,mt8173-spi: for mt8173 platforms
> +    - mediatek,mt8135-spi: for mt8135 platforms
> +    - mediatek,mt6589-spi: for mt6589 platforms
> +
> +- reg: Address and length of the register set for the device
> +
> +- interrupts: Should contain spi interrupt
> +
> +- clock-names: tuple listing input clock names.
> +       Required elements: "main"
> +
> +- clocks: phandles to input clocks.
> +
> +- pad-select: should specify spi pad used, only required for MT8173.
> +       This value should be 0~3.

AFAIK device-specific non-generic properties should be
vendor-prefixed, i.e. it should be "mediatek,pad-select", not just
"pad-select".


Regards
Jonas
