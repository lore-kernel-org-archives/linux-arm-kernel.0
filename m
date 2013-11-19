From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Nov 2013 13:56:54 +0000
Subject: [PATCH 1/5] Documentation: dt: Add kona-pwm binding
In-Reply-To: <1384800901-21711-2-git-send-email-tim.kryger@linaro.org>
References: <1384800901-21711-1-git-send-email-tim.kryger@linaro.org>
 <1384800901-21711-2-git-send-email-tim.kryger@linaro.org>
Message-ID: <20131119135654.GL5914@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 06:54:57PM +0000, Tim Kryger wrote:
> Add the binding description for the kona-pwm block found on Broadcom's
> mobile SoCs.
> 
> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Alex Elder <elder@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> ---
>  .../devicetree/bindings/pwm/bcm-kona-pwm.txt       | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/bcm-kona-pwm.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/bcm-kona-pwm.txt b/Documentation/devicetree/bindings/pwm/bcm-kona-pwm.txt
> new file mode 100644
> index 0000000..5c3ea1b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/bcm-kona-pwm.txt
> @@ -0,0 +1,24 @@
> +Broadcom's PWM Controller Device Tree bindings
> +
> +Broadcom's Kona PWM Controller has 6 channels
> +
> +Required Properties :
> +- compatible: should be "brcm,kona-pwm"
> +- reg: physical base address and length of the controller's registers
> +- clocks: clock specifier for the kona pwm external clock

Minor nit: phandle + clock-specifier pair

> +- #pwm-cells: should be 2.  The first cell specifies the per-chip index
> +  of the PWM to use and the second cell is the period in nanoseconds.
> +
> +Refer to pwm/pwm.txt for generic pwm controller node properties.
> +
> +Refer to clocks/clock-bindings.txt for generic clock consumer
> +properties
> +
> +Example:
> +
> +pwm: pwm at 3e01a000 {
> +	compatible = "brcm,bcm11351-pwm", "brcm,kona-pwm";
> +	reg = <0x3e01a000 0xc4>;
> +	clocks = <&pwm_clk>;
> +	#pwm-cells = <2>;
> +};

Otherwise this looks fine.

Mark.
