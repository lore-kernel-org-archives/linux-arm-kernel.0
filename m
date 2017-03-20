From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 20 Mar 2017 19:49:03 +0800
Subject: [PATCH v3 4/5] ASoC: sun8i-codec: Convert to use
 SND_SOC_DAPM_AIF_IN
In-Reply-To: <20170318075509.3836-5-mylene.josserand@free-electrons.com>
References: <20170318075509.3836-1-mylene.josserand@free-electrons.com>
 <20170318075509.3836-5-mylene.josserand@free-electrons.com>
Message-ID: <CAGb2v6733y=UVXyhsSUK6whjWd_t_eXb1_aqnjyaj-_TFeGZqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 18, 2017 at 3:55 PM, Myl?ne Josserand
<mylene.josserand@free-electrons.com> wrote:
> Update the driver to use SND_SOC_DAPM_AIF_IN instead of
> SND_SOC_DAPM_DAC.
> Rename the interface's widgets to be more precise on which slot
> the interface is connected.
>
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> ---
>  sound/soc/sunxi/sun8i-codec.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
> index adb13fbd2006..7527ba29a5a0 100644
> --- a/sound/soc/sunxi/sun8i-codec.c
> +++ b/sound/soc/sunxi/sun8i-codec.c

[...]

> @@ -331,14 +333,14 @@ static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
>         { "DAC", NULL, "MODCLK DAC" },
>
>         /* DAC Routes */
> -       { "Digital Left DAC", NULL, "DAC" },
> -       { "Digital Right DAC", NULL, "DAC" },
> +       { "AIF1 Slot 0 Right", NULL, "DAC" },
> +       { "AIF1 Slot 0 Left", NULL, "DAC" },

Nit on the order (should be left before right), but otherwise

Acked-by: Chen-Yu Tsai <wens@csie.org>

>
>         /* DAC Mixer Routes */
>         { "Left Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback Switch",
> -         "Digital Left DAC"},
> +         "AIF1 Slot 0 Left"},
>         { "Right Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback Switch",
> -         "Digital Right DAC"},
> +         "AIF1 Slot 0 Right"},
>  };
>
>  static struct snd_soc_dai_ops sun8i_codec_dai_ops = {
> --
> 2.11.0
>
