From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 24 Sep 2015 23:00:09 +0800
Subject: [linux-sunxi][alsa-devel][PATCH 2/3] dt-binding: Add sunxi SPDIF
 machine driver
In-Reply-To: <1443031494-32469-3-git-send-email-codekipper@gmail.com>
References: <1443031494-32469-1-git-send-email-codekipper@gmail.com>
 <1443031494-32469-3-git-send-email-codekipper@gmail.com>
Message-ID: <CAGb2v65QP_+zO19B5zWpeww=yorXzftE2oo9kwhEY3pCVuXTnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2015 at 2:04 AM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> Add device tree bindings for the SPDIF machine driver for Allwinner SoC
> devices.

Is there a particular reason for having 2 separate bindings for one piece of
hardware?

Also, both this binding and the driver bits look almost like imx-audio-spdif.
This seems like unneeded duplication. Can we generalize that and use it? Or
just use simple-card?


Regards
ChenYu

> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  .../bindings/sound/sunxi-audio-spdif.txt           | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/sunxi-audio-spdif.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/sunxi-audio-spdif.txt b/Documentation/devicetree/bindings/sound/sunxi-audio-spdif.txt
> new file mode 100644
> index 0000000..b9e8152
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/sunxi-audio-spdif.txt
> @@ -0,0 +1,36 @@
> +Allwinner audio complex with S/PDIF transceiver
> +
> +Required properties:
> +
> +  - compatible         : "Allwinner,sunxi-audio-spdif"
> +
> +  - model              : The user-visible name of this sound complex
> +
> +  - spdif-controller   : The phandle of the Allwinner S/PDIF controller
> +
> +
> +Optional properties:
> +
> +  - spdif-out          : This is a boolean property. If present, the
> +                         transmitting function of S/PDIF will be enabled,
> +                         indicating there's a physical S/PDIF out connector
> +                         or jack on the board or it's connecting to some
> +                         other IP block, such as an HDMI encoder or
> +                         display-controller.
> +
> +  - spdif-in           : This is a boolean property. If present, the receiving
> +                         function of S/PDIF will be enabled, indicating there
> +                         is a physical S/PDIF in connector/jack on the board.
> +
> +* Note: At least one of these two properties should be set in the DT binding.
> +
> +
> +Example:
> +
> +sound-spdif {
> +       compatible = "allwinner,sunxi-audio-spdif";
> +       model = "sunxi-spdif";
> +       spdif-controller = <&spdif>;
> +       spdif-out;
> +       spdif-in;
> +};
> --
> 2.5.3
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
