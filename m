From: tiwai@suse.de (Takashi Iwai)
Date: Fri, 07 Feb 2014 12:12:30 +0100
Subject: [PATCH 1/2] ALSA: hda/ca0132 - setup/cleanup streams
In-Reply-To: <s5hvbwrtchj.wl%tiwai@suse.de>
References: <1391744130-15043-1-git-send-email-hychao@chromium.org>
 <s5hvbwrtchj.wl%tiwai@suse.de>
Message-ID: <s5hppmztbvl.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Fri, 07 Feb 2014 11:59:20 +0100,
Takashi Iwai wrote:
> 
> At Fri,  7 Feb 2014 11:35:29 +0800,
> Hsin-Yu Chao wrote:
> > 
> > When a HDMI stream is opened with the same stream tag
> > as a following opened stream to ca0132, audio will be
> > heard from two ports simultaneously.
> > Fix this issue by change to use snd_hda_codec_setup_stream
> > and snd_hda_codec_cleanup_stream instead, so that an
> > inactive stream can be marked as 'dirty' when found
> > with a conflict stream tag, and then get purified.
> > 
> > Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
> > Reviewed-by: Chih-Chung Chang <chihchung@chromium.org>
> 
> Thanks, applied this one.

Hrm, not good.

sound/pci/hda/patch_ca0132.c: In function ?ca0132_playback_pcm_prepare?:
sound/pci/hda/patch_ca0132.c:2675:2: error: implicit declaration of function ?ca0132_toggle_dac_format? [-Werror=implicit-function-declaration]
  ca0132_toggle_dac_format(codec);
  ^

Please give a patch that really builds and works cleanly with the
upstream code!


thanks,

Takashi
