From: maxime.ripard@free-electrons.com (maxime.ripard at free-electrons.com)
Date: Mon, 31 Mar 2014 16:46:17 +0200
Subject: [PATCH 2/4] pwm: sunxi: document OF bindings
In-Reply-To: <1396267649-18009-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1396267649-18009-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1396267649-18009-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140331144617.GH26751@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 31, 2014 at 02:07:27PM +0200, Alexandre Belloni wrote:
> This is the documentation for the Allwinner Socs PWM bindings.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Cc: devicetree at vger.kernel.org
>  Documentation/devicetree/bindings/pwm/pwm-sunxi.txt | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sunxi.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sunxi.txt b/Documentation/devicetree/bindings/pwm/pwm-sunxi.txt
> new file mode 100644
> index 000000000000..e295a50813af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sunxi.txt
> @@ -0,0 +1,19 @@
> +Allwinner PWM controller
> +
> +Required properties:
> +  - compatible: should be one of:
> +    - "allwinner,sun4i-pwm"
> +    - "allwinner,sun7i-pwm"
> +  - reg: physical base address and length of the controller's registers

You also seem to need a clocks property.

> +  - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
> +    the cells format.
> +
> +Example:
> +
> +	pwm: pwm at 01c20e00 {
> +		compatible = "allwinner,sun7i-pwm";

Like Emilio pointed out, the compatible pattern is <family>-<soc>-pwm,
so: sun4i-a10-pwm and sun7i-a20-pwm.

> +		reg = <0x01c20e00 0xc>;
> +		clocks = <&osc24M>;
> +		#pwm-cells = <3>;
> +		status = "disabled";
> +	};
> -- 
> 1.8.3.2
> 

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140331/d2a3a20a/attachment.sig>
