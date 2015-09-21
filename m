From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 21 Sep 2015 10:14:39 +0200
Subject: [PATCH v6 2/5] Documentation: bindings: document the Berlin PWM
 driver
In-Reply-To: <1442484788-15482-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1442484788-15482-1-git-send-email-antoine.tenart@free-electrons.com>
 <1442484788-15482-3-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20150921081439.GD19865@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 12:13:05PM +0200, Antoine Tenart wrote:
> Following the addition of a Berlin PWM driver, this patch adds the
> corresponding documentation.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-berlin.txt | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-berlin.txt

That's the wrong way around. You define the binding, get concensus that
it's okay and then implement the binding in the driver. Of course you'd
always provide both the binding and an implementation in the same patch
series for convenience, but that doesn't change the logical ordering.

> diff --git a/Documentation/devicetree/bindings/pwm/pwm-berlin.txt b/Documentation/devicetree/bindings/pwm/pwm-berlin.txt
> new file mode 100644
> index 000000000000..8f9bc11f8c4c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-berlin.txt
> @@ -0,0 +1,19 @@
> +Berlin PWM controller
> +
> +PWM IP found in Marvell Berlin SoCs.

This isn't a proper sentence and doesn't add much useful information. If
you want to say anything here, provide details about the PWM controller.

> +
> +Required properties:
> +- compatible: should be "marvell,berlin-pwm"
> +- reg: physical base address and length of the controller's registers
> +- clocks: phandle to the input clock

You should think about adding a clock-names property here as well.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150921/3c1d9ad9/attachment.sig>
