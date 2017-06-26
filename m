From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Jun 2017 13:10:02 -0500
Subject: [PATCH v2 3/8] dt-bindings: pwm: Add STM32 LPTimer PWM binding
In-Reply-To: <1498055415-31513-4-git-send-email-fabrice.gasnier@st.com>
References: <1498055415-31513-1-git-send-email-fabrice.gasnier@st.com>
 <1498055415-31513-4-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20170626181002.qipmw7kbww67q4rb@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 04:30:10PM +0200, Fabrice Gasnier wrote:
> Add documentation for STMicroelectronics STM32 Low-Power Timer
> PWM binding.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v2:
> - s/Low Power/Low-Power/
> - remove 0x in example (parent node)
> - improve properties description
> ---
>  .../devicetree/bindings/pwm/pwm-stm32-lp.txt       | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
> new file mode 100644
> index 0000000..941c990
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
> @@ -0,0 +1,24 @@
> +STMicroelectronics STM32 Low-Power Timer PWM
> +
> +STM32 Low-Power Timer provides single channel PWM.
> +
> +Must be a sub-node of an STM32 Low-Power Timer device tree node.
> +See ../mfd/stm32-lptimer.txt for details about the parent node.
> +
> +Required parameters:
> +- compatible:		Must be "st,stm32-pwm-lp".
> +
> +Optional properties:
> +- pinctrl-names: 	Set to "default".
> +- pinctrl-0: 		Phandle pointing to pin configuration node for PWM.
> +
> +Example:
> +	lptimer1: lptimer at 40002400 {

timer at ...

With that,

Acked-by: Rob Herring <robh@kernel.org>
