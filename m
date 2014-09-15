From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 15 Sep 2014 11:02:09 +0200
Subject: [PATCHv2 8/8] ARM: at91: document Atmel SMART compatibles
In-Reply-To: <1410536587-24607-9-git-send-email-alexandre.belloni@free-electrons.com>
References: <1410536587-24607-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1410536587-24607-9-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <5416AB11.4060600@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/2014 17:43, Alexandre Belloni :
> Document all the available compatibles for Atmel "SMART" SoCs.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  .../devicetree/bindings/arm/atmel-at91.txt         | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> index 6e3e3e5c611f..2ef92e04ed10 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> @@ -1,6 +1,46 @@
>  Atmel AT91 device tree bindings.
>  ================================
>  
> +Boards with a SoC of the Atmel AT91 or SMART family shall have the following
> +properties:
> +
> +Required root node properties:
> +compatible: must be one of:
> + * "atmel,rm9200"

No, this one doesn't exists. Does it? It must be "atmel,at91rm9200".

> + * "atmel,at91sam9260"
> + * "atmel,at91sam9261"
> + * "atmel,at91sam9263"
> + * "atmel,at91sam9x5" for the x5 family, shall be extended with the specific SoC
> +   compatible:

We call it the "5 series" or at91sam9x5 family, not the x5 family.

> +    o "atmel,at91sam9g15"
> +    o "atmel,at91sam9g25"
> +    o "atmel,at91sam9g35"
> +    o "atmel,at91sam9x25"
> +    o "atmel,at91sam9x35"
> + * "atmel,at91sam9g20"
> + * "atmel,at91sam9g45"
> + * "atmel,at91sam9n12"
> + * "atmel,at91sam9rl"
> + * "atmel,sama5" for the cortexA5 family, shall be extended with the specific

for SoC using a Cortex-A5.

> +   SoC family:
> +    o "atmel,sama5d3" shal be exteneded with the specific SoC compatible:

s/shal/shall/

> +       - "atmel,samad31"

samad31 => sama5d31

> +       - "atmel,samad33"
> +       - "atmel,samad34"
> +       - "atmel,samad35"
> +       - "atmel,samad36"

Ditto for all 4 above.

> +    o "atmel,sama5d4"

Same here, you can also talk about a family:

o "atmel,sama5d41"
o "atmel,sama5d42"
o "atmel,sama5d43"
o "atmel,sama5d44"


> +
> +
> +In addition, the above compatible shall be extended with the specific
> +SoC and board used. Currently known SoC compatibles are:
> +    "marvell,berlin2"      for Marvell Armada 1500 (BG2, 88DE3100),
> +    "marvell,berlin2cd"    for Marvell Armada 1500-mini (BG2CD, 88DE3005)
> +    "marvell,berlin2ct"    for Marvell Armada ? (BG2CT, 88DE????)
> +    "marvell,berlin2q"     for Marvell Armada 1500-pro (BG2Q, 88DE3114)
> +    "marvell,berlin3"      for Marvell Armada ? (BG3, 88DE????)
> +
> +

;-)

>  PIT Timer required properties:
>  - compatible: Should be "atmel,at91sam9260-pit"
>  - reg: Should contain registers location and length
> 


-- 
Nicolas Ferre
