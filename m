From: tony@atomide.com (Tony Lindgren)
Date: Mon, 21 Jan 2013 10:48:20 -0800
Subject: [PATCH] ARM: board-zoom: Do not request LCD panel enable GPIO
 from twl4030
In-Reply-To: <20130121183220.GH22517@atomide.com>
References: <1358774834-32463-1-git-send-email-peter.ujfalusi@ti.com>
 <20130121183220.GH22517@atomide.com>
Message-ID: <20130121184819.GM22517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [130121 10:35]:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [130121 05:30]:
> > The pin in question is muxed between GPIO7 and PWM1. For backlight control
> > there is a custom code in board-zoom-display to control the backlight.
> > No need to request the GPIO7 - which was failing since the way it is
> > requested no longer valid: twl's gpio range is allocated dynamically.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > ---
> > Hi Tony,
> > 
> > This patch is generated on top of my previous series for audio/pwm support:
> > http://www.spinics.net/lists/linux-omap/msg85085.html
> 
> Can you do a pull request for me for all the arch/arm/*omap* parts
> against v3.8-rc4 for the v3.9 merge window?
> 
> That way you can also merge the same branch into ASoC tree if needed
> as long as you keep your arch/arm/*omap* branch immutable.

Probably needs to be several branches though, at least the .dts
changes should be separate for Benoit.

Regards,

Tony
