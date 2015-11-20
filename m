From: robh@kernel.org (Rob Herring)
Date: Fri, 20 Nov 2015 09:39:05 -0600
Subject: [PATCH V2 1/2] dt-bindings: spi: Documentation for Hi6220 spi
 driver
In-Reply-To: <1447922229-60552-1-git-send-email-zhongkaihua@huawei.com>
References: <1447922229-60552-1-git-send-email-zhongkaihua@huawei.com>
Message-ID: <20151120153905.GA8476@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 04:37:08PM +0800, Zhong Kaihua wrote:
> dt-bindings: spi: Documentation for Hi6220 spi driver
> 
> Signed-off-by: Zhong Kaihua <zhongkaihua@huawei.com>
> ---
>  .../devicetree/bindings/spi/spi-hi6220.txt         | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-hi6220.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-hi6220.txt b/Documentation/devicetree/bindings/spi/spi-hi6220.txt
> new file mode 100644
> index 0000000..91aa169
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-hi6220.txt
> @@ -0,0 +1,45 @@
> +Hi6220 SPI controller
> +
> +Required properties:
> +- compatible : "arm,pl022", "arm,primecell"

If this is just a pl022, then you don't need this document as 
spi_pl022.txt already exists. If HiSilicon has modified this block, then 
you need an additional HiSi specific compatible string and add it to 
spi_pl022.txt.

> +- reg : Offset and length of the register set for the device
> +- interrupts : Should contain SPI controller interrupt
> +- num-cs : total number of chipselects
> +
> +Required Board Specific Properties:
> +
> +- #address-cells: should be 1.
> +- #size-cells: should be 0.
> +
> +Optional properties:
> +- cs-gpios : should specify GPIOs used for chipselects.
> +  The gpios will be referred to as reg = <index> in the SPI child nodes.
> +  If unspecified, a single SPI device without a chip select can be used.
> +- dmas : Two or more DMA channel specifiers following the convention outlined
> +         in bindings/dma/dma.txt
> +- dma-names: Names for the dma channels, if present. There must be at
> +	     least one channel named "tx" for transmit and named "rx" for
> +             receive.
> +
> +Example:
> +             spi_0: spi at f7106000 {
> +			compatible = "arm,pl022", "arm,primecell";
> +			reg = <0x0 0xf7106000 0x0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <0 50 4>;
> +			bus-id = <0>;

This should be removed.
