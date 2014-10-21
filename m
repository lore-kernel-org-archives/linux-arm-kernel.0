From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 21 Oct 2014 13:06:54 +0100
Subject: [PATCH v2 3/4] mfd/regulator: dt-bindings: max77686: Document
 regulators off in suspend
In-Reply-To: <1413890597-31037-4-git-send-email-k.kozlowski@samsung.com>
References: <1413890597-31037-1-git-send-email-k.kozlowski@samsung.com>
 <1413890597-31037-4-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20141021120654.GB4127@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Oct 2014, Krzysztof Kozlowski wrote:

> Add information which regulators can be disabled during system suspend.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Suggested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  Documentation/devicetree/bindings/mfd/max77686.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

I don't think this requires a DT Ack.

Applied with the extra '\n' removed.

> diff --git a/Documentation/devicetree/bindings/mfd/max77686.txt b/Documentation/devicetree/bindings/mfd/max77686.txt
> index 678f3cf0b8f0..75fdfaf41831 100644
> --- a/Documentation/devicetree/bindings/mfd/max77686.txt
> +++ b/Documentation/devicetree/bindings/mfd/max77686.txt
> @@ -34,6 +34,12 @@ to get matched with their hardware counterparts as follow:
>  	-BUCKn 	:	for BUCKs, where n can lie in range 1 to 9.
>  			example: BUCK1, BUCK5, BUCK9.
>  
> +  Regulators which can be turned off during system suspend:
> +	-LDOn	:	2, 6-8, 10-12, 14-16,
> +	-BUCKn	:	1-4.
> +  Use standard regulator bindings for it ('regulator-off-in-suspend').
> +
> +
>  Example:
>  
>  	max77686 at 09 {

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
