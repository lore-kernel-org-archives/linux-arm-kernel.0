From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Jul 2018 23:35:54 +0800
Subject: [PATCH 08/17] ARM: dts: sun8i: r40: Add mixer ids to TCON TOP
In-Reply-To: <20180706175113.26698-9-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
 <20180706175113.26698-9-jernej.skrabec@siol.net>
Message-ID: <CAGb2v65YsW+SiP6_sV9Hd6eQE6ZF0+Lm6CWfNdmwpgMEHBTDgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 7, 2018 at 1:51 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Mixer has to have a way to read its id, if needed.

You should mention that this is required by the device tree binding sun4i-drm,
in the second paragraph of the first section:

    For all connections between components up to the TCONs in the display
    pipeline, when there are multiple components of the same type at the
    same depth, the local endpoint ID must be the same as the remote
    component's index.

You might also want to update the diagram for TCON TOP in the binding doc.

ChenYu

> Add them in R40 DT.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> index 2afb079a3776..1dd088d82773 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -576,9 +576,12 @@
>                                 #size-cells = <0>;
>
>                                 tcon_top_mixer0_in: port at 0 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
>                                         reg = <0>;
>
> -                                       tcon_top_mixer0_in_mixer0: endpoint {
> +                                       tcon_top_mixer0_in_mixer0: endpoint at 0 {
> +                                               reg = <0>;
>                                                 remote-endpoint = <&mixer0_out_tcon_top>;
>                                         };
>                                 };
> @@ -606,9 +609,12 @@
>                                 };
>
>                                 tcon_top_mixer1_in: port at 2 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
>                                         reg = <2>;
>
> -                                       tcon_top_mixer1_in_mixer1: endpoint {
> +                                       tcon_top_mixer1_in_mixer1: endpoint at 1 {
> +                                               reg = <1>;
>                                                 remote-endpoint = <&mixer1_out_tcon_top>;
>                                         };
>                                 };
> --
> 2.18.0
>
