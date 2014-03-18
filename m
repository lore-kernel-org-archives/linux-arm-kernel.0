From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 18 Mar 2014 22:18:07 +0100
Subject: [PATCH v3 1/5] Documentation: dt: Add Kona PWM binding
In-Reply-To: <1394655346-30048-2-git-send-email-tim.kryger@linaro.org>
References: <1394655346-30048-1-git-send-email-tim.kryger@linaro.org>
 <1394655346-30048-2-git-send-email-tim.kryger@linaro.org>
Message-ID: <20140318211806.GG5917@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 01:15:42PM -0700, Tim Kryger wrote:
> Add the binding description for the Kona PWM controller found on Broadcom's
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
> index 0000000..c8e2d13
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/bcm-kona-pwm.txt
> @@ -0,0 +1,24 @@
> +Broadcom Kona PWM controller device tree bindings
> +
> +This controller has 6 channels.
> +
> +Required Properties :
> +- compatible: should be "brcm,kona-pwm"

This is somewhat inconsistent because the example below clearly doesn't
set the compatible property to "brcm,kona-pwm". Perhaps better wording
would be:

	- compatible: should contain "brcm,kona-pwm"

> +- reg: physical base address and length of the controller's registers
> +- clocks: phandle + clock specifier pair for the external clock
> +- #pwm-cells: should be 3.  The first cell specifies the per-chip index
> +  of the PWM to use, the second cell is the period in nanoseconds, and
> +  the third cell is the flags.

Please use the canonical description for this:

	- #pwm-cells: Should be 3. See pwm.txt in this directory for a
	  description of the cells format.

> +Refer to pwm/pwm.txt for generic pwm controller node properties.

With the above, this line should go away. But still: "pwm controller" ->
"PWM controller".

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140318/985b91ae/attachment.sig>
