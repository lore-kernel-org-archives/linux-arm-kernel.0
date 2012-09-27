From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 27 Sep 2012 09:28:37 -0600
Subject: [PATCH V2] ASoC: SAMSUNG: Add DT support for i2s
In-Reply-To: <1348741532-29412-1-git-send-email-padma.v@samsung.com>
References: <1348741532-29412-1-git-send-email-padma.v@samsung.com>
Message-ID: <506470A5.3070307@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27/2012 04:25 AM, Padmavathi Venna wrote:
> Add support for device based discovery.

> +++ b/Documentation/devicetree/bindings/sound/samsung-i2s.txt

> +i2s at 03830000 {
> +	compatible = "samsung,samsung-i2s";
> +	reg = <0x03830000 0x100>;

> +	tx-dma-channel-secondary = <&pdma0 8>;
> +	tx-dma-channel = <&pdma0 10>;
> +	rx-dma-channel = <&pdma0 9>;
> +	supports-6ch;
> +	supports-rstclr;
> +	supports-secdai;

Those 6 properties are custom to this binding so should have a vendor
prefix, e.g. "samsung,supports-6ch".

Also, I wonder if this shouldn't wait for the forthcoming standardized
DT DMA bindings (or perhaps document custom bindings that are identical
to the new standardized bindings)? Otherwise, the DMA stuff will all
have to be redefined again. Apparently it's hoped the bindings will be
in 3.7, or if not there, in 3.8.
