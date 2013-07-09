From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Jul 2013 16:05:43 +0100
Subject: [PATCH v4 3/7] Documentation: DT: update atmel SSC with DMA
 binding
In-Reply-To: <1373379933-32749-4-git-send-email-richard.genoud@gmail.com>
References: <1373372929-17800-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-4-git-send-email-richard.genoud@gmail.com>
Message-ID: <20130709150543.GE27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 04:25:29PM +0200, Richard Genoud wrote:

>  - reg: Should contain SSC registers location and length
>  - interrupts: Should contain SSC interrupt
> +For dma transfer:
> +- dmas: DMA specifier, consisting of a phandle to DMA controller node,
> +  the memory interface and SSC DMA channel ID (for tx and rx).
> +  See Documentation/devicetree/bindings/dma/atmel-dma.txt for details.
> +- dma-names: Must be "tx", "rx".

This is added as a required property so...

> -Example:
> +Examples:
>  ssc0: ssc at fffbc000 {
>  	compatible = "atmel,at91rm9200-ssc";
>  	reg = <0xfffbc000 0x4000>;
>  	interrupts = <14 4 5>;
>  };

...this first example is now invalid and should probably just be being
extended with the new required properties.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130709/614c2105/attachment.sig>
