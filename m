From: gcembed@gmail.com (=?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?=)
Date: Thu, 06 Sep 2012 08:29:51 +0200
Subject: [PATCH 1/1] [ASoC] Fix v2: Revert 'ASoC: imx-ssi: Remove mono
 support'.
In-Reply-To: <1346912753-2030-1-git-send-email-gcembed@gmail.com>
References: <1346912753-2030-1-git-send-email-gcembed@gmail.com>
Message-ID: <504842DF.3060503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
Sorry I missed the patch send by Fabio earlier.
Ignore this one.
Regards,
Ga?tan Carlier.

On 09/06/2012 08:25 AM, Ga?tan Carlier wrote:
> When patch of Javier Martin is applied on linux-next-20120824
> the patch failed because comment line is missing.
>
> Signed-off-by: Ga?tan Carlier <gcembed@gmail.com>
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
> ---
>   sound/soc/fsl/imx-ssi.c |    5 ++---
>   1 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
> index 7074ae6..3c520c4 100644
> --- a/sound/soc/fsl/imx-ssi.c
> +++ b/sound/soc/fsl/imx-ssi.c
> @@ -380,14 +380,13 @@ static int imx_ssi_dai_probe(struct snd_soc_dai *dai)
>   static struct snd_soc_dai_driver imx_ssi_dai = {
>   	.probe = imx_ssi_dai_probe,
>   	.playback = {
> -		/* The SSI does not support monaural audio. */
> -		.channels_min = 2,
> +		.channels_min = 1,
>   		.channels_max = 2,
>   		.rates = SNDRV_PCM_RATE_8000_96000,
>   		.formats = SNDRV_PCM_FMTBIT_S16_LE,
>   	},
>   	.capture = {
> -		.channels_min = 2,
> +		.channels_min = 1,
>   		.channels_max = 2,
>   		.rates = SNDRV_PCM_RATE_8000_96000,
>   		.formats = SNDRV_PCM_FMTBIT_S16_LE,
>
