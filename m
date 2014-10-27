From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 27 Oct 2014 21:03:06 +0100
Subject: [PATCH 6/8] regulator: max77686: Add external GPIO control
In-Reply-To: <1414422226-10948-7-git-send-email-k.kozlowski@samsung.com>
References: <1414422226-10948-1-git-send-email-k.kozlowski@samsung.com>
 <1414422226-10948-7-git-send-email-k.kozlowski@samsung.com>
Message-ID: <544EA4FA.6040704@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 10/27/2014 04:03 PM, Krzysztof Kozlowski wrote:
> @@ -85,6 +91,9 @@ struct max77686_data {
>  	struct max77686_regulator_data *regulators;
>  	int num_regulators;
>  
> +	/* Array of size num_regulators with GPIOs for external control. */
> +	int *ext_control_gpio;
> +

The integer-based GPIO API is deprecated in favor of the descriptor-based GPIO
interface (Documentation/gpio/consumer.txt). Could you please use the later?

Best regards,
Javier
