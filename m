From: eric@anholt.net (Eric Anholt)
Date: Mon, 13 Feb 2017 12:51:12 -0800
Subject: [PATCH v2] ASoC: bcm2835: Add 8 channel (multitrack) capability
In-Reply-To: <1486942035-24038-1-git-send-email-flatmax@flatmax.org>
References: <1486422576-6958-1-git-send-email-flatmax@flatmax.org>
 <1486942035-24038-1-git-send-email-flatmax@flatmax.org>
Message-ID: <87tw7xzuf3.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matt Flax <flatmax@flatmax.org> writes:

> This patch adds multitrack capability if in DSP mode A and the
> codec is master.
>
> In bcm2835_i2s_startup, snd_pcm_hw_constraint_minmax is used to set
> max channels to 8 if both SND_SOC_DAIFMT_CBM_CFM and
> SND_SOC_DAIFMT_DSP_A are set. Otherwise, max channels is set to 2.
> Min channels is always set to 2. These settings are accomplished
> using the SNDRV_PCM_HW_PARAM_CHANNELS variable.
>
> In bcm2835_i2s_shutdown max channels is set to 2 by default.
>
> In bcm2835_i2s_hw_params, DSP mode A format is now an option.
> Before replicating the format variable (from ch2 to ch1) for
> register loading, requested channels are checked to be either 2 or 8.
> This can be expaneded later to accomodate other channel counts if

"expanded"

> supported by the sound card hardware.

This is looking a lot nicer!  I'm totally deferring to the audio guys
here for deciding if it's the right fix, but for what it's worth, from
the platform side:

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170213/f78424b1/attachment.sig>
