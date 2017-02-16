From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 16 Feb 2017 19:00:13 +0800
Subject: [PATCH v1 1/3] ASoC: zx-96p22: add documentation for zte's
 aud96p22 controller
In-Reply-To: <1487156110-12840-1-git-send-email-baoyou.xie@linaro.org>
References: <1487156110-12840-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20170216110012.GC8398@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 06:55:08PM +0800, Baoyou Xie wrote:
> This patch adds dt-binding documentation for zte's aud96p22 controller.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

Suggest to replace "documentation" with "bindings doc" in patch subject.

> ---
>  .../devicetree/bindings/sound/zte,zx-96p22.txt     | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/zte,zx-96p22.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/zte,zx-96p22.txt b/Documentation/devicetree/bindings/sound/zte,zx-96p22.txt
> new file mode 100644
> index 0000000..4184566
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/zte,zx-96p22.txt
> @@ -0,0 +1,24 @@
> +ZTE zx96p22 controller
> +
> +Required properties:
> + - compatible : Must be "zte,zx-aud96p22"
> + - #sound-dai-cells: Should be 0
> + - reg : Offset of I2C register for zx96p22

"zte,zx-96p22.txt", "zte,zx-aud96p22" and "zx96p22".  Can we make these
names consistent?

> +
> +Example:
> +
> +	audio_i2c0: audio_i2c0 at 1486000 {

Node name should be as generic as possible.  I think the following one
is what we want.

	audio_i2c0: i2c at 1486000 {

> +		compatible = "zte,zx296718-i2c";
> +		reg = <0x01486000 0x1000>;
> +		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clocks = <&audiocrm AUDIO_I2C0_WCLK>;
> +		clock-frequency = <1600000>;
> +		status = "ok";

Drop this 'status' property, which is not so meaningful for example in
bindings doc.

And have a newline between properties and child node.

> +		inner_codec: aud96p22 at 22 {

		aud96p22: codec at 22 {

Shawn

> +			compatible = "zte,zx-aud96p22";
> +			#sound-dai-cells = <0>;
> +			reg = <0x22>;
> +		};
> +	};
> -- 
> 2.7.4
> 
