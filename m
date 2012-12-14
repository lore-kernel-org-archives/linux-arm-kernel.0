From: balbi@ti.com (Felipe Balbi)
Date: Fri, 14 Dec 2012 20:08:29 +0200
Subject: [PATCH 1/7] ir-rx51: Handle signals properly
In-Reply-To: <20121214180645.GW4989@atomide.com>
References: <1353251589-26143-1-git-send-email-timo.t.kokkonen@iki.fi>
 <1353251589-26143-2-git-send-email-timo.t.kokkonen@iki.fi>
 <20121120195755.GM18567@atomide.com>
 <20121214172809.GT4989@atomide.com>
 <20121214172616.GC9620@arwen.pp.htv.fi>
 <20121214174629.GV4989@atomide.com>
 <20121214174918.GA11029@arwen.pp.htv.fi>
 <20121214180645.GW4989@atomide.com>
Message-ID: <20121214180829.GA11582@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 14, 2012 at 10:06:45AM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [121214 09:59]:
> > On Fri, Dec 14, 2012 at 09:46:29AM -0800, Tony Lindgren wrote:
> > > * Felipe Balbi <balbi@ti.com> [121214 09:36]:
> > > > 
> > > > if it's really for PWM, shouldn't we be using drivers/pwm/ ??
> > > > 
> > > > Meaning that $SUBJECT would just request a PWM device and use it. That
> > > > doesn't solve the whole problem, however, as pwm-omap.c would still need
> > > > access to timer-omap.h.
> > > 
> > > That would only help with omap_dm_timer_set_pwm() I think.
> > > 
> > > The other functions are also needed by the clocksource and clockevent
> > > drivers. And tidspbridge too:
> > 
> > well, we _do_ have drivers/clocksource ;-)
> 
> That's where the dmtimer code should live. But still it does not help
> with the header.

yeah, the header should be where you suggested, no doubts. I was
actually criticizing the current timer code.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121214/977cf548/attachment.sig>
