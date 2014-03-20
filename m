From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 20 Mar 2014 13:32:24 +0100
Subject: [PATCH] ASoC: tda998x: Fix lack of required reg in DT
 documentation
In-Reply-To: <20140320092639.48F68A6279@smtp3-g21.free.fr>
References: <20140320092639.48F68A6279@smtp3-g21.free.fr>
Message-ID: <532ADFD8.80301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/2014 09:58 AM, Jean-Francois Moine wrote:
> The I2C address (reg) is required for the TDA998x driver to be loaded
> and initialized.
>
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
> This patch applies to linux-next.
> ---
>   Documentation/devicetree/bindings/drm/i2c/tda998x.txt | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
> index d7df01c..fc7effa 100644
> --- a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
> +++ b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
> @@ -3,6 +3,8 @@ Device-Tree bindings for the NXP TDA998x HDMI transmitter
>   Required properties;
>     - compatible: must be "nxp,tda998x"
>
> +  - reg: I2C address - must be <0x70>

TDA9983b datasheet says:

"Bits A0 and A1 of the I2C-bus device address are externally selected
by pins A0 and A1."

Therefore, 0x70, 0x71, 0x72, and 0x73 are valid i2c addresses.

Sebastian

>   Optional properties:
>     - interrupts: interrupt number and trigger type
>   	default: polling
>
