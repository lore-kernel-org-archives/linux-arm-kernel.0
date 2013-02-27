From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Feb 2013 20:54:18 +0000
Subject: [PATCH 04/12] mmc: mxs-mmc: move to use generic DMA helper
In-Reply-To: <1361978748-25281-5-git-send-email-shawn.guo@linaro.org>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
 <1361978748-25281-5-git-send-email-shawn.guo@linaro.org>
Message-ID: <201302272054.18829.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 February 2013, Shawn Guo wrote:
>  Required properties:
>  - compatible: Should be "fsl,<chip>-mmc".  The supported chips include
>    imx23 and imx28.
> -- interrupts: Should contain ERROR and DMA interrupts
> -- fsl,ssp-dma-channel: APBH DMA channel for the SSP
> +- interrupts: Should contain ERROR interrupt number
> +- dmas: DMA specifier, consisting of a phandle to DMA controller node
> +  and SSP DMA channel ID.
> +  Refer to dma.txt and fsl-mxs-dma.txt for details.

I wonder if we should leave support for old device trees files around,
at least for a while. Your patch removes a lot of unnecessary code if
we decide not to worry about backwards compatibility here, but I could
imagine that we see a few surprises here.

> +- dma-names: Must be "ssp".

I would prefer calling this "data" rather than "ssp". The name only
has local significance in the ssp device, so calling the channel
"ssp" seems wrong.

	Arnd
