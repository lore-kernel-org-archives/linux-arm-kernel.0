From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 28 Nov 2013 22:32:00 +0100
Subject: [PATCHv6 4/4] Documentation: Add device tree bindings for
 Freescale FTM PWM.
In-Reply-To: <1384220218-12716-5-git-send-email-Li.Xiubo@freescale.com>
References: <1384220218-12716-1-git-send-email-Li.Xiubo@freescale.com>
 <1384220218-12716-5-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <20131128213159.GE14689@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 09:36:58AM +0800, Xiubo Li wrote:
> This adds the Document for Freescale FTM PWM driver under

s/Document/binding documentation/?

> Documentation/devicetree/bindings/pwm/.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> Acked-by: Kumar Gala <galak@codeaurora.org>
> ---
>  .../devicetree/bindings/pwm/pwm-fsl-ftm.txt        | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
> new file mode 100644
> index 0000000..5c1cd2b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
> @@ -0,0 +1,29 @@
> +Freescale FlexTimer Module(FTM) PWM controller

I think it's customary to have a space before the opening parenthesis.

> +Required properties:
> +- compatible: Should be "fsl,vf610-ftm-pwm"
> +- reg: Physical base address and length of the controller's registers
> +- #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
> +  the cells format.
> +- clock-names : Should includes the following module clock source entries:

s/includes/include/

> +    "ftm0" (module clock),
> +    "ftm0_counter" (counter clock),
> +- clocks : Must contain a clock specifier for each entry in clock-names,
> +  See clock/clock-bindings.txt for details of the property values.

Note that the order is significant here, at least from the way the
driver currently implements this. You can probably make this more
generic in the driver by using of_property_match_string() on the
clock-names property to find the index of "ftm0_counter" and pass that
index to the of_parse_phandle_with_args() function to cope with the
situation where the device tree has the clocks in a different order.

> +Example:
> +
> +pwm0: pwm at 40038000 {
> +		compatible = "fsl,vf610-ftm-pwm";
> +		reg = <0x40038000 0x1000>;
> +		#pwm-cells = <3>;
> +		clock-names = "ftm0", "ftm0_counter;

There's a missing " at the end here.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131128/6083672b/attachment-0001.sig>
