From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 1 Sep 2018 18:24:38 -0300
Subject: [PATCH 2/3] arm64: dts: meson-axg: s400: add dmic codec
In-Reply-To: <20180831150218.8307-3-jbrunet@baylibre.com>
References: <20180831150218.8307-1-jbrunet@baylibre.com>
 <20180831150218.8307-3-jbrunet@baylibre.com>
Message-ID: <CAOMZO5BOMOB6LaRs1fnmm-Ghu7pMkXW=sH_NOEWK3pqHAbUMCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome,

On Fri, Aug 31, 2018 at 12:02 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:
> There are 7 digital mics on the MIC daughter board attached
> to the s400 board, so add the digital microphone codec to
> its DTS
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> index ff64c429d432..f3e16cbbc61e 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> @@ -86,6 +86,15 @@
>                 sound-name-prefix = "DIT";
>         };
>
> +       dmics: audio-codec at 3 {

You pass @3 without a corresponding reg = <3>, which causes dtc
warnings with W=1.
