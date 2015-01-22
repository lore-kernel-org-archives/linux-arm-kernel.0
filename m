From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 22 Jan 2015 13:23:33 +0100
Subject: [PATCH v3 1/2] clocksource: devicetree: document Conexant
 Digicolor timer binding
In-Reply-To: <6812ad4ac585e40ad7d8282eef1d64be8bc6eaa5.1421821466.git.baruch@tkos.co.il>
References: <cover.1421821466.git.baruch@tkos.co.il>
 <6812ad4ac585e40ad7d8282eef1d64be8bc6eaa5.1421821466.git.baruch@tkos.co.il>
Message-ID: <54C0EBC5.7060606@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2015 07:36 AM, Baruch Siach wrote:
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Please add a changelog and a more verbose description: see for example 
commit 2f2b7fb2 or 926b65e2. If there is a public documentation please 
add a link to it or give a quick description of how the timer behaves.

Also that will help to review the code in the timer.

> ---
>   .../devicetree/bindings/timer/digicolor-timer.txt      | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/timer/digicolor-timer.txt
>
> diff --git a/Documentation/devicetree/bindings/timer/digicolor-timer.txt b/Documentation/devicetree/bindings/timer/digicolor-timer.txt
> new file mode 100644
> index 000000000000..d1b659bbc29f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/digicolor-timer.txt
> @@ -0,0 +1,18 @@
> +Conexant Digicolor SoCs Timer Controller
> +
> +Required properties:
> +
> +- compatible : should be "cnxt,cx92755-timer"
> +- reg : Specifies base physical address and size of the "Agent Communication"
> +  timer registers
> +- interrupts : Contains 8 interrupts, one for each timer
> +- clocks: phandle to the main clock
> +
> +Example:
> +
> +	timer at f0000fc0 {
> +		compatible = "cnxt,cx92755-timer";
> +		reg = <0xf0000fc0 0x40>;
> +		interrupts = <19>, <31>, <34>, <35>, <52>, <53>, <54>, <55>;
> +		clocks = <&main_clk>;
> +	};
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
