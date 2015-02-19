From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 19 Feb 2015 14:55:02 +0100
Subject: [PATCH 1/6] ASoC: max98088: Document DT bindings
In-Reply-To: <1424283959-16289-2-git-send-email-afaerber@suse.de>
References: <1424283959-16289-1-git-send-email-afaerber@suse.de>
 <1424283959-16289-2-git-send-email-afaerber@suse.de>
Message-ID: <54E5EB36.9020007@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andreas,

On 02/18/2015 07:25 PM, Andreas F?rber wrote:
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  Documentation/devicetree/bindings/sound/max98088.txt | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/max98088.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/max98088.txt b/Documentation/devicetree/bindings/sound/max98088.txt
> new file mode 100644
> index 000000000000..6f8fe85040ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/max98088.txt
> @@ -0,0 +1,16 @@
> +MAX98088 audio CODEC
> +
> +This device supports I2C only.
> +
> +Required properties:
> +
> +- compatible : "maxim,max98088" or "maxim,max98089".
> +
> +- reg : The I2C address of the device.
> +
> +Example:
> +
> +max98089: codec at 10 {
> +	compatible = "maxim,max98089";
> +	reg = <0x10>;
> +};
>

I see that a master clock (mclk) is added in patch 6/6 but the
max98088 codec driver does handle this clock.

If the SoC XCLKOUT provides the master clock to the max98089
codec in Spring like is the case for the max9809{0,5} codecs
in the Snow and Peach Pit/Pi Chromebooks then you need to do
something along the lines of the following commits:

e3048c3d2be5 ASoC: max98095: Add master clock handling
b10ab7b838bd ASoC: max98090: Add master clock handling

If that's the case you also have to mention in the DT binding
doc that "clocks" and "clock-names" are optional properties
like Documentation/devicetree/bindings/sound/max9809{0,5}.txt.

Best regards,
Javier
