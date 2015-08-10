From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 10 Aug 2015 21:44:11 +0200
Subject: [PATCH v2 2/5] Documentation: bindings: document the Berlin PWM
 driver
In-Reply-To: <1438248201-29222-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1438248201-29222-1-git-send-email-antoine.tenart@free-electrons.com>
 <1438248201-29222-3-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <55C8FF0B.50203@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.07.2015 11:23, Antoine Tenart wrote:
> Following the addition of a Berlin PWM driver, this patch adds the
> corresponding documentation.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>   Documentation/devicetree/bindings/pwm/pwm-berlin.txt | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pwm/pwm-berlin.txt
>
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-berlin.txt b/Documentation/devicetree/bindings/pwm/pwm-berlin.txt
> new file mode 100644
> index 000000000000..3d7ab7bfbf54
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-berlin.txt
> @@ -0,0 +1,15 @@
> +Berlin PWM controller

Just a little sentence about "PWM IP found in Marvell Berlin SoCs" ?
Besides that, this looks pretty straight-forward to me. Feel free
to add my

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

for the Berlin part of it.

Sebastian

> +Required properties:
> +- compatible: should be "marvell,berlin-pwm"
> +- reg: physical base address and length of the controller's registers
> +- #pwm-cells: should be 3. See pwm.txt in this directory for a description of
> +  the cells format.
> +
> +Example:
> +
> +pwm: pwm at f7f20000 {
> +	compatible = "marvell,berlin-pwm";
> +	reg = <0xf7f20000 0x40>;
> +	#pwm-cells = <3>;
> +}
>
