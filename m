From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Nov 2013 13:29:07 +0100
Subject: [PATCH 03/31] ARM: tegra: document use of standard DMA DT bindings
In-Reply-To: <1384548866-13141-4-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-4-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131129122907.GP22771@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 01:53:58PM -0700, Stephen Warren wrote:
[...]
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt
> index 2b6817f6e40e..eaf00102d92c 100644
> --- a/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt
> @@ -4,14 +4,17 @@ Required properties:
>  - compatible : "nvidia,tegra20-ac97"
>  - reg : Should contain AC97 controller registers location and length
>  - interrupts : Should contain AC97 interrupt
> -- clocks : Must contain one entry, for the module clock.
> -  See ../clocks/clock-bindings.txt for details.
>  - resets : Must contain an entry for each entry in reset-names.
>    See ../reset/reset.txt for details.
>  - reset-names : Must include the following entries:
>    - ac97
> -- nvidia,dma-request-selector : The Tegra DMA controller's phandle and
> -  request selector for the AC97 controller
> +- dmas : Must contain an entry for each entry in clock-names.
> +  See ../dma/dma.txt for details.
> +- dma-names : Must include the following entries:
> +  - rx
> +  - tx
> +- clocks : Must contain one entry, for the module clock.
> +  See ../clocks/clock-bindings.txt for details.

Was this unintentionally moved?

> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt
> index 8b070aeca3db..dc30c6bfbe95 100644
> --- a/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt
> @@ -4,14 +4,17 @@ Required properties:
>  - compatible : "nvidia,tegra20-i2s"
>  - reg : Should contain I2S registers location and length
>  - interrupts : Should contain I2S interrupt
> -- clocks : Must contain one entry, for the module clock.
> -  See ../clocks/clock-bindings.txt for details.
>  - resets : Must contain an entry for each entry in reset-names.
>    See ../reset/reset.txt for details.
>  - reset-names : Must include the following entries:
>    - i2s
> -- nvidia,dma-request-selector : The Tegra DMA controller's phandle and
> -  request selector for this I2S controller
> +- dmas : Must contain an entry for each entry in clock-names.
> +  See ../dma/dma.txt for details.
> +- dma-names : Must include the following entries:
> +  - rx
> +  - tx
> +- clocks : Must contain one entry, for the module clock.
> +  See ../clocks/clock-bindings.txt for details.

This too?

> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
> index 60d59a54ca07..3376ba42a209 100644
> --- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
> @@ -7,11 +7,6 @@ Required properties:
>    - Tegra30 requires 2 entries, for the APBIF and AHUB/AUDIO register blocks.
>    - Tegra114 requires an additional entry, for the APBIF2 register block.
>  - interrupts : Should contain AHUB interrupt
> -- nvidia,dma-request-selector : A list of the DMA channel specifiers. Each
> -  entry contains the Tegra DMA controller's phandle and request selector.
> -  If a single entry is present, the request selectors for the channels are
> -  assumed to be contiguous, and increment from this value.
> -  If multiple values are given, one value must be given per channel.
>  - clocks : Must contain an entry for each entry in clock-names.
>    See ../clocks/clock-bindings.txt for details.
>  - clock-names : Must include the following entries:
> @@ -36,6 +31,14 @@ Required properties:
>    - amx
>    - adx
>  - ranges : The bus address mapping for the configlink register bus.
> +- dmas : Must contain an entry for each entry in clock-names.
> +  See ../dma/dma.txt for details.
> +- dma-names : Must include the following entries:
> +  - rx0 .. rx<n>
> +  - tx0 .. tx<n>
> +  ... where n is:
> +  Tegra30: 3
> +  Tegra114, Tegra124: 9
>    Can be empty since the mapping is 1:1.

I think this line belongs to the description of the "ranges" property.

> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
> index fcd9f67999de..7ea701e07dc2 100644
> --- a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
> +++ b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
> @@ -4,16 +4,19 @@ Required properties:
>  - compatible : should be "nvidia,tegra114-spi".
>  - reg: Should contain SPI registers location and length.
>  - interrupts: Should contain SPI interrupts.
> -- nvidia,dma-request-selector : The Tegra DMA controller's phandle and
> -  request selector for this SPI controller.
> -- clocks : Must contain an entry for each entry in clock-names.
> -  See ../clocks/clock-bindings.txt for details.
>  - clock-names : Must include the following entries:
>    - spi
>  - resets : Must contain an entry for each entry in reset-names.
>    See ../reset/reset.txt for details.
>  - reset-names : Must include the following entries:
>    - spi
> +- dmas : Must contain an entry for each entry in clock-names.
> +  See ../dma/dma.txt for details.
> +- dma-names : Must include the following entries:
> +  - rx
> +  - tx
> +- clocks : Must contain an entry for each entry in clock-names.
> +  See ../clocks/clock-bindings.txt for details.

Another accidental move? I beginning to think there might be a pattern
to this, but I haven't figured it out yet.

> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
> index e144f144717f..bdf08e6dec9b 100644
> --- a/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
> +++ b/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
> @@ -4,14 +4,17 @@ Required properties:
>  - compatible : should be "nvidia,tegra20-sflash".
>  - reg: Should contain SFLASH registers location and length.
>  - interrupts: Should contain SFLASH interrupts.
> -- nvidia,dma-request-selector : The Tegra DMA controller's phandle and
> -  request selector for this SFLASH controller.
>  - clocks : Must contain one entry, for the module clock.

But then this doesn't move it... perhaps it really is accidental in
other places. =)

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131129/195c8685/attachment.sig>
