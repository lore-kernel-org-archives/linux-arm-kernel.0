From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Nov 2017 16:26:59 -0500
Subject: [PATCH 2/4] pinctrl: Add skew-delay pin config and bindings
In-Reply-To: <20171028133719.27528-2-linus.walleij@linaro.org>
References: <20171028133719.27528-1-linus.walleij@linaro.org>
 <20171028133719.27528-2-linus.walleij@linaro.org>
Message-ID: <20171101212659.be4phj2wha66x63d@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 28, 2017 at 03:37:17PM +0200, Linus Walleij wrote:
> Some pin controllers (such as the Gemini) can control the
> expected clock skew and output delay on certain pins with a
> sub-nanosecond granularity. This is typically done by shunting
> in a number of double inverters in front of or behind the pin.
> Make it possible to configure this with a generic binding.
> 
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt | 4 ++++
>  drivers/pinctrl/pinconf-generic.c                              | 2 ++
>  include/linux/pinctrl/pinconf-generic.h                        | 5 +++++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> index 4483cc31e531..ad9bbbba36e9 100644
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> @@ -271,6 +271,10 @@ output-high		- set the pin to output mode with high level
>  sleep-hardware-state	- indicate this is sleep related state which will be programmed
>  			  into the registers for the sleep state.
>  slew-rate		- set the slew rate
> +skew-delay		- this affects the expected clock skew on input pins
> +			  and the delay before latching a value to an output
> +			  pin. Typically indicates how many double-inverters are
> +			  used to delay the signal.

Units?

>  
>  For example:
>  
