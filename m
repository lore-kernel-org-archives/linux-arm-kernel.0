From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 28 Jan 2015 16:34:17 +0000
Subject: [PATCH 1/5] mmc: pwrseq: Document that simple sequence support
 more than one GPIO
In-Reply-To: <1422439819-29854-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1422439819-29854-1-git-send-email-javier.martinez@collabora.co.uk>
 <1422439819-29854-2-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <54C90F89.1040500@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/01/15 10:10, Javier Martinez Canillas wrote:
> Many SDIO/MMC attached WLAN chips need more than one ping for their reset
> sequence. Extend the pwrseq_simple binding to support more than one pin.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>   Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> index da333d9ed94c..9a77deb164c7 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> @@ -8,9 +8,9 @@ Required properties:
>   - compatible : contains "mmc-pwrseq-simple".
>
>   Optional properties:
> -- reset-gpios : contains a GPIO specifier. The reset GPIO is asserted at
> -	initialization and prior we start the power up procedure of the card. It
> -	will be de-asserted right after the power has been provided to the card.
> +- reset-gpios : contains a list of GPIO specifiers. The reset GPIOs are asserted
> +	at initialization and prior we start the power up procedure of the card.
> +	Will be de-asserted right after the power has been provided to the card.
Makes sense if you add "They" before last sentence.
>
>   Example:
>
>
