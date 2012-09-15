From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Sat, 15 Sep 2012 23:38:32 +0200
Subject: [alsa-devel] [PATCH v3 00/15] ASoC: OMAP: Convert to use dmaengine
In-Reply-To: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>
References: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <3759862.8IETAs1y1n@acer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dnia pi?tek, 14 wrze?nia 2012 15:05:43 Peter Ujfalusi pisze:
> Hello,
> 
> Changes since v2:
> - As it has been discussed the no_wakeup parameter has been replaced with flags
>   for the dmaengine APIs
> 
> Changes since v1:
> - Support for pause/resume for OMAP audio via dmaengine
> - dmaengine: support for NO_PERIOD_WAKEUP in cyclic mode
>  - OMAP to keep supporting NO_PERIOD_WAKEUP for audio
>  - Other plaforms can also try to enable this mode since we have now generic
>    interface to do so.
> 
> This series will switch the OMAP audio to use dmaengine.
> The final patch which does the switch was based on Russell King's earlier patch.
> 
> The first 10 patch is to prepare the OMAP audio drivers for a smooth change to
> dmaengine:
> - sDMA FRAME sync mode is removed and replaced with PACKET mode
> - dai drivers no longer need to configure sDMA sync mode
> - dai drivers does not need to specify the DMA word length - with the exception
>   of the omap-hdmi driver which requires 32bit word length regardless of the
>   audio format in use
> - the McPDM driver used (to my surprise) hackish way of getting the DMA channel
>   and address - via defines from some header files
> 
> After the conversion OMAP audio support should have the same features as before,
> no regressions expected.
> 
> I have tested the series on:
> - BeagleBoard (audio via McBSP): 
>  - aplay/arecord. In element mode and in threshold mode with different period
>    sizes
>  - mplayer -ao alsa: for direct ALSA access
>  - mplayer -ao pulse: via PulseAudio to test NO_PERIOD_WAKEUP feature
> - OMAP4 Blaze (audio via McPDM and DMIC)
>  - aplay/arecord
>  - mplayer -ao alsa: for direct ALSA access
>  - mplayer -ao pulse: via PulseAudio to test NO_PERIOD_WAKEUP feature
> 
> The patches has been generated against:
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-3.7
> 
> Janusz: Can you retest this series on OMAP1 to be sure I have not broken it?

Hi Peter,
It looks like you haven't :-).

For OMAP1:
Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Thanks,
Janusz
