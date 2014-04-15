From: tiwai@suse.de (Takashi Iwai)
Date: Tue, 15 Apr 2014 07:59:36 +0200
Subject: Device tree support for Atmel AC97 controller on AT91SAM9263
In-Reply-To: <20140414224710.GX2967@piout.net>
References: <1397293707-26890-1-git-send-email-alexanders83@web.de>
 <s5h38hgnvz5.wl%tiwai@suse.de> <2216396.r6UFNn5RuG@kongar>
 <20140414224710.GX2967@piout.net>
Message-ID: <s5hfvlfrv3r.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Tue, 15 Apr 2014 00:47:11 +0200,
Alexandre Belloni wrote:
> 
> On 14/04/2014 at 20:43:02 +0200, Alexander Stein wrote :
> > Hello Takashi,
> > 
> > On Monday 14 April 2014, 10:42:06 wrote Takashi Iwai:
> > > At Sat, 12 Apr 2014 11:08:23 +0200,
> > > Alexander Stein wrote:
> > > > 
> > > > This set of patches add device tree support for the AC97 controller found
> > > > on AT91SAM9263.
> > > > The first two patches are minor cleanup, while the last ones add the 
> > actual
> > > > support.
> > > 
> > > Do you really need work on this driver?  The sound/atmel/* stuff is an
> > > old one before ASoC was introduced, mostly obsoleted nowadays.
> > 
> > Ah, ok. I wasn't aware of that. But is there a replacement for the ac97c 
> > driver? All I found in sound/soc/atmel is using the SSC peripheral. Not 
> > something I can use.
> 
> I guess what Takashi wanted to say was: shouldn't we rewrite the driver
> completely to take advantage of the ASoC infrastructure ?

Yep, exactly.  Thanks for my sparse word completion :)

> I'm actually quite interesting in getting it to work as this is the la
> peripheral that doesn't have DT support on the SAM9RL.
> 
> I'll make some comments on your patches but I'm not sure whether we
> should keep that driver or move to ASoC. Maybe that could be an
> intermediate step. I'll try to have a look this week.

OK, if people think it's still useful, I can take the patches without
problems.  The changes are small and easy enough.  But, the only
condition is that it's assured that the changes / binding is
applicable to ASoC (in future, if any).  That said, it'd be great if
anyone can work on the proper integration to ASoC at the same time. 


thanks,

Takashi
