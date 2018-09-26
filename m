From: robh@kernel.org (Rob Herring)
Date: Wed, 26 Sep 2018 17:33:18 -0500
Subject: [PATCH v3 1/3] spis: mediatek: add bindings for Mediatek MT2712
 soc platform
In-Reply-To: <1537150762-7072-2-git-send-email-leilk.liu@mediatek.com>
References: <1537150762-7072-1-git-send-email-leilk.liu@mediatek.com>
 <1537150762-7072-2-git-send-email-leilk.liu@mediatek.com>
Message-ID: <20180926223318.GA18703@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2018 at 10:19:20AM +0800, Leilk Liu wrote:
> This patch adds a DT binding documentation for the MT2712 soc.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>  .../devicetree/bindings/spi/spi-slave-mt27xx.txt   |   32 ++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt b/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
> new file mode 100644
> index 0000000..09cb2c4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
> @@ -0,0 +1,32 @@
> +Binding for MTK SPI Slave controller
> +
> +Required properties:
> +- compatible: should be one of the following.
> +    - mediatek,mt2712-spi-slave: for mt2712 platforms
> +- reg: Address and length of the register set for the device.
> +- interrupts: Should contain spi interrupt.
> +- clocks: phandles to input clocks.
> +  It's clock gate, and should be <&infracfg CLK_INFRA_AO_SPI1>.
> +- clock-names: should be "spi" for the clock gate.
> +
> +Optional properties:
> +- assigned-clocks: it's mux clock, should be <&topckgen CLK_TOP_SPISLV_SEL>.
> +- assigned-clock-parents: parent of mux clock.
> +  It's PLL, and should be on of the following.

s/on/one/

With that fixed,

Reviewed-by: Rob Herring <robh@kernel.org>
