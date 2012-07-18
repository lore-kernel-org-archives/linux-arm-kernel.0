From: olof@lixom.net (Olof Johansson)
Date: Wed, 18 Jul 2012 08:38:49 -0700
Subject: [PATCH 4/4] arm: at91: at91sam9x5: fix gpio number per bank
In-Reply-To: <1342359637-15325-4-git-send-email-plagnioj@jcrosoft.com>
References: <20120715131618.GF4450@game.jcrosoft.org>
 <1342359637-15325-1-git-send-email-plagnioj@jcrosoft.com>
 <1342359637-15325-4-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20120718153849.GA6069@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


Two nits below.

On Sun, Jul 15, 2012 at 03:40:37PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On the serie 5 bank b and d have 19 and 22 pins only.
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
>  .../devicetree/bindings/gpio/gpio_atmel.txt        |    5 +++
>  arch/arm/boot/dts/at91sam9x5.dtsi                  |    2 ++
>  arch/arm/mach-at91/gpio.c                          |   33 +++++++++++++-------
>  3 files changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio_atmel.txt b/Documentation/devicetree/bindings/gpio/gpio_atmel.txt
> index 66efc80..d8dd425 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio_atmel.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio_atmel.txt
> @@ -9,6 +9,10 @@ Required properties:
>    unused).
>  - gpio-controller: Marks the device node as a GPIO controller.
>  
> +optional properties:
> +- gpio-nb: Number of gpio if absent 32.

"Number of gpios, if absent default is 32"

> +
> +
>  Example:
>  	pioA: gpio at fffff200 {
>  		compatible = "atmel,at91rm9200-gpio";
> @@ -16,5 +20,6 @@ Example:
>  		interrupts = <2 4>;
>  		#gpio-cells = <2>;
>  		gpio-controller;
> +                gpio-nb = <32>;
>  	};

Whitespace (tabs vs spaces)


-Olof
