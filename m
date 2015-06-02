From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 02 Jun 2015 22:49:09 +0300
Subject: [PATCH 1/2] clk: at91: add a new compatible string for Flexcom
 in the DT documentation
In-Reply-To: <359f6b85c3a8b51a0ea35bacdbdc0443b9fbedcc.1433263218.git.cyrille.pitchen@atmel.com>
References: <cover.1433263218.git.cyrille.pitchen@atmel.com>
 <359f6b85c3a8b51a0ea35bacdbdc0443b9fbedcc.1433263218.git.cyrille.pitchen@atmel.com>
Message-ID: <556E08B5.7010208@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06/02/2015 07:49 PM, Cyrille Pitchen wrote:

> This patches documents the new bindings for the Flexcom clock, which will
> be introduced by Atmel sama5d2x chips.

> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> ---
>   .../devicetree/bindings/clock/at91-clock.txt         | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)

> diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
> index 7a4d492..df4f40b 100644
> --- a/Documentation/devicetree/bindings/clock/at91-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
[...]
> @@ -461,3 +464,20 @@ For example:
>   		compatible = "atmel,sama5d4-clk-h32mx";
>   		clocks = <&mck>;
>   	};
> +
> +Required properties for flexcom clock:
> +- #clock-cells : from common clock binding; shall be set to 0.
> +- clocks : shall be the Flexcom peripheral clock from PMC.
> +- reg : shall be the range for Flexcom dedicated I/O registers (without USART,
> +  TWI or SPI registers).
> +- atmel,flexcom-mode : shall be a string value among { "spi", "usart", "i2c",
> +  "twi" }. "i2c" and "twi" are synonymous.
> +
> +For example:
> +	flx0: flexcom at f8034000 {

    The ePAPR standard says: "The name of a node should be somewhat generic, 
reflecting the function of the device and not its precise programming model."

[...]

WBR, Sergei
