From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 28 Jul 2012 22:39:59 +0800
Subject: [alsa-devel] [PATCH 1/1] ASoC: sgtl5000: enable VAG_POWER for
 LINE_IN
In-Reply-To: <1343387922-25227-1-git-send-email-b29396@freescale.com>
References: <1343387922-25227-1-git-send-email-b29396@freescale.com>
Message-ID: <20120728143957.GJ2128@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2012 at 07:18:42PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> LINE_IN also needs VAG_POWER on or we may hear noise when directly
> route LINE_IN to Headphone Mux.

The following is what I see from sgtl5000 data sheet about VAG_POWER.

  VAG is the internal voltage reference for the ADC and DAC.

Are you seeing any info that requires VAG_POWER in route of LINE_IN to
Headphone Mux?  Or it's only a result from your testing?

Does it also fix the noise issue you mentioned with normal recording
(LINE_IN to ADC) before?

Regards,
Shawn

> Tested on imx28evk.
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> ---
>  sound/soc/codecs/sgtl5000.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
> index 5c54b6f..df2f99d 100644
> --- a/sound/soc/codecs/sgtl5000.c
> +++ b/sound/soc/codecs/sgtl5000.c
> @@ -239,6 +239,7 @@ static const struct snd_soc_dapm_route sgtl5000_dapm_routes[] = {
>  	{"Headphone Mux", "DAC", "DAC"},	/* dac --> hp_mux */
>  	{"LO", NULL, "DAC"},			/* dac --> line_out */
>  
> +	{"LINE_IN", NULL, "VAG_POWER"},
>  	{"Headphone Mux", "LINE_IN", "LINE_IN"},/* line_in --> hp_mux */
>  	{"HP", NULL, "Headphone Mux"},		/* hp_mux --> hp */
>  
> -- 
> 1.7.0.4
