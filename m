From: florian.kauer@koalo.de (Florian Kauer)
Date: Wed, 15 Feb 2017 13:37:08 +0100
Subject: [PATCH v4] ASoC: bcm2835: Add 8 channel (multitrack) capability
In-Reply-To: <1487106275-4260-1-git-send-email-flatmax@flatmax.org>
References: <1486942035-24038-1-git-send-email-flatmax@flatmax.org>
 <1487106275-4260-1-git-send-email-flatmax@flatmax.org>
Message-ID: <88f46323-d243-e1af-c294-e1f844d366d0@koalo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2017 10:04 PM, Matt Flax wrote:
> This patch adds multitrack capability if in DSP mode A and the
> codec is master.
> 
> In bcm2835_i2s_startup, snd_pcm_hw_constraint_single is used to set
> channels to 8 if both SND_SOC_DAIFMT_CBM_CFM and SND_SOC_DAIFMT_DSP_A
> are set. Otherwise, channels are set to 2. These settings are
> accomplished using the SNDRV_PCM_HW_PARAM_CHANNELS variable.
> 
> In bcm2835_i2s_shutdown the channels are set to 2 by default.
> 
> In bcm2835_i2s_hw_params, DSP mode A format is now an option.
> Before replicating the format variable (from ch2 to ch1) for
> register loading, requested channels are checked to be either 2 or 8.
> This can be expanded later to accomodate other channel counts if
> supported by the sound card hardware.
> 
> Signed-off-by: Matt Flax <flatmax@flatmax.org>
> ---

Acked-by: Florian Kauer <florian.kauer@koalo.de>

Looks good and is a much better approach than just adding the additional
case.

Greetings,
Florian
