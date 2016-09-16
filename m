From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Sep 2016 11:20:51 +0100
Subject: [PATCH] ARM: Kconfig: select GENERIC_CLOCKEVENTS_BROADCAST also
 on UP
In-Reply-To: <1474018340.2243.103.camel@pengutronix.de>
References: <1467993522-9176-1-git-send-email-l.stach@pengutronix.de>
 <1474018340.2243.103.camel@pengutronix.de>
Message-ID: <20160916102051.GG1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2016 at 11:32:20AM +0200, Lucas Stach wrote:
> Hi Russell,
> 
> can you please take a look at this and tell if there is something wrong
> about it, or if you think it can go in?
> 
> Without this patch the kernel is unable to use the deeper CPU idle
> states on i.MX6S if it isn't built with SMP support enabled.

Without spending a lot of time digging into this code, working out what
these configuration symbols do, I frankly don't know if it's a sensible
thing to do or not.  I guess tglx knows this code like the back of his
hand, and would be in a better position to comment.

There's two factors there:
1. the amount of undocumented code in the kernel needing the code to be
   read and understood to understand various aspects of it from the
   architecture point of view.

2. your architecture maintainer has done very little actual platform
   development (not through his own choice) for the last 10 or so years,
   which means he's not had to dig into these areas.

So, I'm afraid I feel less than qualified on this at the moment.  I'll
try to look into this and talk to tglx to work out whether it's a
sensible change.  As I never had a reply to my last email to tglx about
threaded interrupts vs tasklets (for a reported performance regression
in my crypto patches already queued for the next merge window) I'm not
hoping for much help.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
