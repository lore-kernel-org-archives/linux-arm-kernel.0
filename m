From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 3 Oct 2018 17:53:19 +0800
Subject: [PATCH v2] arm64: dts: rockchip: add spdif sound node for rock64
In-Reply-To: <20180917122633.31401-1-katsuhiro@katsuster.net>
References: <20180917122633.31401-1-katsuhiro@katsuster.net>
Message-ID: <CAGb2v64gTj7766o+6-BZkqKy=cDv9bqLcKHOzj-BiJOtjQMSyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 17, 2018 at 8:28 PM Katsuhiro Suzuki
<katsuhiro@katsuster.net> wrote:
>
> This patch adds sound card node for rock64. Currently we can support
> S/PDIF only. It seems the lack of codec driver of rk3328 to enable
> analog audio out.
>
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>  .../arm64/boot/dts/rockchip/rk3328-rock64.dts | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> index 5852061e497b..9ee4f57557f3 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> @@ -62,6 +62,23 @@
>                 regulator-min-microvolt = <5000000>;
>                 regulator-max-microvolt = <5000000>;
>         };
> +
> +       sound {
> +               compatible = "audio-graph-card";
> +               label = "rockchip,rk3328";

I understand that this patch has been merged. However, seeing this label
I wonder how this works when the analog codec and HDMI audio out are added,
and how userspace is supposed to select an output.

On the side, it seems that extra codecs, such as the rock64 add-on board,
are easier dealt with by adding a separate simple-audio-card node to couple
the codec and i2s nodes.

ChenYu
