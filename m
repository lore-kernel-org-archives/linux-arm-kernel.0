From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 20 Nov 2014 11:11:09 +0100
Subject: [alsa-devel] [PATCH] ASoC: samsung: Fix IISMOD setting in
 i2s_set_sysclk()
In-Reply-To: <CAAgF-BemHSdcmzkqOUX+JNMLu0-GXs0EGm8YWHt+CBRP8Wa5DA@mail.gmail.com>
References: <1416420664-20952-1-git-send-email-s.nawrocki@samsung.com>
 <CAAgF-BemHSdcmzkqOUX+JNMLu0-GXs0EGm8YWHt+CBRP8Wa5DA@mail.gmail.com>
Message-ID: <546DBE3D.90206@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 20/11/14 08:04, Padma Venkat wrote:
>> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
>> > index 947352d..8db8c66 100644
>> > --- a/sound/soc/samsung/i2s.c
>> > +++ b/sound/soc/samsung/i2s.c
>> > @@ -494,7 +494,7 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
>> >  		if (dir == SND_SOC_CLOCK_IN)
>> >  			mod |= 1 << i2s_regs->cdclkcon_off;
>> >  		else
>> > -			mod &= 0 << i2s_regs->cdclkcon_off;
>> > +			mod &= ~(1 << i2s_regs->cdclkcon_off);
>
> Thanks for pointing this. In my local machine it was properly done but
> while rebasing on linux-next I did some mistake. There is one more
> place in set_sysclk which need to be corrected here
> mod &= 0 << i2s_regs->rclksrc_off
> can you include this change also in your patch or should I post a new
> patch for all?

OK, I'll also correct this and resend the patch.

-- 
Regards,
Sylwester
