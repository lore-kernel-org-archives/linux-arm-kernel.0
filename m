From: alexanders83@web.de (Alexander Stein)
Date: Mon, 14 Apr 2014 20:34:10 +0200
Subject: Device tree support for Atmel AC97 controller on AT91SAM9263
In-Reply-To: <534B9ECF.806@atmel.com>
References: <1397293707-26890-1-git-send-email-alexanders83@web.de>
 <534B9ECF.806@atmel.com>
Message-ID: <3514422.OSZGxjlElf@kongar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Bo,

On Monday 14 April 2014, 16:39:43 wrote Bo Shen:
> On 04/12/2014 05:08 PM, Alexander Stein wrote:
> > This set of patches add device tree support for the AC97 controller found
> > on AT91SAM9263.
> > The first two patches are minor cleanup, while the last ones add the actual
> > support.
> 
> I just test the whole patch series, and find issues to work with device 
> tree kernel.
> When we use dt kernel, no where assign the device id (so take it as 
> "-1"), so when register devices, it will be /dev/snd/pcmC0D-1p and 
> /dev/snd/pcmC0D-1c. So, the sound won't work.
> 
> The root cause is that when call "snd_pcm_new", it will pass 
> "chip->pdev->id" as parameter.
> 
> So, I am thinking whether this should be fix in <sound/atmel/ac97c.c> or 
> in <sound/core/pcm.c>

Ah. thanks for figuring out. I also noticed later that e.g. aplay actually doesn't work, but could not figure out why. pcmC0D-1c looked valid at first glance I wasn't aware that this includes a -1 :)
I was already happy that the controller found the codec.

Best regards,
Alexander
