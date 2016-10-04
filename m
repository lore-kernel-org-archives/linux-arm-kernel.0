From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 4 Oct 2016 18:19:50 +0200
Subject: [PATCH 09/14] dt-bindings: sound: Add sun8i codec documentation
In-Reply-To: <a5b0bdc6b50dfcc2dc0145d00edd08fee3ce7764.1475571575.git.mylene.josserand@free-electrons.com>
References: <cover.1475571575.git.mylene.josserand@free-electrons.com>
 <a5b0bdc6b50dfcc2dc0145d00edd08fee3ce7764.1475571575.git.mylene.josserand@free-electrons.com>
Message-ID: <20161004161950.GP5228@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2016 at 11:46:22AM +0200, Myl?ne Josserand wrote:
> Add the documentation for dt-binding of the digital audio codec driver
> for sun8i SoC.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> ---
>  .../devicetree/bindings/sound/sun8i-codec.txt      | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/sun8i-codec.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/sun8i-codec.txt b/Documentation/devicetree/bindings/sound/sun8i-codec.txt
> new file mode 100644
> index 0000000..1808869
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/sun8i-codec.txt
> @@ -0,0 +1,24 @@
> +* Allwinner A23/A33 Codec
> +
> +Required properties:
> +- compatible: must be either "allwinner,sun4i-a23-codec" or
> +  "allwinner,sun7i-a33-codec"

Copy and paste issue ? :)

One compatible by line is usually favored, since when you'll add new
compatibles, you don't have to modify the context.xs

> +- reg: must contain the registers location and length
> +- interrupts: must contain the codec interrupt
> +- clocks: a list of phandle + clock-specifer pairs, one for each entry
> +  in clock-names.
> +- clock-names: should contain followings:
> +   - "apb": the parent APB clock for this controller
> +   - "codec": the parent module clock

We're usually calling them "bus" and "mod".

> +
> +Example:
> +codec: codec at 01c22e00 {
> +	#sound-dai-cells = <0>;
> +	compatible = "allwinner,sun8i-a33-codec";
> +	reg = <0x01c22e00 0x400>; /* SUNXI_AUDIO_PBASE + 0x200 */
> +	reg-names = "audio";

You don't define reg-names in your bindings, while your code relies on
it. It isn't really needed, since you have only one couple of base +
size, so it should just go away.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161004/dc85a491/attachment.sig>
