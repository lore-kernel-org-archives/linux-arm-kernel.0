From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 5 Oct 2017 23:59:29 +0800
Subject: [PATCH 20/20] ARM: dts: sun9i: Change node names to remove
 underscores
In-Reply-To: <5763e28fbe7c8e313f29a1ae2e72ddfe7e483f16.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
 <5763e28fbe7c8e313f29a1ae2e72ddfe7e483f16.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65JL5Rcq8-Pmt3C=MuoVXdfa+ZJvFBkCPg4C4O0rO-S3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 5, 2017 at 6:49 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Some boards have had node names with underscores. Remove them in favour of
> hyphens in order to reduce the DTC warnings.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 8 ++++----
>  arch/arm/boot/dts/sun9i-a80-optimus.dts     | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
> index cb337e08adab..fa09186bc6d7 100644
> --- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
> +++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
> @@ -74,7 +74,7 @@
>                 };
>         };
>
> -       wifi_pwrseq: wifi_pwrseq {
> +       wifi_pwrseq: wifi-pwrseq {
>                 compatible = "mmc-pwrseq-simple";
>                 clocks = <&ac100_rtc 1>;
>                 clock-names = "ext_clock";
> @@ -241,20 +241,20 @@
>                                 regulator-name = "vcc-pm-codec-io1";
>                         };
>
> -                       reg_ldo_io0: ldo_io0 {
> +                       reg_ldo_io0: ldo-io0 {

We can't change these. They are part of the device tree binding.
The regulator code matches against the node names.

ChenYu
