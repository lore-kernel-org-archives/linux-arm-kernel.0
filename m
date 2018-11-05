From: tiwai@suse.de (Takashi Iwai)
Date: Mon, 05 Nov 2018 17:11:47 +0100
Subject: [alsa-devel] [PATCH v2] staging: bcm2835-audio: interpolate audio
 delay
In-Reply-To: <C35AD288-063F-4197-A758-450CBB3B1184@eircom.net>
References: <20181022191708.GA4659@ubuntu>
 <a703f8a2-e85a-bc5b-750a-cc43ef252ba5@gmail.com>
 <EA85FEC9-B1C7-4548-88F5-F0E7BC12158E@eircom.net>
 <046aea96-e0d3-60f4-c61a-c26bb1b5c193@gmail.com>
 <B9A84822-3780-4E01-96AD-FD3B42C44B45@eircom.net>
 <9884c4f5-2343-e3a4-8d8b-dd2db404ef27@gmail.com>
 <s5hftwuo4t0.wl-tiwai@suse.de>
 <126FA055-050B-4AAC-9392-CA8CCA821768@eircom.net>
 <C35AD288-063F-4197-A758-450CBB3B1184@eircom.net>
Message-ID: <s5hsh0f1p30.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 05 Nov 2018 16:57:07 +0100,
Mike Brady wrote:
> 
> > One another thing I'd like to point out is that the value given in the
> > patch is nothing but an estimated position, optimistically calculated
> > via the system timer.  Mike and I had already discussion in another
> > thread, and another possible option would be to provide the proper
> > timestamp-vs-hwptr pair, instead of updating the timestamp always at
> > the status read.
> 
> Agreed ? that would give the caller the information needed to do the
> interpolation for themselves if desired.

And now I wonder whether the problem is still present with the latest
code.  There was a (kind of) regression in this regard when we
introduced the fine-grained hardware timestamping, but it should have
been addressed by the commit 20e3f985bb875fea4f86b04eba4b6cc29bfd6b71
    ALSA: pcm: update tstamp only if audio_tstamp changed

Could you double-check whether the tstamp field gets still updated
even if no hwptr (and delay) is changed?


thanks,

Takashi
