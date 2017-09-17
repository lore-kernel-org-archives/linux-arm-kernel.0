From: julian.calaby@gmail.com (Julian Calaby)
Date: Sun, 17 Sep 2017 12:34:25 +1000
Subject: [linux-sunxi] [PATCH 2/4] ARM: sun8i: h3/h5: add DE2 CCU device
 node for H3
In-Reply-To: <20170911155529.62891-3-icenowy@aosc.io>
References: <20170911155529.62891-1-icenowy@aosc.io>
 <20170911155529.62891-3-icenowy@aosc.io>
Message-ID: <CAGRGNgXj6sNHzYv9zsTWSD+FULA0x4-J51ytD=mHLZb_ch-y_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Icenowy,

On Tue, Sep 12, 2017 at 1:55 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
> The DE2 in H3/H5 has a clock control unit in it, and the behavior is
> slightly different between H3 and H5.
>
> Add the common parts in H3/H5 DTSI, and add the compatible string in H3
> DTSI.
>
> The compatible string of H5 DE2 CCU will be added in a separated patch.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi    |  4 ++++
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 14 ++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> index 11240a8313c2..76a4cbc99bdb 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -85,6 +87,18 @@
>                 #size-cells = <1>;
>                 ranges;
>
> +               display_clocks: clock at 1000000 {
> +                       /* compatible is in per SoC .dtsi file */

I don't know device tree very well, but shouldn't this node be
disabled so that it doesn't do anything weird on H5? Or are nodes
without compatibles ignored?

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
