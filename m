From: eric@anholt.net (Eric Anholt)
Date: Wed, 15 Feb 2017 11:26:56 -0800
Subject: [PATCH v4] ASoC: bcm2835: Add 8 channel (multitrack) capability
In-Reply-To: <1487106275-4260-1-git-send-email-flatmax@flatmax.org>
References: <1486942035-24038-1-git-send-email-flatmax@flatmax.org>
 <1487106275-4260-1-git-send-email-flatmax@flatmax.org>
Message-ID: <87a89ns1a7.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matt Flax <flatmax@flatmax.org> writes:

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

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170215/e70917d7/attachment.sig>
