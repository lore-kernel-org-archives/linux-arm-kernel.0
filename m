From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 8 Jul 2016 22:32:07 +0200
Subject: [PATCH v2 2/7] bindings: spi-samsung: document the clocks and
 the clock-name property
In-Reply-To: <1467989201-14661-3-git-send-email-andi.shyti@samsung.com>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
 <1467989201-14661-3-git-send-email-andi.shyti@samsung.com>
Message-ID: <20160708203207.GB25980@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2016 at 11:46:36PM +0900, Andi Shyti wrote:
> These two properties were not documented but used in the spi
> dts. Add the related documentation.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-samsung.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
> index 57d5539..2b7167e 100644
> --- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
> @@ -24,6 +24,14 @@ Required SoC Specific Properties:
>  - dma-names: Names for the dma channels. There must be at least one channel
>    named "tx" for transmit and named "rx" for receive.
>  
> +- clocks: specifies the clock IDs provided to the SPI controller; they are
> +  required for interacting with the controller itself, for synchronizing the bus
> +  and as I/O clock (the latter is required by exynos5433 and exynos7).
> +
> +- clock-names: string names of the clocks in the 'clocks' property; the names
> +  mut be "spi", "spi_busclkN" and "spi_ioclk", where N is determined by

s/mut/must/

> +  "samsung,spi-src-clk".

Thanks for taking care of this! Older SoCs (like s3c-s5p) even though
they do not set clk_from_cmu, it seems they required them as well...
this is a little bit strange but at least now the documentation matches
the driver.

I would only describe the difference in number of clocks in more
specific way, e.g.:

 - clock-names: string names of the clocks in the 'clocks' property; for all
   devices the names must be "spi", "spi_busclkN" (where N is determined by
   "samsung,spi-src-clk"); for Exynos5433 it must contain third clock
   named "spi_ioclk"

... or something similar.

Anyway in general:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
