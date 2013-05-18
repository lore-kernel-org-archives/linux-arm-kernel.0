From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 May 2013 21:46:56 +0100
Subject: [RFC 3/4] DRM: add OF support for Dove DRM driver
In-Reply-To: <20130518194502.102caa9e@armhf>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <1368897139-25485-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1368897139-25485-4-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130518194502.102caa9e@armhf>
Message-ID: <20130518204655.GN18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 18, 2013 at 07:45:02PM +0200, Jean-Francois Moine wrote:
> It seems we are moving backwards:
> - what about the display controller?
> - how do you clone the lcd 0 output to the port B?
> - what occurs when the si5351 and the tda998x are modules?

I've no idea why you keep bringing that last point up.  I've already
told you what happens when the SI5351 is a module.  It is already not
a problem as I have already evidenced by my boot log.  So please get
that and stop repeating this same point which I've already answered,
or I will start ranting at you and we will have a massive falling out.

As for cloning output to the VGA port, that's just a matter of dealing
with the display controller.  That's _not_ difficult.

> My driver had the same layout as Russell's when I proposed it to you
> and when you insisted to handle the 2 LCDs and the 2 ports as one card.

This seems to be a misrepresentation.  So what you're saying is that
your driver originally handled the two LCDs as two separate cards.

That is _not_ the same as my driver.  My driver handles the two LCDs
as two separate CRTs of the same DRM device.  This allows X to drive
the two CRTs together in any manner it desires depending on the
capabilities of the "connectors" associated with each CRTC and the
user preferences.

> I spent 2 months to have a nice design and you put it to garbage!
> I am not happy...

Stop that right now.  If you want to start whinging about the amount of
time you've spent on this, then I can tell you now that if you have only
spent two months on this, you are a total newbie to this and your effort
is utterly insignificant compared to mine.  And you *have* touched a
nerve here by making that statement.
