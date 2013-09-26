From: bcousson@baylibre.com (Benoit Cousson)
Date: Thu, 26 Sep 2013 11:41:31 +0200
Subject: [PATCH 1/9] omap4: dts: Add node for AES
In-Reply-To: <1380146469-29496-2-git-send-email-joelf@ti.com>
References: <1380146469-29496-1-git-send-email-joelf@ti.com>
 <1380146469-29496-2-git-send-email-joelf@ti.com>
Message-ID: <5244014B.1090502@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/09/2013 00:01, Joel Fernandes wrote:
> OMAP4 has an AES module that uses the omap-aes crypto driver.
> Add DT entries for the same.
>
> Signed-off-by: Joel Fernandes <joelf@ti.com>
> ---
>   arch/arm/boot/dts/omap4.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 45708e1..4267a74 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -663,5 +663,15 @@
>   			ram-bits = <12>;
>   			ti,has-mailbox;
>   		};
> +
> +		aes: aes at 4B501000 {
> +			compatible = "ti,omap4-aes";
> +			ti,hwmods = "aes";
> +			reg = <0x4B501000 0xa0>;

Nit: Please use lower case for hexa value.

> +			interrupt-parent = <&gic>;

You don't have to add the interrupt-parent, it is already set by default 
at the root of the tree.

We did not add it for most nodes. Some are still there becasue I missed 
them during the review :-)

> +			interrupts = <0 85 0x4>;

For interrupt, you should use the macros now for better readability.

  +			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;

Regards,
Benoit

> +			dmas = <&sdma 111>, <&sdma 110>;
> +			dma-names = "tx", "rx";
> +		};
>   	};
>   };
>
