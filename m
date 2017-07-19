From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 19 Jul 2017 08:31:35 +0200
Subject: [PATCH v3 2/9] clk: at91: add audio plls to the compatible list
 in DT binding
In-Reply-To: <20170713074927.10882-3-quentin.schulz@free-electrons.com>
References: <20170713074927.10882-1-quentin.schulz@free-electrons.com>
 <20170713074927.10882-3-quentin.schulz@free-electrons.com>
Message-ID: <20170719083135.38ab7b07@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Jul 2017 09:49:20 +0200
Quentin Schulz <quentin.schulz@free-electrons.com> wrote:

> This new clock driver set allows to have a fractional divided clock that
> would generate a precise clock particularly suitable for audio
> applications.
> 
> The main audio pll clock has two children clocks: one that is connected
> to the PMC, the other that can directly drive a pad. As these two routes
> have different enable bits and different dividers and divider formulas,
> they are handled by two different drivers.
> 
> This adds the audio plls (frac, pad and pmc) to the compatible list of
> at91 clocks in DT binding.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
> 
> added in v2:
>   - split from big patch with pll drivers and dt-binding
> 
>  Documentation/devicetree/bindings/clock/at91-clock.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
> index 5f3ad65daf69..51c259a92d02 100644
> --- a/Documentation/devicetree/bindings/clock/at91-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
> @@ -81,6 +81,16 @@ Required properties:
>  	"atmel,sama5d2-clk-generated":
>  		at91 generated clock
>  
> +	"atmel,sama5d2-clk-audio-pll-frac":
> +		at91 audio fractional pll
> +
> +	"atmel,sama5d2-clk-audio-pll-pad":
> +		at91 audio pll CLK_AUDIO output pin
> +
> +	"atmel,sama5d2-clk-audio-pll-pmc"
> +		at91 audio pll output on AUDIOPLLCLK that feeds the PMC
> +		and can be used by peripheral clock or generic clock
> +
>  Required properties for SCKC node:
>  - reg : defines the IO memory reserved for the SCKC.
>  - #size-cells : shall be 0 (reg is used to encode clk id).
