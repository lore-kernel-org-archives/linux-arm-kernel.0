From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 3 Dec 2014 18:06:34 +0100
Subject: [PATCH v3 1/3] ARM: at91: Add Special Function Registers binding
 documentation
In-Reply-To: <1417197962-19441-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1417197962-19441-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <547F431A.5040804@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 28/11/2014 19:06, Alexandre Belloni a ?crit :
> The special function registers gather some registers that allow to tweak
> features provided by IPs controlled through another register range.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

I think that you had the Acked-by tag from Boris, hadn't you?

> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> index 562cda9d86d9..a6427de45785 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> @@ -136,3 +136,20 @@ Example:
>  		compatible = "atmel,at91sam9260-rstc";
>  		reg = <0xfffffd00 0x10>;
>  	};
> +
> +Special Function Registers (SFR)
> +
> +Special Function Registers (SFR) manage specific aspects of the integrated
> +memory, bridge implementations, processor and other functionality not controlled
> +elsewhere.
> +
> +required properties:
> +- compatible: Should be "atmel,<chip>-sfr", "syscon".
> +  <chip> can be "at91sam9260", "at91sam9rl" or "at91sam9x5".

Well, in the following patches you are adding "atmel,sama5d3-sfr" and
"atmel,sama5d4-sfr" so I suspect more chips must be added here...

> +- reg: Should contain registers location and length
> +
> +	sfr at f0038000 {
> +		compatible = "atmel,sama5d3-sfr", "syscon";
> +		reg = <0xf0038000 0x4000>;
> +	};
> +

Otherwise, it looks okay.

Bye,
-- 
Nicolas Ferre
